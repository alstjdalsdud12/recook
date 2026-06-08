package com.springmvc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.springmvc.domain.Member;
import com.springmvc.util.DBConnection;

public class MemberDAO {
    
    // 1. 아이디 중복확인
    public boolean checkIdDuplicate(String m_id) {
        String sql = "SELECT * FROM r_member WHERE m_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, m_id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                rs.close();
                return true;  // 중복됨
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return false;  // 중복 안 됨
    }
    
    // 2. 회원가입 (insert)
    public int insertMember(Member member) {
        String sql = "INSERT INTO r_member (m_nickname, m_id, m_pw, m_birth, m_gender, m_phone, m_email) VALUES (?, ?, ?, ?, ?, ?, ?)";
        int result = 0;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, member.getM_nickname());
            ps.setString(2, member.getM_id());
            ps.setString(3, member.getM_pw());
            ps.setString(4, member.getM_birth());
            ps.setString(5, member.getM_gender());
            ps.setString(6, member.getM_phone());
            ps.setString(7, member.getM_email());
            
            result = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return result;
    }
    
    // 3. 로그인 (아이디로 회원 조회)
    public Member selectMemberById(String m_id) {
        Member member = null;
        String sql = "SELECT * FROM r_member WHERE m_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, m_id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                member = new Member();
                member.setM_no(rs.getInt("m_no"));
                member.setM_nickname(rs.getString("m_nickname"));
                member.setM_id(rs.getString("m_id"));
                member.setM_pw(rs.getString("m_pw"));
                member.setM_birth(rs.getString("m_birth"));
                member.setM_gender(rs.getString("m_gender"));
                member.setM_phone(rs.getString("m_phone"));
                member.setM_email(rs.getString("m_email"));
                member.setM_datetime(rs.getString("m_datetime"));
                member.setM_role(rs.getString("m_role"));
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return member;
    }
    
    // 4. 아이디 찾기 (닉네임, 이메일로 조회)
    public Member selectMemberByNicknameAndEmail(String m_nickname, String m_email) {
        Member member = null;
        String sql = "SELECT * FROM r_member WHERE m_nickname = ? AND m_email = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, m_nickname);
            ps.setString(2, m_email);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                member = new Member();
                member.setM_no(rs.getInt("m_no"));
                member.setM_nickname(rs.getString("m_nickname"));
                member.setM_id(rs.getString("m_id"));
                member.setM_pw(rs.getString("m_pw"));
                member.setM_birth(rs.getString("m_birth"));
                member.setM_gender(rs.getString("m_gender"));
                member.setM_phone(rs.getString("m_phone"));
                member.setM_email(rs.getString("m_email"));
                member.setM_datetime(rs.getString("m_datetime"));
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return member;
    }
    
    // 5. 비밀번호 찾기 (아이디, 이메일로 조회)
    public Member selectMemberByIdAndEmail(String m_id, String m_email) {
        Member member = null;
        String sql = "SELECT * FROM r_member WHERE m_id = ? AND m_email = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, m_id);
            ps.setString(2, m_email);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                member = new Member();
                member.setM_no(rs.getInt("m_no"));
                member.setM_nickname(rs.getString("m_nickname"));
                member.setM_id(rs.getString("m_id"));
                member.setM_pw(rs.getString("m_pw"));
                member.setM_birth(rs.getString("m_birth"));
                member.setM_gender(rs.getString("m_gender"));
                member.setM_phone(rs.getString("m_phone"));
                member.setM_email(rs.getString("m_email"));
                member.setM_datetime(rs.getString("m_datetime"));
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return member;
    }
 // 전체 회원 조회
    public List<Member> selectAllMembers() {
        List<Member> list = new ArrayList<>();
        String sql = "SELECT * FROM r_member ORDER BY m_datetime DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Member member = new Member();
                member.setM_no(rs.getInt("m_no"));
                member.setM_nickname(rs.getString("m_nickname"));
                member.setM_id(rs.getString("m_id"));
                member.setM_email(rs.getString("m_email"));
                member.setM_phone(rs.getString("m_phone"));
                member.setM_datetime(rs.getString("m_datetime"));
                member.setM_role(rs.getString("m_role"));
                list.add(member);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return list;
    }
    
 // 회원 수정
    public void updateMember(Member member) {
        String sql = "UPDATE r_member SET m_nickname = ?, m_email = ?, m_phone = ?, m_role = ? WHERE m_no = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, member.getM_nickname());
            pstmt.setString(2, member.getM_email());
            pstmt.setString(3, member.getM_phone());
            pstmt.setString(4, member.getM_role());
            pstmt.setInt(5, member.getM_no());
            
            pstmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 회원 삭제
    public void deleteMember(int m_no) {
        String sql = "DELETE FROM r_member WHERE m_no = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, m_no);
            pstmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 아이디로 회원 검색
    public List<Member> searchMemberById(String m_id) {
        List<Member> list = new ArrayList<>();
        String sql = "SELECT * FROM r_member WHERE m_id LIKE ? ORDER BY m_datetime DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, "%" + m_id + "%");
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Member member = new Member();
                member.setM_no(rs.getInt("m_no"));
                member.setM_nickname(rs.getString("m_nickname"));
                member.setM_id(rs.getString("m_id"));
                member.setM_email(rs.getString("m_email"));
                member.setM_phone(rs.getString("m_phone"));
                member.setM_datetime(rs.getString("m_datetime"));
                member.setM_role(rs.getString("m_role"));
                list.add(member);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return list;
    }
    
    public Member selectMember(int m_no) {
        Member member = null;
        String sql = "SELECT * FROM r_member WHERE m_no = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, m_no);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                member = new Member();
                member.setM_no(rs.getInt("m_no"));
                member.setM_id(rs.getString("m_id"));
                member.setM_nickname(rs.getString("m_nickname"));
                member.setM_email(rs.getString("m_email"));
                member.setM_phone(rs.getString("m_phone"));
                member.setM_role(rs.getString("m_role"));
                member.setM_datetime(rs.getString("m_datetime"));
                member.setM_status(rs.getString("m_status"));
                member.setM_profile_image(rs.getString("m_profile_image"));
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return member;
    }
}