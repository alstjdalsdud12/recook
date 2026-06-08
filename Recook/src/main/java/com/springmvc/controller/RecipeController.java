package com.springmvc.controller;
import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.springmvc.dao.MypageDAO;
import com.springmvc.dao.RecipeDAO;
import com.springmvc.domain.Recipe;
import com.springmvc.domain.RecipeReview;
import com.springmvc.service.GeminiService;

import jakarta.servlet.http.HttpSession;

@Controller
public class RecipeController {
    private RecipeDAO recipeDAO = new RecipeDAO();

    @Autowired
    private GeminiService geminiService;

    @GetMapping("/recipe")
    public String recipePage() {
        return "recipe";
    }

    @GetMapping("/recipe_all")
    public String allRecipe(Model model) {
        List<Recipe> recipeList = recipeDAO.selectAll();
        model.addAttribute("recipeList", recipeList);
        return "recipe_all";
    }

    @GetMapping("/recipe_rank")
    public String rankRecipe(Model model) {
        List<Recipe> rankList = recipeDAO.selectRank();
        model.addAttribute("rankList", rankList);
        return "recipe_rank";
    }

    @GetMapping("/recipe_type")
    public String typeRecipe(@RequestParam(value = "column", required = false, defaultValue = "r_type") String column,
                             @RequestParam(value = "value", required = false, defaultValue = "") String value,
                             Model model) {
        if (!value.isEmpty()) {
            List<Recipe> recipeList = recipeDAO.selectByType(column, value);
            model.addAttribute("recipeList", recipeList);
        }
        model.addAttribute("column", column);
        model.addAttribute("value", value);
        return "recipe_type";
    }

    @GetMapping("/recipe_detail")
    public String recipeDetail(@RequestParam(name = "r_no") int r_no, Model model, HttpSession session) {
        recipeDAO.updateHit(r_no);
        Recipe recipe = recipeDAO.selectOne(r_no);
        model.addAttribute("recipe", recipe);
        model.addAttribute("ingredientList", recipeDAO.selectIngredients(r_no));
        model.addAttribute("stepList", recipeDAO.selectSteps(r_no));

        List<RecipeReview> reviewList = recipeDAO.selectReviews(r_no);
        model.addAttribute("reviewList", reviewList);

        // 즐겨찾기 여부 확인
        Integer m_no = (Integer) session.getAttribute("m_no");
        if (m_no != null) {
            MypageDAO mypageDAO = new MypageDAO();
            boolean isFavorite = mypageDAO.isFavorite(m_no, r_no);
            model.addAttribute("isFavorite", isFavorite);
            mypageDAO.saveRecentView(m_no, r_no);
        } else {
            model.addAttribute("isFavorite", false);
        }

        // 댓글 요약
        if (reviewList != null && !reviewList.isEmpty()) {
            StringBuilder comments = new StringBuilder();
            for (RecipeReview review : reviewList) {
                comments.append(review.getRr_content()).append("\n");
            }
            try {
                String summary = geminiService.summarizeComments(comments.toString());
                model.addAttribute("summary", summary);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return "recipe_detail";
    }

    @GetMapping("/recipe/write")
    public String writeRecipePage(HttpSession session) {
        String m_nickname = (String) session.getAttribute("m_nickname");
        if (m_nickname == null || m_nickname.isEmpty()) {
            return "redirect:/login";
        }
        return "recipe_write";
    }

    @PostMapping("/recipe/write")
    public String writeRecipe(@ModelAttribute Recipe recipe,
                             HttpSession session,
                             @RequestParam(value = "rs_content", required = false) List<String> rs_contents,
                             @RequestParam(value = "rs_imageFile", required = false) List<MultipartFile> rs_imageFiles,
                             @RequestParam(value = "ri_name", required = false) List<String> ri_names,
                             @RequestParam(value = "ri_quantity", required = false) List<String> ri_quantities,
                             @RequestParam(value = "ri_unit", required = false) List<String> ri_units,
                             @RequestParam(value = "ri_note", required = false) List<String> ri_notes) {

        int m_no = (int) session.getAttribute("m_no");
        recipe.setM_no(m_no);

        MultipartFile r_imageFile = recipe.getR_imageFile();
        if (r_imageFile != null && !r_imageFile.isEmpty()) {
            try {
                String fileName = System.currentTimeMillis() + "_" + r_imageFile.getOriginalFilename();
                String uploadDir = "C:\\RE_cook\\upload";
                File dir = new File(uploadDir);
                if (!dir.exists()) dir.mkdirs();
                r_imageFile.transferTo(new File(uploadDir + "\\" + fileName));
                recipe.setR_image(fileName);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        int r_no = recipeDAO.insert(recipe);

        if (ri_names != null) {
            for (int i = 0; i < ri_names.size(); i++) {
                String name = ri_names.get(i);
                if (name == null || name.trim().isEmpty()) continue;
                double quantity = 0;
                try {
                    quantity = Double.parseDouble(ri_quantities.get(i));
                } catch (Exception e) {}
                String unit = ri_units != null && i < ri_units.size() ? ri_units.get(i) : "";
                String note = ri_notes != null && i < ri_notes.size() ? ri_notes.get(i) : "";
                recipeDAO.insertIngredient(r_no, name, quantity, unit, note);
            }
        }

        if (rs_contents != null) {
            for (int i = 0; i < rs_contents.size(); i++) {
                String rs_content = rs_contents.get(i);
                String rs_image = null;

                if (rs_imageFiles != null && i < rs_imageFiles.size()) {
                    MultipartFile stepImage = rs_imageFiles.get(i);
                    if (stepImage != null && !stepImage.isEmpty()) {
                        try {
                            String fileName = System.currentTimeMillis() + "_" + stepImage.getOriginalFilename();
                            String uploadDir = "C:\\RE_cook\\upload";
                            stepImage.transferTo(new File(uploadDir + "\\" + fileName));
                            rs_image = fileName;
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }
                recipeDAO.insertStep(r_no, i + 1, rs_content, rs_image);
            }
        }

        return "redirect:/recipe";
    }

    @PostMapping("/recipe/review")
    public String submitReview(@RequestParam("r_no") int r_no,
                               @RequestParam("rr_content") String rr_content,
                               @RequestParam("rr_rating") int rr_rating,
                               @RequestParam(value = "rr_image", required = false) MultipartFile rr_image,
                               HttpSession session) {

        int m_no = (int) session.getAttribute("m_no");

        RecipeReview review = new RecipeReview();
        review.setR_no(r_no);
        review.setM_no(m_no);
        review.setRr_content(rr_content);
        review.setRr_rating(rr_rating);

        if (rr_image != null && !rr_image.isEmpty()) {
            try {
                String fileName = System.currentTimeMillis() + "_" + rr_image.getOriginalFilename();
                String uploadDir = "C:\\RE_cook\\upload";
                rr_image.transferTo(new File(uploadDir + "\\" + fileName));
                review.setRr_image(fileName);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        recipeDAO.insertReview(review);
        return "redirect:/recipe_detail?r_no=" + r_no;
    }

    @PostMapping("/recipe/report")
    public String reportRecipe(
            @RequestParam("r_no") int r_no,
            @RequestParam("rp_reason") String rp_reason,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        Integer m_no = (Integer) session.getAttribute("m_no");
        if (m_no == null) return "redirect:/login";

        recipeDAO.insertReport(r_no, m_no, rp_reason);
        redirectAttributes.addFlashAttribute("reportSuccess", "신고가 접수되었습니다.");
        return "redirect:/recipe_detail?r_no=" + r_no;
    }
}