<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ taglib
prefix="c"
uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>이벤트 상세</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/resources/css/header.css">

<link rel="stylesheet"
href="${pageContext.request.contextPath}/resources/css/event_detail.css">

</head>

<body>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div class="event-detail-container">

    <!-- type 1 -->

    <c:if test="${type == '1'}">

        <div class="detail-top">
            🍳
        </div>

        <div class="detail-content">

            <div class="detail-badge">
                진행중
            </div>

            <h1>
                냉장고 털기 챌린지
            </h1>

            <p class="detail-desc">

                냉장고 속 남은 재료를 활용해
                나만의 요리를 만들어보세요!

            </p>

            <div class="detail-info">

                <div>
                    📅 기간 :
                    2026.05.01 ~ 2026.05.31
                </div>

                <div>
                    🎁 보상 :
                    배민 상품권 3만원
                </div>

                <div>
                    🏆 참여방법 :
                    자유게시판에 사진과 함께 업로드
                </div>

            </div>

        </div>

    </c:if>

    <!-- type 2 -->

    <c:if test="${type == '2'}">

        <div class="detail-top">
            🍱
        </div>

        <div class="detail-content">

            <div class="detail-badge">
                진행중
            </div>

            <h1>
                자취생 5천원 요리대회
            </h1>

            <p class="detail-desc">

                5천원 이하 재료로 최고의
                가성비 요리를 만들어보세요!

            </p>

            <div class="detail-info">

                <div>
                    📅 기간 :
                    2026.05.10 ~ 2026.06.10
                </div>

                <div>
                    🎁 보상 :
                    스타벅스 기프티콘
                </div>

                <div>
                    🏆 참여방법 :
                    레시피와 가격 인증 필수
                </div>

            </div>

        </div>

    </c:if>

    <!-- type 3 -->

    <c:if test="${type == '3'}">

        <div class="detail-top">
            😂
        </div>

        <div class="detail-content">

            <div class="detail-badge">
                진행중
            </div>

            <h1>
                실패요리 자랑대회
            </h1>

            <p class="detail-desc">

                망한 요리도 하나의 추억!
                웃긴 실패요리를 공유해보세요.

            </p>

            <div class="detail-info">

                <div>
                    📅 기간 :
                    2026.05.15 ~ 2026.05.30
                </div>

                <div>
                    🎁 보상 :
                    편의점 쿠폰 1만원
                </div>

                <div>
                    🏆 참여방법 :
                    실패사진 + 후기 작성
                </div>

            </div>

        </div>

    </c:if>
    
    <!-- type 4 -->

<c:if test="${type == '4'}">

    <div class="detail-top">
        🧊
    </div>

    <div class="detail-content">

        <div class="detail-badge">
            진행중
        </div>

        <h1>
            여름 시원한 요리 이벤트
        </h1>

        <p class="detail-desc">

            무더운 여름을 날려버릴
            시원한 요리를 공유해보세요!

        </p>

        <div class="detail-info">

            <div>
                📅 기간 :
                2026.06.01 ~ 2026.06.30
            </div>

            <div>
                🎁 보상 :
                배민 상품권 5만원
            </div>

            <div>
                🏆 참여방법 :
                냉요리 사진과 레시피 작성
            </div>

        </div>

    </div>

</c:if>

<!-- type 5 -->

<c:if test="${type == '5'}">

    <div class="detail-top">
        💬
    </div>

    <div class="detail-content">

        <div class="detail-badge">
            진행중
        </div>

        <h1>
            댓글 참여 이벤트
        </h1>

        <p class="detail-desc">

            게시글에 댓글만 달아도
            자동으로 이벤트 응모 완료!

        </p>

        <div class="detail-info">

            <div>
                📅 기간 :
                2026.05.01 ~ 2026.05.20
            </div>

            <div>
                🎁 보상 :
                스타벅스 기프티콘
            </div>

            <div>
                🏆 참여방법 :
                댓글 작성 시 자동 참여
            </div>

        </div>

    </div>

</c:if>

<!-- type 6 -->

<c:if test="${type == '6'}">

    <div class="detail-top">
        🔥
    </div>

    <div class="detail-content">

        <div class="detail-badge">
            HOT
        </div>

        <h1>
            좋아요 TOP 레시피
        </h1>

        <p class="detail-desc">

            가장 많은 좋아요를 받은
            최고의 레시피를 선정합니다!

        </p>

        <div class="detail-info">

            <div>
                📅 기간 :
                2026.05.01 ~ 2026.06.15
            </div>

            <div>
                🎁 보상 :
                배민 상품권 10만원
            </div>

            <div>
                🏆 참여방법 :
                게시글 좋아요 수 자동 집계
            </div>

        </div>

    </div>

</c:if>

</div>

</body>
</html>