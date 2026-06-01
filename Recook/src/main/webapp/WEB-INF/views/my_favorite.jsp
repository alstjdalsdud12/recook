<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>즐겨찾기</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/resources/css/header.css">

<link rel="stylesheet"
href="${pageContext.request.contextPath}/resources/css/my_favorite.css">

</head>

<body>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div class="favorite-container">

    <div class="favorite-top">

        <h1>
            즐겨찾기
        </h1>

    </div>

    <div class="favorite-list">

        <div class="favorite-item">

            <div class="recipe-title">

                🍳 김치볶음밥 레시피

            </div>

            <div class="recipe-info">

                조회수 120 · 좋아요 32

            </div>

        </div>

        <div class="favorite-item">

            <div class="recipe-title">

                🍜 라면 맛있게 끓이는 방법

            </div>

            <div class="recipe-info">

                조회수 98 · 좋아요 21

            </div>

        </div>

        <div class="favorite-item">

            <div class="recipe-title">

                🥘 자취생 제육볶음

            </div>

            <div class="recipe-info">

                조회수 76 · 좋아요 18

            </div>

        </div>

    </div>

</div>

</body>
</html>