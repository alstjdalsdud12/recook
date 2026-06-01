<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.springmvc.domain.Recipe"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>분류별 레시피 - ReCook</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/recipe_type.css">

</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<%
    String currentColumn = (String) request.getAttribute("column");
    String currentValue = (String) request.getAttribute("value");
    if (currentColumn == null) currentColumn = "r_type";
    if (currentValue == null) currentValue = "";
    List<Recipe> recipeList = (List<Recipe>) request.getAttribute("recipeList");
%>

<div class="main-container">

    <div class="wrapper">

        <div class="header-box">
            <h1>분류별 레시피</h1>
            <p>원하는 기준으로 레시피를 찾아보세요</p>
        </div>

        <div class="filter-box">
            <button class="filter <%= currentColumn.equals("r_type") ? "active" : "" %>"
                onclick="setCategory('r_type', this)">종류별</button>
            <button class="filter <%= currentColumn.equals("r_situation") ? "active" : "" %>"
                onclick="setCategory('r_situation', this)">상황별</button>
            <button class="filter <%= currentColumn.equals("r_method") ? "active" : "" %>"
                onclick="setCategory('r_method', this)">방법별</button>
        </div>

        <div class="sub-text" id="subText">
            <% if (currentColumn.equals("r_type")) { %>
                <span class="<%= currentValue.equals("밥") ? "active" : "" %>" onclick="filterDetail('r_type', '밥')">밥</span> ·
                <span class="<%= currentValue.equals("국") ? "active" : "" %>" onclick="filterDetail('r_type', '국')">국</span> ·
                <span class="<%= currentValue.equals("반찬") ? "active" : "" %>" onclick="filterDetail('r_type', '반찬')">반찬</span> ·
                <span class="<%= currentValue.equals("국수") ? "active" : "" %>" onclick="filterDetail('r_type', '국수')">국수</span> ·
                <span class="<%= currentValue.equals("찌개") ? "active" : "" %>" onclick="filterDetail('r_type', '찌개')">찌개</span> ·
                <span class="<%= currentValue.equals("디저트") ? "active" : "" %>" onclick="filterDetail('r_type', '디저트')">디저트</span>
            <% } else if (currentColumn.equals("r_situation")) { %>
                <span class="<%= currentValue.equals("일상") ? "active" : "" %>" onclick="filterDetail('r_situation', '일상')">일상</span> ·
                <span class="<%= currentValue.equals("손님 접대") ? "active" : "" %>" onclick="filterDetail('r_situation', '손님 접대')">손님 접대</span> ·
                <span class="<%= currentValue.equals("파티") ? "active" : "" %>" onclick="filterDetail('r_situation', '파티')">파티</span> ·
                <span class="<%= currentValue.equals("도시락") ? "active" : "" %>" onclick="filterDetail('r_situation', '도시락')">도시락</span>
            <% } else if (currentColumn.equals("r_method")) { %>
                <span class="<%= currentValue.equals("볶음") ? "active" : "" %>" onclick="filterDetail('r_method', '볶음')">볶음</span> ·
                <span class="<%= currentValue.equals("끓임") ? "active" : "" %>" onclick="filterDetail('r_method', '끓임')">끓임</span> ·
                <span class="<%= currentValue.equals("조림") ? "active" : "" %>" onclick="filterDetail('r_method', '조림')">조림</span> ·
                <span class="<%= currentValue.equals("구이") ? "active" : "" %>" onclick="filterDetail('r_method', '구이')">구이</span> ·
                <span class="<%= currentValue.equals("찜") ? "active" : "" %>" onclick="filterDetail('r_method', '찜')">찜</span> ·
                <span class="<%= currentValue.equals("무침") ? "active" : "" %>" onclick="filterDetail('r_method', '무침')">무침</span>
            <% } %>
        </div>

        <div class="recipe-list" id="recipeList">
            <%
            if (recipeList != null && !recipeList.isEmpty()) {
                for (Recipe recipe : recipeList) {
                    String imagePath = recipe.getR_image();
                    String imageUrl;
                    if (imagePath == null || imagePath.isEmpty()) {
                        imageUrl = request.getContextPath() + "/resources/images/default.png";
                    } else {
                        imageUrl = request.getContextPath() + "/recipeimage/" + imagePath;
                    }
            %>
            <a href="${pageContext.request.contextPath}/recipe_detail?r_no=<%= recipe.getR_no() %>" class="card">
                <div class="thumb" style="background-image: url('<%= imageUrl %>'); background-size: cover; background-position: center;"></div>
                <div class="info">
                    <div class="title"><%= recipe.getR_title() %></div>
                    <div class="author"><%= recipe.getM_nickname() %></div>
                    <div class="rating">⭐ <%= String.format("%.1f", recipe.getAvg_rating()) %></div>
                    <div class="hits">조회 <%= recipe.getR_hit() %></div>
                </div>
            </a>
            <%
                }
            } else if (!currentValue.isEmpty()) {
            %>
            <p class="no-result">해당 분류의 레시피가 없습니다.</p>
            <%
            }
            %>
        </div>

    </div>

