<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>진행중인 이벤트</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/event.css">

</head>

<body>

	<%@ include file="/WEB-INF/views/common/header.jsp"%>

	<div class="event-container">

		<h1 class="event-main-title">🎉 진행중인 이벤트</h1>

		<div class="event-grid">

			<!-- 1 -->

			<div class="event-card"
				onclick="location.href='${pageContext.request.contextPath}/event_detail?type=1'">

				<div class="event-image">🍳</div>

				<div class="event-content">

					<div class="event-badge">진행중</div>

					<h2>냉장고 털기 챌린지</h2>

					<p>냉장고 속 재료로 만든 요리를 공유해보세요!</p>

					<div class="event-reward">🎁 배민 상품권 3만원</div>

					<div class="event-date">2026.05.01 ~ 2026.05.31</div>

				</div>

			</div>

			<!-- 2 -->

			<div class="event-card"
				onclick="location.href='${pageContext.request.contextPath}/event_detail?type=2'">

				<div class="event-image">🍱</div>

				<div class="event-content">

					<div class="event-badge">진행중</div>

					<h2>자취생 5천원 요리대회</h2>

					<p>5천원 이하 재료로 최고의 요리를 만들어보세요!</p>

					<div class="event-reward">🎁 스타벅스 기프티콘</div>

					<div class="event-date">2026.05.10 ~ 2026.06.10</div>

				</div>

			</div>

			<!-- 3 -->

			<div class="event-card"
				onclick="location.href='${pageContext.request.contextPath}/event_detail?type=3'">
				<div class="event-image">😂</div>

				<div class="event-content">

					<div class="event-badge">진행중</div>

					<h2>실패요리 자랑대회</h2>

					<p>망한 요리도 괜찮다! 웃긴 실패요리를 공유해보세요.</p>

					<div class="event-reward">🎁 편의점 쿠폰 1만원</div>

					<div class="event-date">2026.05.15 ~ 2026.05.30</div>

				</div>

			</div>

			<!-- 4 -->

			<div class="event-card"
				onclick="location.href='${pageContext.request.contextPath}/event_detail?type=4'">

				<div class="event-image">🧊</div>

				<div class="event-content">

					<div class="event-badge">진행중</div>

					<h2>여름 시원한 요리 이벤트</h2>

					<p>냉면, 화채, 빙수 등 여름 요리를 공유해보세요!</p>

					<div class="event-reward">🎁 배민 상품권 5만원</div>

					<div class="event-date">2026.06.01 ~ 2026.06.30</div>

				</div>

			</div>

			<!-- 5 -->

			<div class="event-card"
				onclick="location.href='${pageContext.request.contextPath}/event_detail?type=5'">
				<div class="event-image">💬</div>

				<div class="event-content">

					<div class="event-badge">진행중</div>

					<h2>댓글 참여 이벤트</h2>

					<p>게시글에 댓글만 달아도 자동 응모 완료!</p>

					<div class="event-reward">🎁 스타벅스 기프티콘</div>

					<div class="event-date">2026.05.01 ~ 2026.05.20</div>

				</div>

			</div>

			<!-- 6 -->

			<div class="event-card"
				onclick="location.href='${pageContext.request.contextPath}/event_detail?type=6'">
				<div class="event-image">🔥</div>

				<div class="event-content">

					<div class="event-badge">HOT</div>

					<h2>좋아요 TOP 레시피</h2>

					<p>좋아요 1등 레시피의 주인공이 되어보세요!</p>

					<div class="event-reward">🎁 배민 상품권 10만원</div>

					<div class="event-date">2026.05.01 ~ 2026.06.15</div>

				</div>

			</div>

		</div>

	</div>

</body>
</html>