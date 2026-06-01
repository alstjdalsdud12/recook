<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 완료 - ReCook</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/inquiry_success.css">

</head>
<body>

	<div class="success-container">
		<div class="success-box">
			<div class="success-icon">✓</div>
			<h1>문의가 전송되었습니다</h1>
			<p>빠른 시간 내에 답변드리겠습니다.</p>
			<a href="${pageContext.request.contextPath}/" class="btn-home">홈으로</a>
		</div>
	</div>

</body>
</html>