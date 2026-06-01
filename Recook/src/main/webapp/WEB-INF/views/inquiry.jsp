<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1 문의 - ReCook</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/inquiry.css">

</head>
<body>

<%
	String userNickname = (String) session.getAttribute("m_nickname");
	String userEmail = (String) session.getAttribute("m_email");

	if (userNickname == null || userNickname.isEmpty()) {
%>
	<!-- 로그인 안 됨 -->
	<div class="login-required-overlay">
		<div class="login-required-box">
			<h2>로그인이 필요합니다</h2>
			<p>이 기능을 이용하려면 로그인을 해야 합니다.</p>
			<button class="btn-confirm" onclick="location.href='${pageContext.request.contextPath}/login'">확인</button>
		</div>
	</div>
<%
	} else {
%>
	<!-- 로그인 됨 -->
	<div class="main-container">

	    <div class="inquiry-wrapper">

	        <div class="inquiry-header">
	            <h1>1:1 문의</h1>
	            <p>문의사항을 남겨주시면 빠르게 답변드립니다</p>
	        </div>

	        <form action="${pageContext.request.contextPath}/inquiry" method="post">

	            <div class="input-group">
	                <label>제목</label>
	                <input type="text" name="i_title" placeholder="문의 제목을 입력하세요" required>
	            </div>

	            <div class="input-group">
	                <label>이메일</label>
	                <input type="email" name="i_email" value="<%= userEmail %>" readonly>
	            </div>

	            <div class="input-group">
	                <label>문의 내용</label>
	                <textarea name="i_content" rows="6" placeholder="문의 내용을 입력하세요" required></textarea>
	            </div>

	            <button type="submit" class="submit-btn">문의하기</button>

	        </form>

	    </div>

	</div>
<%
	}
%>

</body>
</html>