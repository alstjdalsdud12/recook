<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="com.springmvc.domain.Recipe"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>최근에 본 레시피</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet"
href="${pageContext.request.contextPath}/resources/css/my_look.css">
<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>

<body>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div class="look-container">

    <div class="look-top">
        <div>
            <p class="look-sub">MY PAGE</p>
            <h1>최근에 본 레시피</h1>
        </div>
    </div>

    <div class="recipe-grid">
        <%
        List<Recipe> recentViewList = (List<Recipe>) request.getAttribute("recentViewList");
        if (recentViewList != null && !recentViewList.isEmpty()) {
            for (Recipe recipe : recentViewList) {
                String imageUrl;
                if (recipe.getR_image() == null || recipe.getR_image().isEmpty()) {
                    imageUrl = request.getContextPath() + "/resources/images/default.png";
                } else {
                    imageUrl = request.getContextPath() + "/recipeimage/" + recipe.getR_image();
                }
        %>
        <div class="recipe-card"
            onclick="location.href='${pageContext.request.contextPath}/recipe_detail?r_no=<%= recipe.getR_no() %>'">
            <div class="recipe-image" style="background-image:url('<%= imageUrl %>'); background-size:cover; background-position:center;">
            </div>
            <div class="recipe-content">
                <h2><%= recipe.getR_title() %></h2>
                <p><%= recipe.getR_content().length() > 50 ? recipe.getR_content().substring(0, 50) + "..." : recipe.getR_content() %></p>
                <div class="recipe-bottom">
                    <span>
                        <i class="fa-solid fa-eye"></i>
                        조회수 <%= recipe.getR_hit() %>
                    </span>
                    <span>⭐ <%= String.format("%.1f", recipe.getAvg_rating()) %></span>
                </div>
            </div>
        </div>
        <%
            }
        } else {
        %>
        <div style="text-align:center; color:#999; padding:50px;">최근에 본 레시피가 없습니다.</div>
        <%
        }
        %>
    </div>

</div>

</body>
</html>