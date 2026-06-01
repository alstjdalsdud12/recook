<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 작성 - ReCook</title>

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
				<h1>공지사항 작성</h1>
			</div>

			<div class="form-wrapper">

				<form action="${pageContext.request.contextPath}/notice/write" method="post">

					<div class="form-group">
						<label for="title">제목:</label>
						<input type="text" id="title" name="n_title" placeholder="제목을 입력하세요" required>
					</div>

					<div class="form-group">
						<label for="content">내용:</label>
						<textarea id="content" name="n_content" placeholder="내용을 입력하세요" required></textarea>
					</div>

					<div class="button-group">
						<button type="submit" class="btn-submit">등록</button>
						<a href="${pageContext.request.contextPath}/admin/admin_notice" class="btn-cancel">취소</a>
					</div>

				</form>

			</div>

		</div>

	</div>

</body>
</html>