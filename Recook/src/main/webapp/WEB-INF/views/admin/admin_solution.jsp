<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>
<%@ page import="com.springmvc.domain.Solution"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 솔루션 관리 - ReCook</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin.css">
</head>
<body>

	<div class="admin-container">

		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

		<div class="main">

			<div class="top-bar">
				<h1>솔루션 관리</h1>
			</div>

			<div class="recent">

				<div style="margin-bottom: 20px;">
					<h2 style="margin: 0;">솔루션 목록</h2>
				</div>

				<table>
					<thead>
						<tr>
							<th>번호</th>
							<th>카테고리</th>
							<th>제목</th>
							<th>작성자</th>
							<th>조회수</th>
							<th>등록일</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<%
						List<Solution> solutionList = (List<Solution>) request.getAttribute("solutionList");
						if (solutionList != null && !solutionList.isEmpty()) {
							for (Solution solution : solutionList) {
						%>
						<tr>
							<td><%= solution.getS_no() %></td>
							<td>
								<%= solution.getS_category().equals("kitchen") ? "🍳 주방" : "🥬 재료" %>
							</td>
							<td>
								<a href="${pageContext.request.contextPath}/solution/detail?s_no=<%= solution.getS_no() %>">
									<%= solution.getS_title() %>
								</a>
							</td>
							<td><%= solution.getM_nickname() %></td>
							<td><%= solution.getS_hit() %></td>
							<td><%= solution.getS_datetime() %></td>
							<td>
								<div class="action-buttons">
									<a href="${pageContext.request.contextPath}/admin/solution/delete?s_no=<%= solution.getS_no() %>"
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
							<td colspan="7" style="text-align: center; color: #999;">등록된 솔루션이 없습니다.</td>
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