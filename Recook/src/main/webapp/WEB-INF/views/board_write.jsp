<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/board_write.css">
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div class="write-container">
	<div class="write-box">

		<h1 class="write-title">게시글 작성</h1>

		<form action="${pageContext.request.contextPath}/board/save"
			method="post" enctype="multipart/form-data">

			<input type="text" name="title" placeholder="제목 입력" required>
			<textarea name="content" placeholder="내용 입력" required></textarea>
			<input type="file" name="imageFiles" multiple accept="image/*">
			<button type="submit">등록</button>

		</form>

	</div>
</div>

</body>
</html>