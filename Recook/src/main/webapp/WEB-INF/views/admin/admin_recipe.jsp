<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 레시피 관리 - ReCook</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin.css">

</head>
<body>

	<div class="admin-container">

		<!-- 사이드바 -->
		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

		<!-- 메인 -->
		<div class="main">

			<div class="top-bar">
				<h1>레시피 관리</h1>
			</div>

			<!-- 검색 폼 -->
			<div class="search-form">
				<form action="${pageContext.request.contextPath}/admin/recipe" method="get" style="display: flex; gap: 10px;">
					<input type="text" name="keyword" placeholder="레시피 제목 검색..." value="${keyword != null ? keyword : ''}">
					<button type="submit">검색</button>
					<a href="${pageContext.request.contextPath}/admin/recipe" class="btn-submit">초기화</a>
				</form>
			</div>

			<div class="recent">

				<div style="margin-bottom: 20px;">
					<h2 style="margin: 0;">레시피 목록</h2>
				</div>

				<table>
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>종류</th>
							<th>조회수</th>
							<th>평점</th>
							<th>등록일</th>
							<th>관리</th>
						</tr>
					</thead>

					<tbody>
						<%
						java.util.List<com.springmvc.domain.Recipe> recipeList =
							(java.util.List<com.springmvc.domain.Recipe>) request.getAttribute("recipeList");

						if (recipeList != null && recipeList.size() > 0) {
							for (com.springmvc.domain.Recipe recipe : recipeList) {
						%>
						<tr>
							<td><%= recipe.getR_no() %></td>
							<td>
								<a href="${pageContext.request.contextPath}/recipe_detail?r_no=<%= recipe.getR_no() %>">
									<%= recipe.getR_title() %>
								</a>
							</td>
							<td><%= recipe.getM_nickname() %></td>
							<td><%= recipe.getR_type() %></td>
							<td><%= recipe.getR_hit() %></td>
							<td>⭐ <%= String.format("%.1f", recipe.getAvg_rating()) %></td>
							<td><%= recipe.getR_datetime() %></td>
							<td>
								<div class="action-buttons">
									<a href="${pageContext.request.contextPath}/admin/recipe/delete?r_no=<%= recipe.getR_no() %>"
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
							<td colspan="8" style="text-align: center; color: #999;">등록된 레시피가 없습니다.</td>
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