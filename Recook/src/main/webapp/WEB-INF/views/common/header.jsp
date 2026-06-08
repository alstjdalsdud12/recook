<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>

<%@ page import="com.springmvc.dao.NotificationDAO"%>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<header class="recook-header">
	<a href="${pageContext.request.contextPath}/" class="logo">
		<div class="logo-symbol">
			<i class="fas fa-arrows-rotate"></i> <i class="fas fa-mortar-pestle"></i>
		</div> <span class="logo-text">ReCook</span>
	</a>

	<nav class="nav-container">

		<!-- 레시피 -->
		<div class="nav-item">
			<a href="${pageContext.request.contextPath}/recipe">레시피</a>
			<div class="mega-menu">
				<div class="mega-content">
					<div class="mega-column">
						<h3>레시피 살펴보기</h3>
						<ul class="main-list">
							<li><a href="${pageContext.request.contextPath}/recipe_all">모든
									레시피</a></li>
							<li><a href="${pageContext.request.contextPath}/recipe_rank">레시피
									랭킹</a></li>
						</ul>
					</div>
					<div class="mega-column">
						<h3>분류</h3>
						<ul class="sub-list">
							<li><a
								href="${pageContext.request.contextPath}/recipe_type?column=r_type&value=밥">종류별</a></li>
							<li><a
								href="${pageContext.request.contextPath}/recipe_type?column=r_situation&value=일상">상황별</a></li>
							<li><a
								href="${pageContext.request.contextPath}/recipe_type?column=r_method&value=볶음">방법별</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>

		<!-- 솔루션 -->
		<div class="nav-item">
			<a href="${pageContext.request.contextPath}/solution">솔루션</a>
			<div class="mega-menu">
				<div class="mega-content">
					<div class="mega-column">
						<h3>솔루션</h3>
						<ul class="main-list">
							<li><a
								href="${pageContext.request.contextPath}/solution/ingredients">재료
									솔루션</a></li>
							<li><a
								href="${pageContext.request.contextPath}/solution/kitchen">주방
									솔루션</a></li>
						</ul>
					</div>
					<div class="mega-column">
						<h3>더보기</h3>
						<ul class="sub-list">
							<li><a
								href="${pageContext.request.contextPath}/solution/all">전체
									솔루션</a></li>
							<li><a
								href="${pageContext.request.contextPath}/solution/popular">인기
									솔루션</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>

		<!-- 게시판 -->
		<div class="nav-item">
			<a href="#">게시판</a>
			<div class="mega-menu">
				<div class="mega-content">
					<div class="mega-column">
						<h3>커뮤니티</h3>
						<ul class="main-list">
							<li><a href="${pageContext.request.contextPath}/board">자유게시판</a></li>
						</ul>
					</div>
					<div class="mega-column">
						<h3>이벤트</h3>
						<ul class="sub-list">
							<li><a href="${pageContext.request.contextPath}/event">진행
									중인 이벤트</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>

		<!-- 고객센터 -->
		<div class="nav-item">
			<a href="${pageContext.request.contextPath}/customer">고객센터</a>
			<div class="mega-menu">
				<div class="mega-content">
					<div class="mega-column">
						<h3>도움말</h3>
						<ul class="main-list">
							<li><a
								href="${pageContext.request.contextPath}/notice/notice">공지사항</a></li>
							<li><a href="${pageContext.request.contextPath}/qna">자주
									묻는 질문</a></li>
							<li><a href="${pageContext.request.contextPath}/inquiry">1:1
									문의하기</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>

		<!-- 관리자 페이지 (관리자만 보임) -->
		<%
		String h_role = (String) session.getAttribute("m_role");
		if (h_role != null && h_role.equals("admin")) {
		%>
		<div class="nav-item">
			<a href="${pageContext.request.contextPath}/admin">관리자</a>
		</div>
		<%
		}
		%>

	</nav>

	<div class="nav-side">
		<a href="#"><i class="fas fa-refrigerator"></i></a>

		<%
		String nickname = (String) session.getAttribute("m_nickname");
		if (nickname != null && !nickname.isEmpty()) {
			Integer h_m_no = (Integer) session.getAttribute("m_no");
			int unreadCount = 0;
			if (h_m_no != null) {
				NotificationDAO notificationDAO = new NotificationDAO();
				unreadCount = notificationDAO.countUnread(h_m_no);
			}
		%>
		<!-- 로그인 상태 -->
		<a href="${pageContext.request.contextPath}/recipe/write"
			class="btn-write">작성하기</a> <a
			href="${pageContext.request.contextPath}/mypage" class="mypage-btn">마이페이지</a>
		<!-- 알림 -->
		<a href="${pageContext.request.contextPath}/notification"
			class="notification-btn"> 🔔 <%
		if (unreadCount > 0) {
		%> <span
			class="notification-badge"><%=unreadCount%></span> <%
 }
 %>
		</a> <span class="nickname-text"><%=nickname%>님 환영합니다!</span> <a
			href="${pageContext.request.contextPath}/logout"
			class="login-btn logout-btn">로그아웃</a>
		<%
		} else {
		%>
		<!-- 로그아웃 상태 -->
		<a href="${pageContext.request.contextPath}/login" class="login-btn">로그인</a>
		<%
		}
		%>
	</div>

</header>