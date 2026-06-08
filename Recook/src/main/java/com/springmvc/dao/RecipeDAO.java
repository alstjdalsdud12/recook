package com.springmvc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.springmvc.domain.Recipe;
import com.springmvc.domain.RecipeIngredient;
import com.springmvc.domain.RecipeReview;
import com.springmvc.domain.RecipeStep;
import com.springmvc.domain.RecipeReport;
import com.springmvc.util.DBConnection;

public class RecipeDAO {

	// 1. 전체 레시피 조회
	public List<Recipe> selectAll() {
		List<Recipe> list = new ArrayList<>();
		String sql = "SELECT r.*, m.m_nickname, " + "COALESCE(AVG(rr.rr_rating), 0) AS avg_rating, "
				+ "COUNT(rr.rr_no) AS review_count " + "FROM recipe r " + "JOIN r_member m ON r.m_no = m.m_no "
				+ "LEFT JOIN recipe_review rr ON r.r_no = rr.r_no " + "GROUP BY r.r_no, m.m_nickname "
				+ "ORDER BY r.r_no DESC";

		try (Connection conn = DBConnection.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {

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
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// 2. 특정 레시피 조회
	public Recipe selectOne(int r_no) {
		Recipe recipe = null;
		String sql = "SELECT r.*, m.m_nickname FROM recipe r JOIN r_member m ON r.m_no = m.m_no WHERE r.r_no = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, r_no);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				recipe = new Recipe();
				recipe.setR_no(rs.getInt("r_no"));
				recipe.setR_title(rs.getString("r_title"));
				recipe.setR_image(rs.getString("r_image"));
				recipe.setR_hit(rs.getInt("r_hit"));
				recipe.setR_content(rs.getString("r_content"));
				recipe.setR_datetime(rs.getString("r_datetime"));
				recipe.setM_no(rs.getInt("m_no"));
				recipe.setM_nickname(rs.getString("m_nickname"));
				recipe.setR_type(rs.getString("r_type"));
				recipe.setR_situation(rs.getString("r_situation"));
				recipe.setR_method(rs.getString("r_method"));
				recipe.setR_servings(rs.getInt("r_servings"));
				recipe.setR_cooking_time(rs.getInt("r_cooking_time"));
				recipe.setR_difficulty(rs.getString("r_difficulty"));
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return recipe;
	}

	// 3. 레시피 작성 (r_no 반환)
	public int insert(Recipe recipe) {
		String sql = "INSERT INTO recipe (r_title, r_image, r_content, m_no, r_type, r_situation, r_method, r_servings, r_cooking_time, r_difficulty) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		int r_no = -1;

		try (Connection conn = DBConnection.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

			pstmt.setString(1, recipe.getR_title());
			pstmt.setString(2, recipe.getR_image());
			pstmt.setString(3, recipe.getR_content());
			pstmt.setInt(4, recipe.getM_no());
			pstmt.setString(5, recipe.getR_type());
			pstmt.setString(6, recipe.getR_situation());
			pstmt.setString(7, recipe.getR_method());
			pstmt.setInt(8, recipe.getR_servings());
			pstmt.setInt(9, recipe.getR_cooking_time());
			pstmt.setString(10, recipe.getR_difficulty());

			pstmt.executeUpdate();

			ResultSet rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
				r_no = rs.getInt(1);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return r_no;
	}

	// 4. 조회수 증가
	public void updateHit(int r_no) {
		String sql = "UPDATE recipe SET r_hit = r_hit + 1 WHERE r_no = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, r_no);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 5. 조리순서 저장
	public void insertStep(int r_no, int rs_order, String rs_content, String rs_image) {
		String sql = "INSERT INTO recipe_step (r_no, rs_order, rs_content, rs_image) VALUES (?, ?, ?, ?)";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, r_no);
			pstmt.setInt(2, rs_order);
			pstmt.setString(3, rs_content);
			pstmt.setString(4, rs_image);

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 6. 재료 조회
	public List<RecipeIngredient> selectIngredients(int r_no) {
		List<RecipeIngredient> list = new ArrayList<>();
		String sql = "SELECT * FROM recipe_ingredient WHERE r_no = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, r_no);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				RecipeIngredient ingredient = new RecipeIngredient();
				ingredient.setRi_no(rs.getInt("ri_no"));
				ingredient.setR_no(rs.getInt("r_no"));
				ingredient.setRi_name(rs.getString("ri_name"));
				ingredient.setRi_quantity(rs.getDouble("ri_quantity"));
				ingredient.setRi_unit(rs.getString("ri_unit"));
				ingredient.setRi_note(rs.getString("ri_note"));
				list.add(ingredient);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 7. 조리순서 조회
	public List<RecipeStep> selectSteps(int r_no) {
		List<RecipeStep> list = new ArrayList<>();
		String sql = "SELECT * FROM recipe_step WHERE r_no = ? ORDER BY rs_order";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, r_no);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				RecipeStep step = new RecipeStep();
				step.setRs_no(rs.getInt("rs_no"));
				step.setR_no(rs.getInt("r_no"));
				step.setRs_order(rs.getInt("rs_order"));
				step.setRs_content(rs.getString("rs_content"));
				step.setRs_image(rs.getString("rs_image"));
				list.add(step);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 8. 후기 조회
	public List<RecipeReview> selectReviews(int r_no) {
		List<RecipeReview> list = new ArrayList<>();
		String sql = "SELECT rr.*, m.m_nickname FROM recipe_review rr JOIN r_member m ON rr.m_no = m.m_no WHERE rr.r_no = ? ORDER BY rr.rr_datetime DESC";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, r_no);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				RecipeReview review = new RecipeReview();
				review.setRr_no(rs.getInt("rr_no"));
				review.setR_no(rs.getInt("r_no"));
				review.setM_no(rs.getInt("m_no"));
				review.setM_nickname(rs.getString("m_nickname"));
				review.setRr_rating(rs.getInt("rr_rating"));
				review.setRr_content(rs.getString("rr_content"));
				review.setRr_image(rs.getString("rr_image"));
				review.setRr_datetime(rs.getString("rr_datetime"));
				list.add(review);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 9. 후기 등록
	public void insertReview(RecipeReview review) {
		String sql = "INSERT INTO recipe_review (r_no, m_no, rr_rating, rr_content, rr_image) VALUES (?, ?, ?, ?, ?)";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, review.getR_no());
			pstmt.setInt(2, review.getM_no());
			pstmt.setInt(3, review.getRr_rating());
			pstmt.setString(4, review.getRr_content());
			pstmt.setString(5, review.getRr_image());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 10. 재료 저장
	public void insertIngredient(int r_no, String ri_name, double ri_quantity, String ri_unit, String ri_note) {
		String sql = "INSERT INTO recipe_ingredient (r_no, ri_name, ri_quantity, ri_unit, ri_note) VALUES (?, ?, ?, ?, ?)";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, r_no);
			pstmt.setString(2, ri_name);
			pstmt.setDouble(3, ri_quantity);
			pstmt.setString(4, ri_unit);
			pstmt.setString(5, ri_note);

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 11. 랭킹 조회 (평점순, 평점 같으면 조회수순)
	public List<Recipe> selectRank() {
		List<Recipe> list = new ArrayList<>();
		String sql = "SELECT r.*, m.m_nickname, " + "COALESCE(AVG(rr.rr_rating), 0) AS avg_rating, "
				+ "COUNT(rr.rr_no) AS review_count " + "FROM recipe r " + "JOIN r_member m ON r.m_no = m.m_no "
				+ "LEFT JOIN recipe_review rr ON r.r_no = rr.r_no " + "GROUP BY r.r_no, m.m_nickname "
				+ "ORDER BY avg_rating DESC, r.r_hit DESC";

		try (Connection conn = DBConnection.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {

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
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 12. 분류별 레시피 조회
	public List<Recipe> selectByType(String column, String value) {
		List<Recipe> list = new ArrayList<>();
		String sql = "SELECT r.*, m.m_nickname, " + "COALESCE(AVG(rr.rr_rating), 0) AS avg_rating, "
				+ "COUNT(rr.rr_no) AS review_count " + "FROM recipe r " + "JOIN r_member m ON r.m_no = m.m_no "
				+ "LEFT JOIN recipe_review rr ON r.r_no = rr.r_no " + "WHERE " + column + " = ? "
				+ "GROUP BY r.r_no, m.m_nickname " + "ORDER BY r.r_no DESC";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, value);
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

	// 키워드로 검색
	public List<Recipe> selectAll(String keyword) {
		List<Recipe> list = new ArrayList<>();
		String sql = "SELECT r.*, m.m_nickname, " + "COALESCE(AVG(rr.rr_rating), 0) AS avg_rating, "
				+ "COUNT(rr.rr_no) AS review_count " + "FROM recipe r " + "JOIN r_member m ON r.m_no = m.m_no "
				+ "LEFT JOIN recipe_review rr ON r.r_no = rr.r_no " + "WHERE r.r_title LIKE ? "
				+ "GROUP BY r.r_no, m.m_nickname " + "ORDER BY r.r_no DESC";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, "%" + keyword + "%");
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

	public void delete(int r_no) {
	    try (Connection conn = DBConnection.getConnection()) {

	        // 1. 즐겨찾기 삭제
	        PreparedStatement p1 = conn.prepareStatement("DELETE FROM favorite WHERE r_no = ?");
	        p1.setInt(1, r_no);
	        p1.executeUpdate();

	        // 2. 최근 본 레시피 삭제
	        PreparedStatement p2 = conn.prepareStatement("DELETE FROM recent_view WHERE r_no = ?");
	        p2.setInt(1, r_no);
	        p2.executeUpdate();

	        // 3. 신고 삭제
	        PreparedStatement p3 = conn.prepareStatement("DELETE FROM recipe_report WHERE r_no = ?");
	        p3.setInt(1, r_no);
	        p3.executeUpdate();

	        // 4. 후기 삭제
	        PreparedStatement p4 = conn.prepareStatement("DELETE FROM recipe_review WHERE r_no = ?");
	        p4.setInt(1, r_no);
	        p4.executeUpdate();

	        // 5. 재료 삭제
	        PreparedStatement p5 = conn.prepareStatement("DELETE FROM recipe_ingredient WHERE r_no = ?");
	        p5.setInt(1, r_no);
	        p5.executeUpdate();

	        // 6. 조리순서 삭제
	        PreparedStatement p6 = conn.prepareStatement("DELETE FROM recipe_step WHERE r_no = ?");
	        p6.setInt(1, r_no);
	        p6.executeUpdate();

	        // 7. 레시피 삭제
	        PreparedStatement p7 = conn.prepareStatement("DELETE FROM recipe WHERE r_no = ?");
	        p7.setInt(1, r_no);
	        p7.executeUpdate();

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
	// 신고 등록
	public void insertReport(int r_no, int m_no, String rp_reason) {
		String sql = "INSERT INTO recipe_report (r_no, m_no, rp_reason) VALUES (?, ?, ?)";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, r_no);
			pstmt.setInt(2, m_no);
			pstmt.setString(3, rp_reason);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 신고 목록 조회
	public List<RecipeReport> selectReports() {
		List<RecipeReport> list = new ArrayList<>();
		String sql = "SELECT rp.*, r.r_title, m.m_nickname " + "FROM recipe_report rp "
				+ "JOIN recipe r ON rp.r_no = r.r_no " + "JOIN r_member m ON rp.m_no = m.m_no "
				+ "ORDER BY rp.rp_datetime DESC";

		try (Connection conn = DBConnection.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				RecipeReport report = new RecipeReport();
				report.setRp_no(rs.getInt("rp_no"));
				report.setR_no(rs.getInt("r_no"));
				report.setM_no(rs.getInt("m_no"));
				report.setRp_reason(rs.getString("rp_reason"));
				report.setRp_datetime(rs.getString("rp_datetime"));
				report.setRp_status(rs.getInt("rp_status"));
				report.setR_title(rs.getString("r_title"));
				report.setM_nickname(rs.getString("m_nickname"));
				list.add(report);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 신고 처리 완료
	public void updateReportStatus(int rp_no) {
		String sql = "UPDATE recipe_report SET rp_status = 1 WHERE rp_no = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, rp_no);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	// 재료로 레시피 검색
	public List<Recipe> selectByIngredients(List<String> ingredients) {
	    List<Recipe> list = new ArrayList<>();
	    
	    if (ingredients == null || ingredients.isEmpty()) return list;

	    StringBuilder sql = new StringBuilder(
	        "SELECT DISTINCT r.*, m.m_nickname, " +
	        "COALESCE(AVG(rr.rr_rating), 0) AS avg_rating, " +
	        "COUNT(DISTINCT rr.rr_no) AS review_count, " +
	        "COUNT(DISTINCT ri2.ri_no) AS match_count " +
	        "FROM recipe r " +
	        "JOIN r_member m ON r.m_no = m.m_no " +
	        "LEFT JOIN recipe_review rr ON r.r_no = rr.r_no " +
	        "JOIN recipe_ingredient ri ON r.r_no = ri.r_no " +
	        "LEFT JOIN recipe_ingredient ri2 ON r.r_no = ri2.r_no AND ri2.ri_name IN ("
	    );

	    for (int i = 0; i < ingredients.size(); i++) {
	        sql.append(i == 0 ? "?" : ",?");
	    }
	    sql.append(") WHERE (");

	    for (int i = 0; i < ingredients.size(); i++) {
	        sql.append(i == 0 ? "ri.ri_name LIKE ?" : " OR ri.ri_name LIKE ?");
	    }
	    sql.append(") GROUP BY r.r_no, m.m_nickname ORDER BY match_count DESC, avg_rating DESC");

	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {

	        int idx = 1;
	        // match_count용 파라미터
	        for (String ing : ingredients) {
	            pstmt.setString(idx++, ing);
	        }
	        // WHERE 조건용 파라미터
	        for (String ing : ingredients) {
	            pstmt.setString(idx++, "%" + ing + "%");
	        }

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
	            recipe.setR_cooking_time(rs.getInt("r_cooking_time"));
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
}