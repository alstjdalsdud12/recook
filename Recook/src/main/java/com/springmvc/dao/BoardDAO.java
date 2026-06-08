package com.springmvc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.springmvc.domain.Board;
import com.springmvc.domain.Comment;
import com.springmvc.util.DBConnection;

public class BoardDAO {

	// 1. 전체 게시글 조회
	public List<Board> selectAll(String keyword, String sort) {
		List<Board> list = new ArrayList<>();
		String orderBy = "b_id DESC";
		if (sort.equals("hit"))
			orderBy = "b_hit DESC";
		else if (sort.equals("like"))
			orderBy = "b_like_count DESC";

		String sql = "SELECT * FROM board WHERE b_title LIKE ? ORDER BY " + orderBy;

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, "%" + keyword + "%");
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				Board board = new Board();
				board.setB_id(rs.getInt("b_id"));
				board.setB_title(rs.getString("b_title"));
				board.setB_writer(rs.getString("b_writer"));
				board.setB_content(rs.getString("b_content"));
				board.setB_hit(rs.getInt("b_hit"));
				board.setB_like_count(rs.getInt("b_like_count"));
				board.setB_reg_date(rs.getString("b_reg_date"));
				board.setM_no(rs.getInt("m_no"));
				list.add(board);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 2. 특정 게시글 조회
	public Board selectOne(int b_id) {
		Board board = null;
		String sql = "SELECT * FROM board WHERE b_id = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, b_id);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				board = new Board();
				board.setB_id(rs.getInt("b_id"));
				board.setB_title(rs.getString("b_title"));
				board.setB_writer(rs.getString("b_writer"));
				board.setB_content(rs.getString("b_content"));
				board.setB_hit(rs.getInt("b_hit"));
				board.setB_like_count(rs.getInt("b_like_count"));
				board.setB_reg_date(rs.getString("b_reg_date"));
				board.setM_no(rs.getInt("m_no"));
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return board;
	}

