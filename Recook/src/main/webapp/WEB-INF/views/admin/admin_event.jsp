<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>
<%@ page import="com.springmvc.domain.Event"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 이벤트 관리 - ReCook</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin.css">
</head>
<body>

	<div class="admin-container">

		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

		<div class="main">

			<div class="top-bar">
				<h1>이벤트 관리</h1>
				<a href="${pageContext.request.contextPath}/admin/event/write"
					class="btn-submit" style="text-decoration:none;">+ 이벤트 등록</a>
			</div>

			<div class="recent">

				<div style="margin-bottom: 20px;">
					<h2 style="margin: 0;">이벤트 목록</h2>
				</div>

				<table>
					<thead>
						<tr>
							<th>번호</th>
							<th>아이콘</th>
							<th>제목</th>
							<th>기간</th>
							<th>보상</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<%
						List<Event> eventList = (List<Event>) request.getAttribute("eventList");
						if (eventList != null && !eventList.isEmpty()) {
							for (Event event : eventList) {
						%>
						<tr>
							<td><%= event.getE_no() %></td>
							<td><%= event.getE_icon() != null ? event.getE_icon() : "" %></td>
							<td>
								<a href="${pageContext.request.contextPath}/event_detail?e_no=<%= event.getE_no() %>">
									<%= event.getE_title() %>
								</a>
							</td>
							<td><%= event.getE_period() != null ? event.getE_period() : "" %></td>
							<td><%= event.getE_reward() != null ? event.getE_reward() : "" %></td>
							<td>
								<div class="action-buttons">
									<a href="${pageContext.request.contextPath}/admin/event/update?e_no=<%= event.getE_no() %>"
										class="btn-small btn-edit">수정</a>
									<a href="${pageContext.request.contextPath}/admin/event/delete?e_no=<%= event.getE_no() %>"
										class="btn-small btn-delete"
										onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
								</div>
							</td>
						</tr>
						<%
							}
						} else {
						%>
						<tr>
							<td colspan="6" style="text-align: center; color: #999;">등록된 이벤트가 없습니다.</td>
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