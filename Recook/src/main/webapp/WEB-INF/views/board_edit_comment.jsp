<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 수정</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/board_edit_comment.css">
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div class="comment-edit-container">
	<div class="comment-edit-box">

		<h1>댓글 수정</h1>

		<form action="${pageContext.request.contextPath}/board/comment/update" method="post">
			<input type="hidden" name="boardId" value="${board.b_id}">
			<input type="hidden" name="commentId" value="${comment.bc_id}">
			<textarea name="content" required>${comment.bc_content}</textarea>
			<button type="submit">수정 완료</button>
		</form>

	</div>
</div>

</body>
</html>