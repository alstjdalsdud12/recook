<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>쿠폰함</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/resources/css/coupon.css">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

</head>

<body>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div class="coupon-container">

    <div class="coupon-top">

        <h1>
            🎁 쿠폰함
        </h1>

        <div class="coupon-count">

            보유 쿠폰 4개

        </div>

    </div>

    <!-- 쿠폰 리스트 -->

    <div class="coupon-list">

        <!-- 배민 -->

        <div class="coupon-card baemin">

            <div class="coupon-left">

                <div class="coupon-brand">
                    배달의민족
                </div>

                <div class="coupon-name">
                    배민 상품권 1만원
                </div>

                <div class="coupon-date">
                    2026-07-31 까지 사용 가능
                </div>

            </div>

            <div class="coupon-right">

                <div class="coupon-badge">
                    EVENT
                </div>

            </div>

        </div>

        <!-- 스타벅스 -->

        <div class="coupon-card starbucks">

            <div class="coupon-left">

                <div class="coupon-brand">
                    Starbucks
                </div>

                <div class="coupon-name">
                    아메리카노 Tall
                </div>

                <div class="coupon-date">
                    2026-08-15 까지 사용 가능
                </div>

            </div>

            <div class="coupon-right">

                <div class="coupon-badge">
                    EVENT
                </div>

            </div>

        </div>

        <!-- 편의점 -->

        <div class="coupon-card gs">

            <div class="coupon-left">

                <div class="coupon-brand">
                    GS25
                </div>

                <div class="coupon-name">
                    편의점 5천원 쿠폰
                </div>

                <div class="coupon-date">
                    2026-08-30 까지 사용 가능
                </div>

            </div>

            <div class="coupon-right">

                <div class="coupon-badge">
                    EVENT
                </div>

            </div>

        </div>

        <!-- CU -->

        <div class="coupon-card cu">

            <div class="coupon-left">

                <div class="coupon-brand">
                    CU
                </div>

                <div class="coupon-name">
                    음료 교환권
                </div>

                <div class="coupon-date">
                    2026-09-10 까지 사용 가능
                </div>

            </div>

            <div class="coupon-right">

                <div class="coupon-badge">
                    EVENT
                </div>

            </div>

        </div>

    </div>

</div>

</body>
</html>