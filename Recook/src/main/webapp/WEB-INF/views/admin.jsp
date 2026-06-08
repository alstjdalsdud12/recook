<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.springmvc.domain.Inquiry"%>
<%@ page import="java.util.List"%>

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

		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

		<div class="main">

			<div class="top-bar">
				<h1>관리자 대시보드</h1>
			</div>

			<!-- 통계 카드 -->
			<div class="card-container">

				<div class="card"
					onclick="location.href='${pageContext.request.contextPath}/admin/user'"
					style="cursor: pointer;">
					<h3>회원 수</h3>
					<p>${memberCount}명</p>
				</div>

				<div class="card"
					onclick="location.href='${pageContext.request.contextPath}/admin/recipe'"
					style="cursor: pointer;">
					<h3>레시피 수</h3>
					<p>${recipeCount}개</p>
				</div>

				<div class="card"
					onclick="location.href='${pageContext.request.contextPath}/admin/inquiry'"
					style="cursor: pointer;">
					<h3>문의</h3>
					<p>${inquiryCount}건</p>
				</div>

			</div>

			<!-- 최근 문의 -->
			<div class="recent">

				<div
					style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
					<h2 style="margin: 0;">최근 문의</h2>
					<a href="${pageContext.request.contextPath}/admin/inquiry"
						style="color: #FF6B6B; font-size: 14px;">전체보기 →</a>
				</div>

				<table>
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>이메일</th>
							<th>날짜</th>
							<th>답변</th>
						</tr>
					</thead>
					<tbody>
						<%
						List<Inquiry> recentInquiryList = (List<Inquiry>) request.getAttribute("recentInquiryList");
						if (recentInquiryList != null && !recentInquiryList.isEmpty()) {
							for (Inquiry inquiry : recentInquiryList) {
						%>
						<tr
							onclick="location.href='${pageContext.request.contextPath}/admin/inquiry/detail?i_no=<%= inquiry.getI_no() %>'"
							style="cursor: pointer;">
							<td><%=inquiry.getI_no()%></td>
							<td><%=inquiry.getI_title()%></td>
							<td><%=inquiry.getI_email()%></td>
							<td><%=inquiry.getI_datetime()%></td>
							<td>
								<%
								if (inquiry.getI_reply() != null && !inquiry.getI_reply().isEmpty()) {
								%>
								<span style="color: #4dabf7; font-weight: bold;">답변완료</span> <%
 } else {
 %>
								<span style="color: #ff6b6b; font-weight: bold;">미답변</span> <%
 }
 %>
							</td>
						</tr>
						<%
						}
						} else {
						%>
						<tr>
							<td colspan="5" style="text-align: center; color: #999;">문의가
								없습니다.</td>
						</tr>
						<%
						}
						%>
					</tbody>
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