	// 3. 게시글 등록
	public int insert(Board board) {
		String sql = "INSERT INTO board (b_title, b_content, b_writer, m_no) VALUES (?, ?, ?, ?)";
		int b_id = -1;

		try (Connection conn = DBConnection.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

			pstmt.setString(1, board.getB_title());
			pstmt.setString(2, board.getB_content());
			pstmt.setString(3, board.getB_writer());
			pstmt.setInt(4, board.getM_no());

			pstmt.executeUpdate();

			ResultSet rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
				b_id = rs.getInt(1);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return b_id;
	}

	// 4. 게시글 수정
	public void update(Board board) {
		String sql = "UPDATE board SET b_title = ?, b_content = ? WHERE b_id = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, board.getB_title());
			pstmt.setString(2, board.getB_content());
			pstmt.setInt(3, board.getB_id());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 5. 게시글 삭제
	public void delete(int b_id) {
		String sql = "DELETE FROM board WHERE b_id = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, b_id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 6. 조회수 증가
	public void updateHit(int b_id) {
		String sql = "UPDATE board SET b_hit = b_hit + 1 WHERE b_id = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, b_id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 7. 좋아요 토글
	public void toggleLike(int b_id, int m_no) {
		String checkSql = "SELECT bl_id FROM board_like WHERE b_id = ? AND m_no = ?";

		try (Connection conn = DBConnection.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(checkSql)) {

			pstmt.setInt(1, b_id);
			pstmt.setInt(2, m_no);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				// 이미 좋아요 → 취소
				String deleteSql = "DELETE FROM board_like WHERE b_id = ? AND m_no = ?";
				PreparedStatement dp = conn.prepareStatement(deleteSql);
				dp.setInt(1, b_id);
				dp.setInt(2, m_no);
				dp.executeUpdate();

				String updateSql = "UPDATE board SET b_like_count = b_like_count - 1 WHERE b_id = ?";
				PreparedStatement up = conn.prepareStatement(updateSql);
				up.setInt(1, b_id);
				up.executeUpdate();
			} else {
				// 좋아요 추가
				String insertSql = "INSERT INTO board_like (b_id, m_no) VALUES (?, ?)";
				PreparedStatement ip = conn.prepareStatement(insertSql);
				ip.setInt(1, b_id);
				ip.setInt(2, m_no);
				ip.executeUpdate();

				String updateSql = "UPDATE board SET b_like_count = b_like_count + 1 WHERE b_id = ?";
				PreparedStatement up = conn.prepareStatement(updateSql);
				up.setInt(1, b_id);
				up.executeUpdate();
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 8. 이미지 저장
	public void insertImage(int b_id, String imgName) {
		String sql = "INSERT INTO board_image (b_id, bi_img_name) VALUES (?, ?)";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, b_id);
			pstmt.setString(2, imgName);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 9. 이미지 조회
	public List<String> selectImages(int b_id) {
		List<String> list = new ArrayList<>();
		String sql = "SELECT bi_img_name FROM board_image WHERE b_id = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, b_id);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				list.add(rs.getString("bi_img_name"));
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 10. 댓글 조회
	public List<Comment> selectComments(int b_id) {
		List<Comment> allList = new ArrayList<>();
		String sql = "SELECT * FROM board_comment WHERE b_id = ? ORDER BY "
				+ "CASE WHEN parent_id IS NULL THEN bc_id ELSE parent_id END, bc_id ASC";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, b_id);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				Comment comment = new Comment();
				comment.setBc_id(rs.getInt("bc_id"));
				comment.setB_id(rs.getInt("b_id"));
				comment.setM_no(rs.getInt("m_no"));
				comment.setBc_writer(rs.getString("bc_writer"));
				comment.setBc_content(rs.getString("bc_content"));
				comment.setBc_reg_date(rs.getString("bc_reg_date"));
				comment.setBc_depth(rs.getInt("bc_depth"));
				comment.setBc_deleted(rs.getInt("bc_deleted"));
				int parentId = rs.getInt("parent_id");
				if (!rs.wasNull()) {
					comment.setParent_id(parentId);
				}
				allList.add(comment);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		// 계층 구조 구성
		List<Comment> rootList = new ArrayList<>();
		java.util.Map<Integer, Comment> map = new java.util.HashMap<>();

		for (Comment c : allList) {
			map.put(c.getBc_id(), c);
		}

		for (Comment c : allList) {
			if (c.getParent_id() == null) {
				rootList.add(c);
			} else {
				Comment parent = map.get(c.getParent_id());
				if (parent != null) {
					parent.getReplies().add(c);
				}
			}
		}

		return rootList;
	}

	// 11. 댓글 등록
	public void insertComment(Comment comment) {
		String sql = "INSERT INTO board_comment (b_id, m_no, bc_writer, bc_content, parent_id, bc_depth) VALUES (?, ?, ?, ?, ?, ?)";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, comment.getB_id());
			pstmt.setInt(2, comment.getM_no());
			pstmt.setString(3, comment.getBc_writer());
			pstmt.setString(4, comment.getBc_content());
			if (comment.getParent_id() != null) {
				pstmt.setInt(5, comment.getParent_id());
			} else {
				pstmt.setNull(5, java.sql.Types.INTEGER);
			}
			pstmt.setInt(6, comment.getBc_depth());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 12. 댓글 수정
	public void updateComment(int bc_id, String bc_content) {
		String sql = "UPDATE board_comment SET bc_content = ? WHERE bc_id = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, bc_content);
			pstmt.setInt(2, bc_id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 13. 댓글 삭제 (실제 삭제 대신 삭제 표시)
	public void deleteComment(int bc_id) {
		String sql = "UPDATE board_comment SET bc_deleted = 1 WHERE bc_id = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, bc_id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

//14. 좋아요 여부 확인
public boolean isLiked(int b_id, int m_no) {
 String sql = "SELECT bl_id FROM board_like WHERE b_id = ? AND m_no = ?";

 try (Connection conn = DBConnection.getConnection();
      PreparedStatement pstmt = conn.prepareStatement(sql)) {

     pstmt.setInt(1, b_id);
     pstmt.setInt(2, m_no);
     ResultSet rs = pstmt.executeQuery();

     return rs.next();
 } catch (Exception e) {
     e.printStackTrace();
 }
 return false;
}

}