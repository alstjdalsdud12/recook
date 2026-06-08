<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.springmvc.domain.Solution"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kitchen Solution | ReCook</title>
    
    <link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/kitchen.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css">
</head>
<body>
    <%@ include file="/WEB-INF/views/common/header.jsp"%>

    <%
    List<Solution> solutionList = (List<Solution>) request.getAttribute("solutionList");
    %>

    <main class="kitchen-container">
        <header class="kitchen-header">
            <span class="category-name">Kitchen Solution</span>
            <h1>주방을 더 가볍게, 요리를 더 즐겁게.</h1>
            <p class="header-desc">효율적인 주방 관리를 위한 ReCook의 지혜</p>
            <div class="action-area">
                <a href="${pageContext.request.contextPath}/solution/write" class="btn-write-outline">
                    <i class="fa-solid fa-pen-nib"></i> 주방 솔루션 공유하기
                </a>
            </div>
        </header>

        <section class="card-grid">
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
            <article class="card-item" onclick="location.href='${pageContext.request.contextPath}/solution/detail?s_no=<%= solution.getS_no() %>'">
                <div class="card-thumb" style="background-image:url('<%= imageUrl %>'); background-size:cover; background-position:center;"></div>
                <div class="card-body">
                    <h3 class="card-title"><%= solution.getS_title() %></h3>
                    <p class="card-text"><%= solution.getS_summary() != null ? solution.getS_summary() : "" %></p>
                    <div class="card-meta">
                        <span><i class="fa-regular fa-eye"></i> <%= solution.getS_hit() %></span>
                        <span><%= solution.getM_nickname() %></span>
                    </div>
                    <a href="${pageContext.request.contextPath}/solution/detail?s_no=<%= solution.getS_no() %>" class="btn-link">VIEW DETAILS</a>
                </div>
            </article>
            <%
                }
            } else {
            %>
            <div style="text-align:center; padding:80px; color:#999; grid-column:1/-1;">
                <p>등록된 주방 솔루션이 없습니다.</p>
                <a href="${pageContext.request.contextPath}/solution/write" style="color:#ff6b6b;">첫 번째 솔루션을 공유해보세요!</a>
            </div>
            <%
            }
            %>
        </section>

        <footer class="kitchen-footer">
            <a href="${pageContext.request.contextPath}/solution" class="btn-back">BACK TO LIST</a>
        </footer>
    </main>

    <a href="${pageContext.request.contextPath}/solution/write" class="floating-write-btn" title="솔루션 작성하기">
        <i class="fa-solid fa-plus"></i>
    </a>

    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>