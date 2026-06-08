<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="common/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 - ReCook</title>

<link rel="stylesheet"
    href="${pageContext.request.contextPath}/resources/css/header.css">

<link rel="stylesheet"
    href="${pageContext.request.contextPath}/resources/css/login.css">

</head>
<body>

<div class="main-container">
    <div class="login-box">

        <div class="login-title">ReCook 로그인</div>

        <form action="${pageContext.request.contextPath}/login" method="post">

            <div class="input-group">
                <input type="text" name="id" placeholder="아이디">
            </div>

            <div class="input-group">
                <input type="password" name="pw" placeholder="비밀번호">
            </div>

            <% if (request.getAttribute("loginError") != null) { %>
            <div class="login-error">
                <%= request.getAttribute("loginError") %>
            </div>
            <% } %>

            <button type="submit" class="login-submit">로그인</button>

        </form>

        <div class="extra">
            계정이 없으신가요?
            <a href="${pageContext.request.contextPath}/sign_up">회원가입</a>
        </div>

        <div class="extra-links">
            <a href="${pageContext.request.contextPath}/find_id">아이디 찾기</a> |
            <a href="${pageContext.request.contextPath}/find_pw">비밀번호 찾기</a>
        </div>

    </div>
</div>

</body>
</html>