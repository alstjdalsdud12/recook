<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="com.springmvc.domain.Recipe"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 쓴 글</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet"
href="${pageContext.request.contextPath}/resources/css/my_recipe.css">
</head>

<body>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div class="myboard-container">

    <div class="myboard-top">
        <h1>내가 쓴 글</h1>
    </div>

    <div class="myboard-list">
        <%
        List<Recipe> myRecipeList = (List<Recipe>) request.getAttribute("myRecipeList");
        if (myRecipeList != null && !myRecipeList.isEmpty()) {
            for (Recipe recipe : myRecipeList) {
        %>
        <div class="myboard-item"
            onclick="location.href='${pageContext.request.contextPath}/recipe_detail?r_no=<%= recipe.getR_no() %>'">
            <div class="board-left">
                <div class="board-title"><%= recipe.getR_title() %></div>
                <div class="board-info">
                    <%= recipe.getR_datetime() %> · 조회수 <%= recipe.getR_hit() %> · ⭐ <%= String.format("%.1f", recipe.getAvg_rating()) %>
                </div>
            </div>
        </div>
        <%
            }
        } else {
        %>
        <div style="text-align:center; color:#999; padding:50px;">작성한 레시피가 없습니다.</div>
        <%
        }
        %>
    </div>

</div>

</body>
</html>