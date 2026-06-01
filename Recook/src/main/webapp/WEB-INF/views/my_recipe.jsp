<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>내가 쓴 글</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/resources/css/header.css">

<link rel="stylesheet"
href="${pageContext.request.contextPath}/resources/css/my_recipe.css">

</head>

<body>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div class="myboard-container">

    <div class="myboard-top">

        <h1>
            내가 쓴 글
        </h1>

    </div>

    <div class="myboard-list">

        <div class="myboard-item">

            <div class="board-left">

                <div class="board-title">

                    냉장고 재료로 만든 볶음밥 레시피

                </div>

                <div class="board-info">

                    2026-05-18 · 조회수 24 · 좋아요 12

                </div>

            </div>

        </div>

        <div class="myboard-item">

            <div class="board-left">

                <div class="board-title">

                    남은 치킨 활용법 추천

                </div>

                <div class="board-info">

                    2026-05-17 · 조회수 18 · 좋아요 7

                </div>

            </div>

        </div>

        <div class="myboard-item">

            <div class="board-left">

                <div class="board-title">

                    자취생 간단 김치찌개

                </div>

                <div class="board-info">

                    2026-05-15 · 조회수 43 · 좋아요 21

                </div>

            </div>

        </div>

    </div>

</div>

</body>
</html>