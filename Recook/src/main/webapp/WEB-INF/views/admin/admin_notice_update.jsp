<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정 - ReCook</title>

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
				<h1>공지사항 수정</h1>
			</div>

			<div class="form-wrapper">

				<%
					com.springmvc.domain.Notice notice = (com.springmvc.domain.Notice) request.getAttribute("notice");
					if (notice != null) {
				%>

				<form action="${pageContext.request.contextPath}/notice/update" method="post">

					<input type="hidden" name="n_no" value="<%= notice.getN_no() %>">

					<div class="form-group">
						<label for="title">제목:</label>
						<input type="text" id="title" name="n_title" value="<%= notice.getN_title() %>" placeholder="제목을 입력하세요" required>
					</div>

					<div class="form-group">
						<label for="content">내용:</label>
						<textarea id="content" name="n_content" placeholder="내용을 입력하세요" required><%= notice.getN_content() %></textarea>
					</div>

					<div class="button-group">
						<button type="submit" class="btn-submit">수정 완료</button>
						<a href="${pageContext.request.contextPath}/admin/admin_notice" class="btn-cancel">취소</a>
					</div>

				</form>

				<%
					} else {
				%>

				<p style="text-align: center; color: #999;">공지사항을 찾을 수 없습니다.</p>

				<%
					}
				%>

			</div>

		</div>

	</div>

</body>
</html>