package com.springmvc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.springmvc.domain.Coupon;
import com.springmvc.domain.Member;
import com.springmvc.domain.Recipe;
import com.springmvc.util.DBConnection;

public class MypageDAO {


    // 2. 내가 쓴 레시피 수
    public int countMyRecipes(int m_no) {
        String sql = "SELECT COUNT(*) FROM recipe WHERE m_no = ?";

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

    // 3. 즐겨찾기 수
    public int countFavorites(int m_no) {
        String sql = "SELECT COUNT(*) FROM favorite WHERE m_no = ?";

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

    // 4. 최근 본 레시피 수
    public int countRecentViews(int m_no) {
        String sql = "SELECT COUNT(*) FROM recent_view WHERE m_no = ?";

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

    // 5. 상태메시지 수정
    public void updateStatus(int m_no, String m_status) {
        String sql = "UPDATE r_member SET m_status = ? WHERE m_no = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, m_status);
            pstmt.setInt(2, m_no);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 6. 프로필 이미지 수정
    public void updateProfileImage(int m_no, String fileName) {
        String sql = "UPDATE r_member SET m_profile_image = ? WHERE m_no = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, fileName);
            pstmt.setInt(2, m_no);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 7. 내가 쓴 레시피 목록
    public List<Recipe> selectMyRecipes(int m_no) {
        List<Recipe> list = new ArrayList<>();
        String sql = "SELECT r.*, m.m_nickname, " +
                     "COALESCE(AVG(rr.rr_rating), 0) AS avg_rating, " +
                     "COUNT(rr.rr_no) AS review_count " +
                     "FROM recipe r " +
                     "JOIN r_member m ON r.m_no = m.m_no " +
                     "LEFT JOIN recipe_review rr ON r.r_no = rr.r_no " +
                     "WHERE r.m_no = ? " +
                     "GROUP BY r.r_no, m.m_nickname " +
                     "ORDER BY r.r_no DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, m_no);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Recipe recipe = new Recipe();
                recipe.setR_no(rs.getInt("r_no"));
                recipe.setR_title(rs.getString("r_title"));
                recipe.setR_image(rs.getString("r_image"));
                recipe.setR_hit(rs.getInt("r_hit"));
                recipe.setR_content(rs.getString("r_content"));
                recipe.setR_datetime(rs.getString("r_datetime"));
                recipe.setM_no(rs.getInt("m_no"));
                recipe.setM_nickname(rs.getString("m_nickname"));
                recipe.setR_type(rs.getString("r_type"));
                recipe.setR_difficulty(rs.getString("r_difficulty"));
                recipe.setAvg_rating(rs.getDouble("avg_rating"));
                recipe.setReview_count(rs.getInt("review_count"));
                list.add(recipe);
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 8. 즐겨찾기 목록
    public List<Recipe> selectFavorites(int m_no) {
        List<Recipe> list = new ArrayList<>();
        String sql = "SELECT r.*, m.m_nickname, " +
                     "COALESCE(AVG(rr.rr_rating), 0) AS avg_rating, " +
                     "COUNT(rr.rr_no) AS review_count " +
                     "FROM favorite f " +
                     "JOIN recipe r ON f.r_no = r.r_no " +
                     "JOIN r_member m ON r.m_no = m.m_no " +
                     "LEFT JOIN recipe_review rr ON r.r_no = rr.r_no " +
                     "WHERE f.m_no = ? " +
                     "GROUP BY r.r_no, m.m_nickname " +
                     "ORDER BY f.f_datetime DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, m_no);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Recipe recipe = new Recipe();
                recipe.setR_no(rs.getInt("r_no"));
                recipe.setR_title(rs.getString("r_title"));
                recipe.setR_image(rs.getString("r_image"));
                recipe.setR_hit(rs.getInt("r_hit"));
                recipe.setR_content(rs.getString("r_content"));
                recipe.setR_datetime(rs.getString("r_datetime"));
                recipe.setM_no(rs.getInt("m_no"));
                recipe.setM_nickname(rs.getString("m_nickname"));
                recipe.setR_type(rs.getString("r_type"));
                recipe.setR_difficulty(rs.getString("r_difficulty"));
                recipe.setAvg_rating(rs.getDouble("avg_rating"));
                recipe.setReview_count(rs.getInt("review_count"));
                list.add(recipe);
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 9. 즐겨찾기 토글
    public void toggleFavorite(int m_no, int r_no) {
        String checkSql = "SELECT f_no FROM favorite WHERE m_no = ? AND r_no = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(checkSql)) {

            pstmt.setInt(1, m_no);
            pstmt.setInt(2, r_no);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                // 이미 즐겨찾기 → 삭제
                String deleteSql = "DELETE FROM favorite WHERE m_no = ? AND r_no = ?";
                PreparedStatement dp = conn.prepareStatement(deleteSql);
                dp.setInt(1, m_no);
                dp.setInt(2, r_no);
                dp.executeUpdate();
            } else {
                // 즐겨찾기 추가
                String insertSql = "INSERT INTO favorite (m_no, r_no) VALUES (?, ?)";
                PreparedStatement ip = conn.prepareStatement(insertSql);
                ip.setInt(1, m_no);
                ip.setInt(2, r_no);
                ip.executeUpdate();
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 10. 최근 본 레시피 목록
    public List<Recipe> selectRecentViews(int m_no) {
        List<Recipe> list = new ArrayList<>();
        String sql = "SELECT r.*, m.m_nickname, rv.rv_datetime, " +
                "COALESCE(AVG(rr.rr_rating), 0) AS avg_rating, " +
                "COUNT(rr.rr_no) AS review_count " +
                "FROM recent_view rv " +
                "JOIN recipe r ON rv.r_no = r.r_no " +
                "JOIN r_member m ON r.m_no = m.m_no " +
                "LEFT JOIN recipe_review rr ON r.r_no = rr.r_no " +
                "WHERE rv.m_no = ? " +
                "GROUP BY r.r_no, m.m_nickname, rv.rv_datetime " +
                "ORDER BY rv.rv_datetime DESC " +
                "LIMIT 30";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, m_no);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Recipe recipe = new Recipe();
                recipe.setR_no(rs.getInt("r_no"));
                recipe.setR_title(rs.getString("r_title"));
                recipe.setR_image(rs.getString("r_image"));
                recipe.setR_hit(rs.getInt("r_hit"));
                recipe.setR_content(rs.getString("r_content"));
                recipe.setR_datetime(rs.getString("r_datetime"));
                recipe.setM_no(rs.getInt("m_no"));
                recipe.setM_nickname(rs.getString("m_nickname"));
                recipe.setR_type(rs.getString("r_type"));
                recipe.setR_difficulty(rs.getString("r_difficulty"));
                recipe.setAvg_rating(rs.getDouble("avg_rating"));
                recipe.setReview_count(rs.getInt("review_count"));
                list.add(recipe);
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 11. 최근 본 레시피 저장/업데이트
    public void saveRecentView(int m_no, int r_no) {
        String sql = "INSERT INTO recent_view (m_no, r_no, rv_datetime) VALUES (?, ?, NOW()) " +
                     "ON DUPLICATE KEY UPDATE rv_datetime = NOW()";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, m_no);
            pstmt.setInt(2, r_no);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 12. 즐겨찾기 여부 확인
    public boolean isFavorite(int m_no, int r_no) {
        String sql = "SELECT f_no FROM favorite WHERE m_no = ? AND r_no = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, m_no);
            pstmt.setInt(2, r_no);
            ResultSet rs = pstmt.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
 // 13. 회원정보 수정
    public void updateProfile(int m_no, Member member) {
        String sql;
        
        if (member.getM_pw() != null && !member.getM_pw().isEmpty()) {
            sql = "UPDATE r_member SET m_nickname = ?, m_email = ?, m_phone = ?, m_pw = ? WHERE m_no = ?";
        } else {
            sql = "UPDATE r_member SET m_nickname = ?, m_email = ?, m_phone = ? WHERE m_no = ?";
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, member.getM_nickname());
            pstmt.setString(2, member.getM_email());
            pstmt.setString(3, member.getM_phone());

            if (member.getM_pw() != null && !member.getM_pw().isEmpty()) {
                pstmt.setString(4, member.getM_pw());
                pstmt.setInt(5, m_no);
            } else {
                pstmt.setInt(4, m_no);
            }

            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
 // 쿠폰 조회
    public List<Coupon> selectCoupons(int m_no) {
        List<Coupon> list = new ArrayList<>();
        String sql = "SELECT * FROM coupon WHERE m_no = ? AND c_used = 0 ORDER BY c_expire_date ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, m_no);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Coupon coupon = new Coupon();
                coupon.setC_no(rs.getInt("c_no"));
                coupon.setM_no(rs.getInt("m_no"));
                coupon.setC_brand(rs.getString("c_brand"));
                coupon.setC_name(rs.getString("c_name"));
                coupon.setC_expire_date(rs.getString("c_expire_date"));
                coupon.setC_type(rs.getString("c_type"));
                coupon.setC_used(rs.getInt("c_used"));
                list.add(coupon);
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 쿠폰 수 조회
    public int countCoupons(int m_no) {
        String sql = "SELECT COUNT(*) FROM coupon WHERE m_no = ? AND c_used = 0";

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
}