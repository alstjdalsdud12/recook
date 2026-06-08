package com.springmvc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.springmvc.domain.Solution;
import com.springmvc.util.DBConnection;

public class SolutionDAO {

    // 1. 전체 목록 조회
    public List<Solution> selectAll() {
        List<Solution> list = new ArrayList<>();
        String sql = "SELECT s.*, m.m_nickname FROM solution s " +
                     "JOIN r_member m ON s.m_no = m.m_no " +
                     "ORDER BY s.s_no DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. 카테고리별 조회
    public List<Solution> selectByCategory(String category) {
        List<Solution> list = new ArrayList<>();
        String sql = "SELECT s.*, m.m_nickname FROM solution s " +
                     "JOIN r_member m ON s.m_no = m.m_no " +
                     "WHERE s.s_category = ? ORDER BY s.s_no DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, category);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 3. 인기 목록 조회 (조회수 기준)
    public List<Solution> selectPopular() {
        List<Solution> list = new ArrayList<>();
        String sql = "SELECT s.*, m.m_nickname FROM solution s " +
                     "JOIN r_member m ON s.m_no = m.m_no " +
                     "ORDER BY s.s_hit DESC LIMIT 10";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 4. 상세 조회
    public Solution selectOne(int s_no) {
        Solution solution = null;
        String sql = "SELECT s.*, m.m_nickname FROM solution s " +
                     "JOIN r_member m ON s.m_no = m.m_no " +
                     "WHERE s.s_no = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, s_no);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                solution = mapRow(rs);
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return solution;
    }

    // 5. 등록
    public void insert(Solution solution) {
        String sql = "INSERT INTO solution (m_no, s_category, s_title, s_summary, s_content, s_image) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, solution.getM_no());
            pstmt.setString(2, solution.getS_category());
            pstmt.setString(3, solution.getS_title());
            pstmt.setString(4, solution.getS_summary());
            pstmt.setString(5, solution.getS_content());
            pstmt.setString(6, solution.getS_image());
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 6. 조회수 증가
    public void updateHit(int s_no) {
        String sql = "UPDATE solution SET s_hit = s_hit + 1 WHERE s_no = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, s_no);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 7. 삭제
    public void delete(int s_no) {
        String sql = "DELETE FROM solution WHERE s_no = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, s_no);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ResultSet 매핑
    private Solution mapRow(ResultSet rs) throws Exception {
        Solution s = new Solution();
        s.setS_no(rs.getInt("s_no"));
        s.setM_no(rs.getInt("m_no"));
        s.setS_category(rs.getString("s_category"));
        s.setS_title(rs.getString("s_title"));
        s.setS_summary(rs.getString("s_summary"));
        s.setS_content(rs.getString("s_content"));
        s.setS_image(rs.getString("s_image"));
        s.setS_hit(rs.getInt("s_hit"));
        s.setS_datetime(rs.getString("s_datetime"));
        s.setM_nickname(rs.getString("m_nickname"));
        return s;
    }
}