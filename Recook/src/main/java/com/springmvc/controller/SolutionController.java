package com.springmvc.controller;

import java.io.File;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.springmvc.dao.SolutionDAO;
import com.springmvc.domain.Solution;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/solution")
public class SolutionController {

    private SolutionDAO solutionDAO = new SolutionDAO();
    private String uploadDir = "C:\\RE_cook\\upload";

    @GetMapping("")
    public String solutionPage() {
        return "solution";
    }

    @GetMapping("/kitchen")
    public String kitchenPage(Model model) {
        List<Solution> list = solutionDAO.selectByCategory("kitchen");
        model.addAttribute("solutionList", list);
        return "kitchen";
    }

    @GetMapping("/ingredients")
    public String ingredientsPage(Model model) {
        List<Solution> list = solutionDAO.selectByCategory("ingredients");
        model.addAttribute("solutionList", list);
        return "ingredients";
    }

    @GetMapping("/all")
    public String allSolutionPage(Model model) {
        List<Solution> list = solutionDAO.selectAll();
        model.addAttribute("solutionList", list);
        return "all_solution";
    }

    @GetMapping("/popular")
    public String popularSolutionPage(Model model) {
        List<Solution> list = solutionDAO.selectPopular();
        model.addAttribute("solutionList", list);
        return "popular_solution";
    }

    @GetMapping("/detail")
    public String solutionDetailPage(@RequestParam("s_no") int s_no, Model model) {
        solutionDAO.updateHit(s_no);
        Solution solution = solutionDAO.selectOne(s_no);
        model.addAttribute("solution", solution);
        return "solution_detail";
    }

    @GetMapping("/write")
    public String showWriteForm(HttpSession session) {
        if (session.getAttribute("m_no") == null) return "redirect:/login";
        return "solution_write";
    }

    @PostMapping("/insert")
    public String insertSolution(
            @RequestParam("category") String category,
            @RequestParam("title") String title,
            @RequestParam("summary") String summary,
            @RequestParam("content") String content,
            @RequestParam(value = "image", required = false) MultipartFile image,
            HttpSession session,
            RedirectAttributes rttr) {

        Integer m_no = (Integer) session.getAttribute("m_no");
        if (m_no == null) return "redirect:/login";

        Solution solution = new Solution();
        solution.setM_no(m_no);
        solution.setS_category(category);
        solution.setS_title(title);
        solution.setS_summary(summary);
        solution.setS_content(content);

        if (image != null && !image.isEmpty()) {
            try {
                String fileName = System.currentTimeMillis() + "_" + image.getOriginalFilename();
                File dir = new File(uploadDir);
                if (!dir.exists()) dir.mkdirs();
                image.transferTo(new File(uploadDir + "\\" + fileName));
                solution.setS_image(fileName);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        solutionDAO.insert(solution);
        rttr.addFlashAttribute("message", "당신의 소중한 지혜가 아카이브에 기록되었습니다.");
        return "redirect:/solution/" + category;
    }

    @GetMapping("/success")
    public String showSuccessPage() {
        return "solution_success";
    }
}