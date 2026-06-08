<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>
<%@ page import="com.springmvc.domain.Board"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 자유게시판 관리 - ReCook</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin.css">
</head>
<body>

	<div class="admin-container">

		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

		<div class="main">

			<div class="top-bar">
				<h1>자유게시판 관리</h1>
			</div>

			<div class="recent">

				<div style="margin-bottom: 20px;">
					<h2 style="margin: 0;">게시글 목록</h2>
				</div>

				<table>
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>조회수</th>
							<th>좋아요</th>
							<th>등록일</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<%
						List<Board> boardList = (List<Board>) request.getAttribute("boardList");
						if (boardList != null && !boardList.isEmpty()) {
							for (Board board : boardList) {
						%>
						<tr>
							<td><%= board.getB_id() %></td>
							<td>
								<a href="${pageContext.request.contextPath}/board/detail/<%= board.getB_id() %>">
									<%= board.getB_title() %>
								</a>
							</td>
							<td><%= board.getB_writer() %></td>
							<td><%= board.getB_hit() %></td>
							<td><%= board.getB_like_count() %></td>
							<td><%= board.getB_reg_date() %></td>
							<td>
								<div class="action-buttons">
									<a href="${pageContext.request.contextPath}/admin/board/delete?b_id=<%= board.getB_id() %>"
										class="btn-small btn-delete"
										onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
								</div>
							</td>
						</tr>
						<%
							}
						} else {
						%>
						<tr>
							<td colspan="7" style="text-align: center; color: #999;">등록된 게시글이 없습니다.</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>

			</div>

		</div>

	</div>

</body>
</html>