<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지 - ReCook</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin.css">

</head>
<body>

	<div class="admin-container">

		<!-- 사이드바 -->
		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

		<!-- 메인 -->
		<div class="main">

			<!-- 상단 -->
			<div class="top-bar">
				<h1>관리자 대시보드</h1>
			</div>

			<!-- 통계 카드 -->
			<div class="card-container">

				<div class="card">
					<h3>회원 수</h3>
					<p>120명</p>
				</div>

				<div class="card">
					<h3>레시피 수</h3>
					<p>85개</p>
				</div>

				<div class="card">
					<h3>문의</h3>
					<p>12건</p>
				</div>

			</div>

			<!-- 최근 활동 -->
			<div class="recent">

				<h2>최근 문의</h2>

				<table>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>날짜</th>
					</tr>

					<tr>
						<td>1</td>
						<td>로그인이 안돼요</td>
						<td>user1</td>
						<td>2026-04-20</td>
					</tr>

					<tr>
						<td>2</td>
						<td>레시피 등록 문의</td>
						<td>user2</td>
						<td>2026-04-19</td>
					</tr>

				</table>

			</div>

		</div>

	</div>
	<script>
		function toggleMenu(element) {
			const submenu = element.nextElementSibling;
			const arrow = element.querySelector(".arrow");

			if (submenu.style.display === "block") {
				submenu.style.display = "none";
				arrow.style.transform = "rotate(0deg)";
			} else {
				submenu.style.display = "block";
				arrow.style.transform = "rotate(180deg)";
			}
		}
	</script>
</body>
</html>