<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/board_edit.css">
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div class="edit-container">
	<div class="edit-box">

		<h1 class="edit-title">게시글 수정</h1>

		<form action="${pageContext.request.contextPath}/board/update" method="post">
			<input type="hidden" name="id" value="${board.b_id}">
			<input type="text" name="title" value="${board.b_title}" required>
			<textarea name="content" required>${board.b_content}</textarea>
			<button type="submit">수정 완료</button>
		</form>

	</div>
</div>

</body>
</html>