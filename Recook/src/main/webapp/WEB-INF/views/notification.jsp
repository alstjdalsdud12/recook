<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="com.springmvc.domain.Notification"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알림 - ReCook</title>
<link rel="stylesheet"
href="${pageContext.request.contextPath}/resources/css/header.css">
<style>
body { margin: 0; background: #f5f5f7; font-family: -apple-system, BlinkMacSystemFont, sans-serif; }
.notification-container { width: 700px; margin: 120px auto 80px; }
.notification-top { margin-bottom: 20px; }
.notification-top h1 { font-size: 28px; }
.notification-item { background: white; border-radius: 16px; padding: 20px 25px; margin-bottom: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
.notification-content { font-size: 15px; margin-bottom: 8px; }
.notification-date { font-size: 12px; color: #999; }
.no-notification { text-align: center; color: #999; padding: 50px; }
</style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<%
List<Notification> notificationList = (List<Notification>) request.getAttribute("notificationList");
%>

<div class="notification-container">
    <div class="notification-top">
        <h1>🔔 알림</h1>
    </div>

    <%
    if (notificationList != null && !notificationList.isEmpty()) {
        for (Notification n : notificationList) {
    %>
    <div class="notification-item">
        <div class="notification-content"><%= n.getN_content() %></div>
        <div class="notification-date"><%= n.getN_datetime() %></div>
    </div>
    <%
        }
    } else {
    %>
    <div class="no-notification">알림이 없습니다.</div>
    <%
    }
    %>
</div>

</body>
</html>