</div>

<div class="pagination" id="pagination"></div>

<script>
function setCategory(column, btn) {
    document.querySelectorAll(".filter").forEach(b => b.classList.remove("active"));
    btn.classList.add("active");

    let subText = "";
    if (column === "r_type") {
        subText = `
            <span onclick="filterDetail('r_type', '밥')">밥</span> ·
            <span onclick="filterDetail('r_type', '국')">국</span> ·
            <span onclick="filterDetail('r_type', '반찬')">반찬</span> ·
            <span onclick="filterDetail('r_type', '국수')">국수</span> ·
            <span onclick="filterDetail('r_type', '찌개')">찌개</span> ·
            <span onclick="filterDetail('r_type', '디저트')">디저트</span>
        `;
    } else if (column === "r_situation") {
        subText = `
            <span onclick="filterDetail('r_situation', '일상')">일상</span> ·
            <span onclick="filterDetail('r_situation', '손님 접대')">손님 접대</span> ·
            <span onclick="filterDetail('r_situation', '파티')">파티</span> ·
            <span onclick="filterDetail('r_situation', '도시락')">도시락</span>
        `;
    } else if (column === "r_method") {
        subText = `
            <span onclick="filterDetail('r_method', '볶음')">볶음</span> ·
            <span onclick="filterDetail('r_method', '끓임')">끓임</span> ·
            <span onclick="filterDetail('r_method', '조림')">조림</span> ·
            <span onclick="filterDetail('r_method', '구이')">구이</span> ·
            <span onclick="filterDetail('r_method', '찜')">찜</span> ·
            <span onclick="filterDetail('r_method', '무침')">무침</span>
        `;
    }
    document.getElementById("subText").innerHTML = subText;
}

function filterDetail(column, value) {
    location.href = "${pageContext.request.contextPath}/recipe_type?column=" + column + "&value=" + encodeURIComponent(value);
}

const itemsPerPage = 20;
let currentPage = 1;

function initPagination() {
    const list = document.getElementById("recipeList");
    const items = Array.from(list.children);
    const totalPages = Math.ceil(items.length / itemsPerPage);
    const pagination = document.getElementById("pagination");
    pagination.innerHTML = "";

    for (let i = 1; i <= totalPages; i++) {
        const btn = document.createElement("button");
        btn.textContent = i;
        btn.onclick = () => showPage(i);
        pagination.appendChild(btn);
    }
    showPage(1);
}

function showPage(page) {
    currentPage = page;
    const list = document.getElementById("recipeList");
    const items = Array.from(list.children);
    const start = (page - 1) * itemsPerPage;
    const end = start + itemsPerPage;
    items.forEach((item, index) => {
        item.style.display = (index >= start && index < end) ? "block" : "none";
    });
}

window.onload = function() {
    initPagination();
}
</script>

</body>
</html>