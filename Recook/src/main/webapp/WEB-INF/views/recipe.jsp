<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 - ReCook</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/recipe.css">

</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>

	<div class="main-container">

		<div class="recipe-wrapper">

			<div class="recipe-header">
				<div class="header-top">
					<div>
						<h1>레시피</h1>
						<p>다양한 요리를 탐색해보세요</p>
					</div>
				</div>
			</div>

			<div class="category-container">
				<a href="${pageContext.request.contextPath}/recipe_all" class="category-card">모든 레시피</a>
				<a href="${pageContext.request.contextPath}/recipe_rank" class="category-card">레시피 랭킹</a>
			</div>

			<div class="recipe-list">

				<a href="${pageContext.request.contextPath}/recipe_type?column=r_type&value=밥" class="recipe-card">
					<div class="thumb img1"></div>
					<div class="recipe-info">
						<div class="title">종류별</div>
					</div>
				</a>

				<a href="${pageContext.request.contextPath}/recipe_type?column=r_situation&value=일상" class="recipe-card">
					<div class="thumb img2"></div>
					<div class="recipe-info">
						<div class="title">상황별</div>
					</div>
				</a>

				<a href="${pageContext.request.contextPath}/recipe_type?column=r_method&value=볶음" class="recipe-card">
					<div class="thumb img4"></div>
					<div class="recipe-info">
						<div class="title">방법별</div>
					</div>
				</a>

			</div>

		</div>

	</div>

</body>
</html>