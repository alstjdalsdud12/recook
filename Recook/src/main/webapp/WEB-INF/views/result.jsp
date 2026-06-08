<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.springmvc.domain.Recipe"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recook | Premium Recipes</title>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/result.css">
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <%
    List<Recipe> recipeList = (List<Recipe>) request.getAttribute("recipeList");
    String ingredients = (String) request.getAttribute("ingredients");
    int totalCount = recipeList != null ? recipeList.size() : 0;
    %>

    <main class="container">
        <section class="result-summary">
            <span class="summary-badge">Meticulously Matched</span>
            <h1>선택하신 재료로 찾은<br><span>최상의 미식 레시피</span></h1>
            <div class="selected-ingredients" id="selectedIngredients"></div>
        </section>

        <div class="filter-bar">
            <span class="total-count">총 <strong id="totalCount"><%= totalCount %></strong>개의 레시피 추천</span>
            <div class="sort-options">
                <span class="active">매칭률순</span>
            </div>
        </div>

        <div class="recipe-grid">
            <%
            if (recipeList != null && !recipeList.isEmpty()) {
                for (Recipe recipe : recipeList) {
                    String imageUrl;
                    if (recipe.getR_image() == null || recipe.getR_image().isEmpty()) {
                        imageUrl = request.getContextPath() + "/resources/images/default.png";
                    } else {
                        imageUrl = request.getContextPath() + "/recipeimage/" + recipe.getR_image();
                    }
            %>
            <div class="recipe-card">
                <div class="card-image-wrap">
                    <img src="<%= imageUrl %>" alt="<%= recipe.getR_title() %>" 
     onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/images/default.png'">
                    <span class="match-rate">⭐ <%= String.format("%.1f", recipe.getAvg_rating()) %></span>
                </div>
                <div class="card-body">
                    <div class="recipe-meta">
                        <span class="difficulty"><i class="fa-solid fa-gauge-high"></i> <%= recipe.getR_difficulty() != null ? recipe.getR_difficulty() : "-" %></span>
                        <span class="cooking-time"><i class="fa-regular fa-clock"></i> <%= recipe.getR_cooking_time() %> mins</span>
                    </div>
                    <h3 class="recipe-title"><%= recipe.getR_title() %></h3>
                    <p class="recipe-desc">
                        <%= recipe.getR_content() != null && recipe.getR_content().length() > 60
                            ? recipe.getR_content().substring(0, 60) + "..."
                            : recipe.getR_content() %>
                    </p>
                    <div class="card-footer">
                        <span class="chef-tag"><i class="fa-solid fa-utensils"></i> <%= recipe.getM_nickname() %></span>
                        <a href="${pageContext.request.contextPath}/recipe_detail?r_no=<%= recipe.getR_no() %>" class="view-detail-btn">
                            레시피 보기 <i class="fa-solid fa-chevron-right"></i>
                        </a>
                    </div>
                </div>
            </div>
            <%
                }
            } else {
            %>
            <div style="text-align:center; padding:80px; color:#999; grid-column: 1/-1;">
                <p style="font-size:18px;">입력하신 재료로 만들 수 있는 레시피가 없습니다.</p>
                <a href="${pageContext.request.contextPath}/" style="color:#ff6b6b;">다른 재료로 검색하기</a>
            </div>
            <%
            }
            %>
        </div>

        <div class="bottom-action">
            <p>원하는 레시피가 없으신가요?</p>
            <a href="${pageContext.request.contextPath}/" class="retry-btn">
                <i class="fa-solid fa-rotate-left"></i> 다른 재료 선택하기
            </a>
        </div>
    </main>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const urlParams = new URLSearchParams(window.location.search);
            const ingredientsParam = urlParams.get('ingredients');
            const selectedIngredientsContainer = document.getElementById('selectedIngredients');

            if (ingredientsParam) {
                const ingredientsArray = ingredientsParam.split(',');
                ingredientsArray.forEach(function(item) {
                    const cleanItem = item.trim();
                    if (cleanItem !== "") {
                        const badge = document.createElement('span');
                        badge.className = 'ing-badge';
                        badge.textContent = cleanItem;
                        selectedIngredientsContainer.appendChild(badge);
                    }
                });
            } else {
                selectedIngredientsContainer.innerHTML = '<span class="ing-badge">선택된 재료 없음</span>';
            }
        });
    </script>
</body>
</html>