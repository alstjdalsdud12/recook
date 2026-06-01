<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.springmvc.domain.Recipe"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 랭킹 - ReCook</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/recipe_rank.css">

</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div class="main-container">

	<div class="rank-wrapper">

		<div class="rank-header">
			<h1>레시피 랭킹</h1>
			<p>평점이 높은 인기 레시피</p>
		</div>

		<div class="rank-list">

			<%
			List<Recipe> rankList = (List<Recipe>) request.getAttribute("rankList");
			if (rankList != null && !rankList.isEmpty()) {
				int rank = 1;
				for (Recipe recipe : rankList) {
					String imagePath = recipe.getR_image();
					String imageUrl;
					if (imagePath == null || imagePath.isEmpty()) {
						imageUrl = request.getContextPath() + "/resources/images/default.png";
					} else {
						imageUrl = request.getContextPath() + "/recipeimage/" + imagePath;
					}
			%>

			<a href="${pageContext.request.contextPath}/recipe_detail?r_no=<%= recipe.getR_no() %>" class="rank-item">
				<div class="rank-num"><%= rank %></div>
				<div class="thumb" style="background-image: url('<%= imageUrl %>'); background-size: cover; background-position: center;"></div>
				<div class="info">
					<div class="title"><%= recipe.getR_title() %></div>
					<div class="author"><%= recipe.getM_nickname() %></div>
					<div class="rating">⭐ <%= String.format("%.1f", recipe.getAvg_rating()) %> (<%= recipe.getReview_count() %>)</div>
					<div class="hits">조회수 <%= recipe.getR_hit() %></div>
				</div>
			</a>

			<%
				rank++;
				}
			}
			%>

		</div>

	</div>

</div>

</body>
</html>