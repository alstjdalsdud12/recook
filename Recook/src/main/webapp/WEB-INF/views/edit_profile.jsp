<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="com.springmvc.domain.Member"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet"
href="${pageContext.request.contextPath}/resources/css/edit_profile.css">
</head>

<body>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<%
Member member = (Member) request.getAttribute("member");
%>

<div class="edit-container">
    <div class="edit-card">

        <h1>회원정보 수정</h1>

        <form action="${pageContext.request.contextPath}/edit_profile/save" method="post">
            <input type="hidden" name="m_no" value="<%= member.getM_no() %>">

            <!-- 닉네임 -->
            <div class="input-box">
                <label>닉네임</label>
                <input type="text" name="m_nickname" value="<%= member.getM_nickname() %>">
            </div>

            <!-- 아이디 -->
            <div class="input-box">
                <label>아이디</label>
                <input type="text" value="<%= member.getM_id() %>" readonly style="background:#f5f5f5; color:#aaa;">
            </div>

            <!-- 비밀번호 -->
            <div class="input-box">
                <label>비밀번호</label>
                <input type="password" name="m_pw" placeholder="새 비밀번호 입력 (변경 시에만)">
            </div>

            <!-- 비밀번호 확인 -->
            <div class="input-box">
                <label>비밀번호 확인</label>
                <input type="password" name="m_pw_check" placeholder="비밀번호 다시 입력">
            </div>

            <!-- 전화번호 -->
            <div class="input-box">
                <label>전화번호</label>
                <input type="text" name="m_phone" value="<%= member.getM_phone() != null ? member.getM_phone() : "" %>">
            </div>

            <!-- 이메일 -->
            <div class="input-box">
                <label>이메일</label>
                <input type="email" name="m_email" value="<%= member.getM_email() %>">
            </div>

            <button type="submit" class="save-btn">저장하기</button>

        </form>

    </div>
</div>

</body>
</html>