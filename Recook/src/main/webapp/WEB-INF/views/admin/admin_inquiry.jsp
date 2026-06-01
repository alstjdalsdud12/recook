<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 문의 관리 - ReCook</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin.css">

</head>
<body>

	<div class="admin-container">

		<!-- 사이드바 -->
		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

		<!-- 메인 -->
		<div class="main">

			<div class="top-bar">
				<h1>문의 관리</h1>
			</div>

			<div class="recent">

				<div style="margin-bottom: 20px;">
					<h2 style="margin: 0;">문의 목록</h2>
				</div>

				<table>
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>이메일</th>
							<th>작성일</th>
							<th>관리</th>
						</tr>
					</thead>

					<tbody>
						<%
						java.util.List<com.springmvc.domain.Inquiry> inquiryList = (java.util.List<com.springmvc.domain.Inquiry>) request
								.getAttribute("inquiryList");

						if (inquiryList != null && inquiryList.size() > 0) {
							for (com.springmvc.domain.Inquiry inquiry : inquiryList) {
						%>
						<tr>
							<td><%=inquiry.getI_no()%></td>
							<td><%=inquiry.getI_title()%></td>
							<td><%=inquiry.getI_email()%></td>
							<td><%=inquiry.getI_datetime()%></td>
							<td>
								<%
								if (inquiry.getI_reply() == null || inquiry.getI_reply().isEmpty()) {
								%> <a
								href="${pageContext.request.contextPath}/admin/inquiry/detail?i_no=<%= inquiry.getI_no() %>"
								class="btn-small btn-edit">답변</a> <%
 } else {
 %> <span style="color: #4CAF50; font-weight: bold;">답변완료</span> <%
 }
 %>
							</td>
						</tr>
						<%
						}
						} else {
						%>
						<tr>
							<td colspan="5" style="text-align: center; color: #999;">등록된
								문의가 없습니다.</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>

			</div>

		</div>

	</div>

</body>
</html>