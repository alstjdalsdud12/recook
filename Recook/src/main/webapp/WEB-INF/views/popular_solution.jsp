<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.springmvc.domain.Solution"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인기 솔루션 - ReCook</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/solution.css">
<style>
    .rank-badge {
        position: absolute;
        top: 10px;
        left: 10px;
        background: #FF6B6B;
        color: white;
        padding: 5px 12px;
        border-radius: 15px;
        font-weight: bold;
        font-size: 14px;
        z-index: 10;
    }
    .solution-card { position: relative; cursor: pointer; }
    .solution-thumb {
        height: 160px;
        background-size: cover;
        background-position: center;
        background-color: #eee;
        border-radius: 12px 12px 0 0;
    }
</style>
</head>
<body>
    <%@ include file="/WEB-INF/views/common/header.jsp"%>

    <%
    List<Solution> solutionList = (List<Solution>) request.getAttribute("solutionList");
    %>

    <div class="main-container">
        <div class="solution-wrapper">

            <div class="solution-header">
                <h1>인기 솔루션</h1>
                <p>지금 ReCook 사용자들이 가장 많이 찾아본 베스트 팁입니다.</p>
            </div>

            <div class="solution-list">
                <%
                if (solutionList != null && !solutionList.isEmpty()) {
                    int rank = 1;
                    for (Solution solution : solutionList) {
                        String imageUrl;
                        if (solution.getS_image() == null || solution.getS_image().isEmpty()) {
                            imageUrl = request.getContextPath() + "/resources/images/default.png";
                        } else {
                            imageUrl = request.getContextPath() + "/recipeimage/" + solution.getS_image();
                        }
                %>
                <div class="solution-card" onclick="location.href='${pageContext.request.contextPath}/solution/detail?s_no=<%= solution.getS_no() %>'">
                    <div class="rank-badge">BEST <%= rank %></div>
                    <div class="solution-thumb" style="background-image:url('<%= imageUrl %>');"></div>
                    <div class="solution-info">
                        <span class="category-tag" style="color:<%= solution.getS_category().equals("kitchen") ? "#FF6B6B" : "#4CAF50" %>; font-size:11px; font-weight:bold;">
                            <%= solution.getS_category().equals("kitchen") ? "주방" : "재료" %>
                        </span>
                        <div class="title"><%= solution.getS_title() %></div>
                        <div class="desc">조회수 <%= solution.getS_hit() %> | <%= solution.getS_summary() != null ? solution.getS_summary() : "" %></div>
                    </div>
                </div>
                <%
                        rank++;
                    }
                } else {
                %>
                <div style="text-align:center; padding:80px; color:#999;">
                    <p>등록된 인기 솔루션이 없습니다.</p>
                </div>
                <%
                }
                %>
            </div>

            <div style="text-align: center; margin-top: 50px;">
                <a href="${pageContext.request.contextPath}/solution" class="category-card" style="display: inline-block;">솔루션 메인으로</a>
            </div>

        </div>
    </div>
</body>
</html>