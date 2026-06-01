<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>최근에 본 레시피</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/resources/css/header.css">

<link rel="stylesheet"
href="${pageContext.request.contextPath}/resources/css/my_look.css">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

</head>

<body>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div class="look-container">

    <div class="look-top">

        <div>

            <p class="look-sub">
                MY PAGE
            </p>

            <h1>
    최근에 본 레시피
</h1>
        </div>

    </div>

    <div class="recipe-grid">

        <!-- 카드 1 -->

        <div class="recipe-card">

            <div class="recipe-image pasta">

                <span class="recipe-badge">
                    인기
                </span>

            </div>

            <div class="recipe-content">

                <h2>
                    크림파스타 만들기
                </h2>

                <p>
                    부드러운 크림소스와 베이컨이
                    어우러진 인기 레시피
                </p>

                <div class="recipe-bottom">

                    <span>
                        <i class="fa-solid fa-eye"></i>
                        최근 조회 2026-05-18
                    </span>

                </div>

            </div>

        </div>

        <!-- 카드 2 -->

        <div class="recipe-card">

            <div class="recipe-image rice">

                <span class="recipe-badge">
                    추천
                </span>

            </div>

            <div class="recipe-content">

                <h2>
                    계란볶음밥 황금레시피
                </h2>

                <p>
                    간단하지만 맛있는
                    자취생 필수 메뉴
                </p>

                <div class="recipe-bottom">

                    <span>
                        <i class="fa-solid fa-eye"></i>
                        최근 조회 2026-05-17
                    </span>

                </div>

            </div>

        </div>

        <!-- 카드 3 -->

        <div class="recipe-card">

            <div class="recipe-image soup">

                <span class="recipe-badge">
                    HOT
                </span>

            </div>

            <div class="recipe-content">

                <h2>
                    된장찌개 맛있게 끓이기
                </h2>

                <p>
                    집밥 느낌 가득한
                    한국 대표 찌개 레시피
                </p>

                <div class="recipe-bottom">
w
                    <span>
                        <i class="fa-solid fa-eye"></i>
                        최근 조회 2026-05-15
                    </span>

                </div>

            </div>

        </div>

    </div>

</div>

</body>
</html>