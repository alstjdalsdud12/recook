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

					<h1>레시피</h1>
					<p>원하는 방식으로 레시피를 찾아보세요</p>

				</div>
			</div>

			<div class="top-menu">

    <a href="${pageContext.request.contextPath}/recipe_all"
       class="top-card">

        <div class="top-icon">📖</div>

        <div class="top-text">
            <h3>모든 레시피</h3>
            <p>전체 레시피 둘러보기</p>
        </div>

    </a>

    <a href="${pageContext.request.contextPath}/recipe_rank"
       class="top-card">

        <div class="top-icon">🏆</div>

        <div class="top-text">
            <h3>레시피 랭킹</h3>
            <p>인기 레시피 확인하기</p>
        </div>

    </a>

</div>

			<div class="recipe-list">

				<a href="${pageContext.request.contextPath}/recipe_type?column=r_type&value=밥" class="recipe-card">

    <div class="thumb img1"></div>

    <div class="recipe-badge">
        🍚
    </div>

    <div class="recipe-info">
        <div class="title">종류별</div>
    </div>

</a>

<a href="${pageContext.request.contextPath}/recipe_type?column=r_situation&value=일상" class="recipe-card">

    <div class="thumb img2"></div>

    <div class="recipe-badge">
        🎉
    </div>

    <div class="recipe-info">
        <div class="title">상황별</div>
    </div>

</a>

<a href="${pageContext.request.contextPath}/recipe_type?column=r_method&value=볶음" class="recipe-card">

    <div class="thumb img4"></div>

    <div class="recipe-badge">
        👨‍🍳
    </div>

    <div class="recipe-info">
        <div class="title">방법별</div>
    </div>

</a>

			</div>

		</div>

	</div>

</body>
</html>