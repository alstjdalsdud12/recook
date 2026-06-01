<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터 - ReCook</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/customer.css">

</head>
<body>

<div class="main-container">

    <div class="customer-wrapper">

        <div class="customer-header">
            <h1>고객센터</h1>
            <p>궁금한 점이 있으신가요?</p>
        </div>

        <div class="card-container">

            
            <a href="${pageContext.request.contextPath}/notice/notice" class="card">
                <div class="card-title">공지사항</div>
                <div class="card-desc">서비스 소식과 업데이트를 확인하세요</div>
            </a>

            <a href="${pageContext.request.contextPath}/qna" class="card">
                <div class="card-title">자주 묻는 질문</div>
                <div class="card-desc">많이 묻는 질문을 빠르게 확인하세요</div>
            </a>

            <a href="${pageContext.request.contextPath}/inquiry" class="card">
                <div class="card-title">1:1 문의</div>
                <div class="card-desc">문제가 있으신가요? 직접 문의하세요</div>
            </a>

        </div>

    </div>

</div>

</body>
</html>
