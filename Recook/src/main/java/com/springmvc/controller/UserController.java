package com.springmvc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.springmvc.dao.MemberDAO;
import com.springmvc.domain.Member;
import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {
    
    private MemberDAO memberDAO = new MemberDAO();
    
    // ========== 로그인 ==========
    
    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }
    
    @PostMapping("/login")
    public String login(@RequestParam(name = "id") String id, 
                        @RequestParam(name = "pw") String pw, 
                        HttpSession session, Model model) {
        MemberDAO memberDAO = new MemberDAO();
        Member member = memberDAO.selectMemberById(id);
        
        if (member != null && member.getM_pw().equals(pw)) {
            session.setAttribute("loginUser", member);
            session.setAttribute("m_no", member.getM_no());
            session.setAttribute("m_id", member.getM_id());
            session.setAttribute("m_nickname", member.getM_nickname());
            session.setAttribute("m_role", member.getM_role());
            session.setAttribute("m_email", member.getM_email());
            return "redirect:/";
        } else {
            model.addAttribute("loginError", "아이디 또는 비밀번호가 일치하지 않습니다.");
            return "login";
        }
    }
    
    // 로그아웃
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
    
    // ========== 회원가입 ==========
    
    @GetMapping("/sign_up")
    public String signUpPage() {
        return "sign_up";
    }
    
    @PostMapping("/sign_up")
    public String signUp(@RequestParam(name="nickname") String m_nickname,
                         @RequestParam(name="id") String m_id,
                         @RequestParam(name="pw") String m_pw,
                         @RequestParam(name="birthYear") String birthYear,
                         @RequestParam(name="birthMonth") String birthMonth,
                         @RequestParam(name="birthDay") String birthDay,
                         @RequestParam(name="gender") String m_gender,
                         @RequestParam(name="phone") String m_phone,
                         @RequestParam(name="email") String m_email,
                         Model model) {
        
        if (memberDAO.checkIdDuplicate(m_id)) {
            model.addAttribute("signUpError", "이미 존재하는 아이디입니다.");
            return "sign_up";
        }
        
        String m_birth = "";
        if (!birthYear.isEmpty() && !birthMonth.isEmpty() && !birthDay.isEmpty()) {
            String month = String.format("%02d", Integer.parseInt(birthMonth));
            String day = String.format("%02d", Integer.parseInt(birthDay));
            m_birth = birthYear + "-" + month + "-" + day;
        }
        
        Member member = new Member();
        member.setM_nickname(m_nickname);
        member.setM_id(m_id);
        member.setM_pw(m_pw);
        member.setM_birth(m_birth);
        member.setM_gender(m_gender);
        member.setM_phone(m_phone);
        member.setM_email(m_email);
        
        int result = memberDAO.insertMember(member);
        
        if (result > 0) {
            return "redirect:/login";
        } else {
            model.addAttribute("signUpError", "회원가입 중 오류가 발생했습니다.");
            return "sign_up";
        }
    }
    
    // ========== 아이디 찾기 ==========
    
    @GetMapping("/find_id")
    public String findIdPage() {
        return "find_id";
    }
    
    @PostMapping("/find_id")
    public String findId(@RequestParam(name="nickname") String m_nickname,
                         @RequestParam(name="email") String m_email,
                         Model model) {
        
        Member member = memberDAO.selectMemberByNicknameAndEmail(m_nickname, m_email);
        
        if (member != null) {
            model.addAttribute("result", "찾으신 아이디는 <strong>" + member.getM_id() + "</strong> 입니다.");
        } else {
            model.addAttribute("result", "일치하는 회원 정보가 없습니다.");
        }
        
        return "find_id";
    }
    
    // ========== 비밀번호 찾기 ==========
    
    @PostMapping("/find_pw")
    public String findPw(@RequestParam(name="id") String m_id,
                         @RequestParam(name="email") String m_email,
                         Model model) {
        
        Member member = memberDAO.selectMemberByIdAndEmail(m_id, m_email);
        
        if (member != null) {
            model.addAttribute("result", "찾으신 비밀번호는 <strong>" + member.getM_pw() + "</strong> 입니다.");
        } else {
            model.addAttribute("result", "일치하는 회원 정보가 없습니다.");
        }
        
        return "find_pw";
    }
}

