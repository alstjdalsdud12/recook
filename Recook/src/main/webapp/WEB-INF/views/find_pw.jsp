<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="common/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기 - ReCook</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/find_pw.css">

</head>
<body>

<div class="main-container">
    <div class="find-box">

        <div class="find-title">비밀번호 찾기</div>

        <form action="${pageContext.request.contextPath}/find_pw" method="post">

            <div class="input-group">
                <input type="text" name="id" placeholder="아이디 입력">
            </div>

            <div class="input-group">
                <input type="email" name="email" placeholder="이메일 입력">
            </div>

            <button type="submit" class="find-submit">비밀번호 찾기</button>

        </form>

        <!-- 결과 출력 -->
        <div class="result">
            ${result}
        </div>

        <div class="extra">
            <a href="${pageContext.request.contextPath}/login">로그인으로 돌아가기</a>
        </div>

    </div>
</div>

</body>
</html>
