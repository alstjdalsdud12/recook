package com.springmvc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.springmvc.domain.Notice;
import com.springmvc.util.DBConnection;

public class NoticeDAO {
    
    // 1. 전체 공지사항 조회 (최신순)
    public List<Notice> selectAll() {
        List<Notice> list = new ArrayList<>();
        String sql = "SELECT * FROM notice ORDER BY n_no DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Notice notice = new Notice();
                notice.setN_no(rs.getInt("n_no"));
                notice.setN_title(rs.getString("n_title"));
                notice.setN_content(rs.getString("n_content"));
                notice.setN_datetime(rs.getString("n_datetime"));
                list.add(notice);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }
    
    // 2. 특정 공지사항 조회
    public Notice selectOne(int n_no) {
        Notice notice = null;
        String sql = "SELECT * FROM notice WHERE n_no = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, n_no);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                notice = new Notice();
                notice.setN_no(rs.getInt("n_no"));
                notice.setN_title(rs.getString("n_title"));
                notice.setN_content(rs.getString("n_content"));
                notice.setN_datetime(rs.getString("n_datetime"));
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return notice;
    }
    
    // 3. 공지사항 작성
    public int insert(Notice notice) {
        String sql = "INSERT INTO notice (n_title, n_content) VALUES (?, ?)";
        int result = 0;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, notice.getN_title());
            ps.setString(2, notice.getN_content());
            
            result = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return result;
    }
    
    // 4. 공지사항 수정
    public int update(Notice notice) {
        String sql = "UPDATE notice SET n_title = ?, n_content = ? WHERE n_no = ?";
        int result = 0;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, notice.getN_title());
            ps.setString(2, notice.getN_content());
            ps.setInt(3, notice.getN_no());
            
            result = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return result;
    }
    
    // 5. 공지사항 삭제
    public int delete(int n_no) {
        String sql = "DELETE FROM notice WHERE n_no = ?";
        int result = 0;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, n_no);
            result = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return result;
    }
}