package com.springmvc.controller;

import java.io.File;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.springmvc.dao.MemberDAO;
import com.springmvc.dao.MypageDAO;
import com.springmvc.dao.NotificationDAO;
import com.springmvc.dao.RecipeDAO;
import com.springmvc.domain.Coupon;
import com.springmvc.domain.Member;
import com.springmvc.domain.Recipe;

import jakarta.servlet.http.HttpSession;

@Controller
public class MypageController {

    private MypageDAO mypageDAO = new MypageDAO();
    private RecipeDAO recipeDAO = new RecipeDAO();
    private MemberDAO memberDAO = new MemberDAO();
    private String uploadDir = "C:\\RE_cook\\upload";

    @GetMapping("/mypage")
    public String mypage(HttpSession session, Model model) {
        Integer m_no = (Integer) session.getAttribute("m_no");
        if (m_no == null) return "redirect:/login";

        Member member = memberDAO.selectMember(m_no);
        int myRecipeCount = mypageDAO.countMyRecipes(m_no);
        int favoriteCount = mypageDAO.countFavorites(m_no);
        int recentViewCount = mypageDAO.countRecentViews(m_no);
        int couponCount = mypageDAO.countCoupons(m_no);  // 여기 추가
        int totalRecipes = myRecipeCount;

        // 등급 계산
        String grade;
        if (totalRecipes >= 70) grade = "⚫⚪ 흑백요리사";
        else if (totalRecipes >= 40) grade = "🍽 셰프";
        else if (totalRecipes >= 20) grade = "👨‍🍳 주방장";
        else if (totalRecipes >= 10) grade = "🥘 주부";
        else if (totalRecipes >= 3) grade = "🍜 자취생";
        else grade = "🌱 새싹 요리사";

        model.addAttribute("member", member);
        model.addAttribute("grade", grade);
        model.addAttribute("myRecipeCount", myRecipeCount);
        model.addAttribute("favoriteCount", favoriteCount);
        model.addAttribute("recentViewCount", recentViewCount);
        model.addAttribute("couponCount", couponCount);  // 여기 추가

        return "mypage";
    }

    // 상태메시지 수정
    @PostMapping("/mypage/status")
    public String updateStatus(@RequestParam("m_status") String m_status, HttpSession session) {
        Integer m_no = (Integer) session.getAttribute("m_no");
        if (m_no == null) return "redirect:/login";
        mypageDAO.updateStatus(m_no, m_status);
        return "redirect:/mypage";
    }

    @PostMapping("/mypage/profile-image")
    public String updateProfileImage(
            @RequestParam("profileImage") MultipartFile profileImage,
            HttpSession session) {
        Integer m_no = (Integer) session.getAttribute("m_no");
        System.out.println("=== 프로필 이미지 업로드 ===");
        System.out.println("m_no: " + m_no);
        if (m_no == null) return "redirect:/login";

        if (profileImage != null && !profileImage.isEmpty()) {
            System.out.println("파일명: " + profileImage.getOriginalFilename());
            try {
                String fileName = System.currentTimeMillis() + "_" + profileImage.getOriginalFilename();
                File dir = new File(uploadDir);
                if (!dir.exists()) dir.mkdirs();
                profileImage.transferTo(new File(uploadDir + "\\" + fileName));
                System.out.println("✅ 저장 성공: " + fileName);
                mypageDAO.updateProfileImage(m_no, fileName);
            } catch (Exception e) {
                System.out.println("❌ 저장 실패: " + e.getMessage());
                e.printStackTrace();
            }
        } else {
            System.out.println("❌ 파일 없음");
        }
        return "redirect:/mypage";
    }

    // 내가 쓴 레시피
    @GetMapping("/my_recipe")
    public String myRecipe(HttpSession session, Model model) {
        Integer m_no = (Integer) session.getAttribute("m_no");
        if (m_no == null) return "redirect:/login";

        List<Recipe> myRecipeList = mypageDAO.selectMyRecipes(m_no);
        model.addAttribute("myRecipeList", myRecipeList);
        return "my_recipe";
    }

    // 즐겨찾기
    @GetMapping("/my_favorite")
    public String myFavorite(HttpSession session, Model model) {
        Integer m_no = (Integer) session.getAttribute("m_no");
        if (m_no == null) return "redirect:/login";

        List<Recipe> favoriteList = mypageDAO.selectFavorites(m_no);
        model.addAttribute("favoriteList", favoriteList);
        return "my_favorite";
    }

    // 즐겨찾기 추가/삭제
    @GetMapping("/mypage/favorite/toggle")
    public String toggleFavorite(
            @RequestParam("r_no") int r_no,
            HttpSession session) {
        Integer m_no = (Integer) session.getAttribute("m_no");
        if (m_no == null) return "redirect:/login";
        mypageDAO.toggleFavorite(m_no, r_no);
        return "redirect:/recipe_detail?r_no=" + r_no;
    }

    // 최근 본 레시피
    @GetMapping("/my_look")
    public String myLook(HttpSession session, Model model) {
        Integer m_no = (Integer) session.getAttribute("m_no");
        if (m_no == null) return "redirect:/login";

        List<Recipe> recentViewList = mypageDAO.selectRecentViews(m_no);
        model.addAttribute("recentViewList", recentViewList);
        return "my_look";
    }
    
    @GetMapping("/coupon")
    public String coupon(HttpSession session, Model model) {
        Integer m_no = (Integer) session.getAttribute("m_no");
        if (m_no == null) return "redirect:/login";
        List<Coupon> couponList = mypageDAO.selectCoupons(m_no);
        model.addAttribute("couponList", couponList);
        model.addAttribute("couponCount", couponList.size());
        return "coupon";
    }

    @GetMapping("/edit_profile")
    public String editProfile(HttpSession session, Model model) {
        Integer m_no = (Integer) session.getAttribute("m_no");
        if (m_no == null) return "redirect:/login";
        Member member = memberDAO.selectMember(m_no);
        model.addAttribute("member", member);
        return "edit_profile";
    }
    
    @PostMapping("/edit_profile/save")
    public String saveProfile(
            @RequestParam("m_no") int m_no,
            @RequestParam("m_nickname") String m_nickname,
            @RequestParam(value = "m_pw", required = false) String m_pw,
            @RequestParam(value = "m_pw_check", required = false) String m_pw_check,
            @RequestParam("m_phone") String m_phone,
            @RequestParam("m_email") String m_email,
            HttpSession session) {

        Member member = new Member();
        member.setM_no(m_no);
        member.setM_nickname(m_nickname);
        member.setM_phone(m_phone);
        member.setM_email(m_email);

        // 비밀번호 변경 시에만
        if (m_pw != null && !m_pw.isEmpty() && m_pw.equals(m_pw_check)) {
            member.setM_pw(m_pw);
        }

        mypageDAO.updateProfile(m_no, member);

        // 세션 닉네임 업데이트
        session.setAttribute("m_nickname", m_nickname);

        return "redirect:/mypage";
    }
    
    @GetMapping("/notification")
    public String notification(HttpSession session, Model model) {
        Integer m_no = (Integer) session.getAttribute("m_no");
        if (m_no == null) return "redirect:/login";

        NotificationDAO notificationDAO = new NotificationDAO();
        notificationDAO.markAllRead(m_no);
        model.addAttribute("notificationList", notificationDAO.selectAll(m_no));
        return "notification";
    }
}