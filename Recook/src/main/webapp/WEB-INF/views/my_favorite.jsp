<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="com.springmvc.domain.Recipe"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>즐겨찾기</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet"
href="${pageContext.request.contextPath}/resources/css/my_favorite.css">
</head>

<body>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div class="favorite-container">

    <div class="favorite-top">
        <h1>즐겨찾기</h1>
    </div>

    <div class="favorite-list">
        <%
        List<Recipe> favoriteList = (List<Recipe>) request.getAttribute("favoriteList");
        if (favoriteList != null && !favoriteList.isEmpty()) {
            for (Recipe recipe : favoriteList) {
                String imageUrl;
                if (recipe.getR_image() == null || recipe.getR_image().isEmpty()) {
                    imageUrl = request.getContextPath() + "/resources/images/default.png";
                } else {
                    imageUrl = request.getContextPath() + "/recipeimage/" + recipe.getR_image();
                }
        %>
        <div class="favorite-item"
            onclick="location.href='${pageContext.request.contextPath}/recipe_detail?r_no=<%= recipe.getR_no() %>'">
            <img src="<%= imageUrl %>" class="favorite-thumb" onerror="this.style.display='none'">
            <div class="favorite-info">
                <div class="recipe-title">🍳 <%= recipe.getR_title() %></div>
                <div class="recipe-info">
                    조회수 <%= recipe.getR_hit() %> · ⭐ <%= String.format("%.1f", recipe.getAvg_rating()) %>
                </div>
            </div>
            <button class="favorite-delete-btn"
                onclick="event.stopPropagation(); if(confirm('즐겨찾기에서 삭제하시겠습니까?')) location.href='${pageContext.request.contextPath}/mypage/favorite/toggle?r_no=<%= recipe.getR_no() %>'">
                ★ 삭제
            </button>
        </div>
        <%
            }
        } else {
        %>
        <div style="text-align:center; color:#999; padding:50px;">즐겨찾기한 레시피가 없습니다.</div>
        <%
        }
        %>
    </div>

</div>

</body>
</html>