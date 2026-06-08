<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.springmvc.domain.Solution"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Solutions | ReCook Archive</title>
    
    <link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/all_solution.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css">
</head>
<body>
    <%@ include file="/WEB-INF/views/common/header.jsp"%>

    <%
    List<Solution> solutionList = (List<Solution>) request.getAttribute("solutionList");
    %>

    <main class="main-container">
        <div class="solution-wrapper">

            <header class="solution-header">
                <span class="sub-label">RECOOK ARCHIVE</span>
                <h1>Every Solutions.</h1>
                <p>주방 관리부터 식재료 보관까지, ReCook의 모든 지혜를 기록합니다.</p>
                <div class="action-area">
                    <a href="${pageContext.request.contextPath}/solution/write" class="btn-write-outline">
                        <i class="fa-solid fa-pen-nib"></i> 나만의 솔루션 공유하기
                    </a>
                </div>
            </header>

            <div class="solution-grid">
                <%
                if (solutionList != null && !solutionList.isEmpty()) {
                    for (Solution solution : solutionList) {
                        String imageUrl;
                        if (solution.getS_image() == null || solution.getS_image().isEmpty()) {
                            imageUrl = request.getContextPath() + "/resources/images/default.png";
                        } else {
                            imageUrl = request.getContextPath() + "/recipeimage/" + solution.getS_image();
                        }
                %>
                <article class="solution-card" onclick="location.href='${pageContext.request.contextPath}/solution/detail?s_no=<%= solution.getS_no() %>'">
                    <div class="thumb-area" style="background-image:url('<%= imageUrl %>'); background-size:cover; background-position:center;">
                        <span class="category-badge <%= solution.getS_category().equals("kitchen") ? "kitchen" : "ingredient" %>">
                            <%= solution.getS_category().equals("kitchen") ? "KITCHEN" : "INGREDIENTS" %>
                        </span>
                    </div>
                    <div class="info-area">
                        <h3 class="card-title"><%= solution.getS_title() %></h3>
                        <p class="card-desc"><%= solution.getS_summary() != null ? solution.getS_summary() : "" %></p>
                        <div class="card-meta">
                            <span><i class="fa-regular fa-eye"></i> <%= solution.getS_hit() %></span>
                            <span><%= solution.getM_nickname() %></span>
                        </div>
                        <a href="${pageContext.request.contextPath}/solution/detail?s_no=<%= solution.getS_no() %>" class="view-more">VIEW DETAILS &rarr;</a>
                    </div>
                </article>
                <%
                    }
                } else {
                %>
                <div style="text-align:center; padding:80px; color:#999; grid-column:1/-1;">
                    <p>등록된 솔루션이 없습니다.</p>
                    <a href="${pageContext.request.contextPath}/solution/write" style="color:#ff6b6b;">첫 번째 솔루션을 공유해보세요!</a>
                </div>
                <%
                }
                %>
            </div>

            <div class="pagination-area">
                <a href="${pageContext.request.contextPath}/solution" class="btn-back">RETURN TO CATEGORY</a>
            </div>

        </div>
    </main>

    <a href="${pageContext.request.contextPath}/solution/write" class="floating-write-btn" title="솔루션 작성하기">
        <i class="fa-solid fa-plus"></i>
    </a>

    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>