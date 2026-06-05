package com.springmvc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


import com.springmvc.dao.FavoriteDAO;
import com.springmvc.dao.MemberDAO;
import com.springmvc.domain.Member;

import jakarta.servlet.http.HttpSession;

@Controller
public class MyPageController {

    @GetMapping("/mypage")
    public String mypage(
            HttpSession session,
            Model model) {

        Integer m_no =
                (Integer) session.getAttribute("m_no");

        if (m_no == null) {

            return "redirect:/login";
        }

        MemberDAO dao =
                new MemberDAO();

        Member member =
                dao.selectMemberByNo(m_no);

        int recipeCount =
                dao.getRecipeCount(m_no);

        model.addAttribute(
                "member",
                member);

        model.addAttribute(
                "recipeCount",
                recipeCount);
        
        FavoriteDAO favoriteDAO =
                new FavoriteDAO();

        int favoriteCount =
                favoriteDAO.getFavoriteCount(
                        m_no);

        model.addAttribute(
                "favoriteCount",
                favoriteCount);

        return "mypage";
    }

    @GetMapping("/edit_profile")
    public String editProfile() {
        return "edit_profile";
    }

    @GetMapping("/my_favorite")
    public String myFavorite(
            HttpSession session,
            Model model) {

        Integer m_no =
                (Integer)session.getAttribute("m_no");

        if(m_no == null){

            return "redirect:/login";
        }

        FavoriteDAO dao =
                new FavoriteDAO();

        model.addAttribute(
                "favoriteList",
                dao.selectFavoriteList(m_no));

        return "my_favorite";
    }

    @GetMapping("/my_look")
    public String myLook() {
        return "my_look";
    }

    @GetMapping("/coupon")
    public String coupon() {
        return "coupon";
    }
   
}