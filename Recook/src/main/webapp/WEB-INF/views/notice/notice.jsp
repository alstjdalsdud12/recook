<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 - ReCook</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/notice.css">

</head>
<body>

	<div class="main-container">

		<div class="notice-wrapper">

			<div class="title-wrapper">
				<h1 class="title">공지사항</h1>

			</div>

			<table class="notice-table">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성일</th>
					</tr>
				</thead>

				<tbody>
					<%
						java.util.List<com.springmvc.domain.Notice> noticeList = 
							(java.util.List<com.springmvc.domain.Notice>) request.getAttribute("noticeList");
						
						if (noticeList != null && noticeList.size() > 0) {
							for (com.springmvc.domain.Notice notice : noticeList) {
					%>
					<tr>
						<td><%= notice.getN_no() %></td>
						<td><a href="${pageContext.request.contextPath}/notice/detail?n_no=<%= notice.getN_no() %>"><%= notice.getN_title() %></a></td>
						<td><%= notice.getN_datetime() %></td>
					</tr>
					<%
							}
						} else {
					%>
					<tr>
						<td colspan="3" style="text-align: center; color: #999;">등록된 공지사항이 없습니다.</td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>

		</div>

	</div>

</body>
</html>