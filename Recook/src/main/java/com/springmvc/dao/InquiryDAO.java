package com.springmvc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.springmvc.domain.Inquiry;
import com.springmvc.util.DBConnection;

public class InquiryDAO {
    
    // 문의 작성
    public void insert(Inquiry inquiry) {
        String sql = "INSERT INTO inquiry (i_title, i_email, i_content) VALUES (?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, inquiry.getI_title());
            pstmt.setString(2, inquiry.getI_email());
            pstmt.setString(3, inquiry.getI_content());
            
            pstmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    // 문의 목록 조회
    public List<Inquiry> selectAll() {
        List<Inquiry> list = new ArrayList<>();
        String sql = "SELECT * FROM inquiry ORDER BY i_datetime DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Inquiry inquiry = new Inquiry();
                inquiry.setI_no(rs.getInt("i_no"));
                inquiry.setI_title(rs.getString("i_title"));
                inquiry.setI_email(rs.getString("i_email"));
                inquiry.setI_content(rs.getString("i_content"));
                inquiry.setI_datetime(rs.getString("i_datetime"));
                inquiry.setI_reply(rs.getString("i_reply"));
                inquiry.setI_reply_datetime(rs.getString("i_reply_datetime"));
                list.add(inquiry);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return list;
    }
    
    // 문의 상세 조회
    public Inquiry selectOne(int i_no) {
        Inquiry inquiry = null;
        String sql = "SELECT * FROM inquiry WHERE i_no = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, i_no);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                inquiry = new Inquiry();
                inquiry.setI_no(rs.getInt("i_no"));
                inquiry.setI_title(rs.getString("i_title"));
                inquiry.setI_email(rs.getString("i_email"));
                inquiry.setI_content(rs.getString("i_content"));
                inquiry.setI_datetime(rs.getString("i_datetime"));
                inquiry.setI_reply(rs.getString("i_reply"));
                inquiry.setI_reply_datetime(rs.getString("i_reply_datetime"));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return inquiry;
    }
    
    // 답변 저장
    public void updateReply(int i_no, String i_reply) {
        String sql = "UPDATE inquiry SET i_reply = ?, i_reply_datetime = NOW() WHERE i_no = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, i_reply);
            pstmt.setInt(2, i_no);
            
            pstmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}