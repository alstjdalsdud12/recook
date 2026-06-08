package com.springmvc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.springmvc.domain.Notification;
import com.springmvc.util.DBConnection;

public class NotificationDAO {

    // 1. 알림 등록
    public void insert(int m_no, String n_content) {
        String sql = "INSERT INTO notification (m_no, n_content) VALUES (?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, m_no);
            pstmt.setString(2, n_content);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 2. 알림 목록 조회
    public List<Notification> selectAll(int m_no) {
        List<Notification> list = new ArrayList<>();
        String sql = "SELECT * FROM notification WHERE m_no = ? ORDER BY n_datetime DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, m_no);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Notification n = new Notification();
                n.setN_no(rs.getInt("n_no"));
                n.setM_no(rs.getInt("m_no"));
                n.setN_content(rs.getString("n_content"));
                n.setN_read(rs.getInt("n_read"));
                n.setN_datetime(rs.getString("n_datetime"));
                list.add(n);
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 3. 읽지 않은 알림 수
    public int countUnread(int m_no) {
        String sql = "SELECT COUNT(*) FROM notification WHERE m_no = ? AND n_read = 0";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, m_no);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) return rs.getInt(1);
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // 4. 알림 읽음 처리
    public void markRead(int n_no) {
        String sql = "UPDATE notification SET n_read = 1 WHERE n_no = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, n_no);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 5. 전체 읽음 처리
    public void markAllRead(int m_no) {
        String sql = "UPDATE notification SET n_read = 1 WHERE m_no = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, m_no);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}