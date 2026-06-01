<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세보기 - ReCook</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/notice.css">

</head>
<body>

	<div class="main-container">

		<div class="notice-wrapper">

			<%
			com.springmvc.domain.Notice notice = (com.springmvc.domain.Notice) request.getAttribute("notice");
			if (notice != null) {
			%>

			<h1 class="title"><%=notice.getN_title()%></h1>

			<div class="notice-date">
				<%=notice.getN_datetime()%>
			</div>

			<div class="notice-content">
				<%=notice.getN_content()%>
			</div>

			<div class="button-group">
				<a href="${pageContext.request.contextPath}/notice/notice"
					class="btn btn-list">목록으로</a>
			</div>

			<%
			} else {
			%>

			<p class="no-data">공지사항을 찾을 수 없습니다.</p>

			<%
			}
			%>

		</div>

	</div>

</body>
</html>