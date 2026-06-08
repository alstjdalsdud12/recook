<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.springmvc.domain.Solution"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>솔루션 상세 - ReCook</title>

<link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/solution_detail.css">
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<%
Solution solution = (Solution) request.getAttribute("solution");
String imageUrl;
if (solution.getS_image() == null || solution.getS_image().isEmpty()) {
    imageUrl = request.getContextPath() + "/resources/images/default.png";
} else {
    imageUrl = request.getContextPath() + "/recipeimage/" + solution.getS_image();
}
%>

<div class="main-container">
    <div class="detail-wrapper">

        <div class="image-box">
            <img src="<%= imageUrl %>" class="product-img"
                onclick="openModal(this)"
                onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/resources/images/default.png'">
            <div class="hits">조회수 <%= solution.getS_hit() %></div>
        </div>

        <div class="title-row">
            <h1 class="product-title"><%= solution.getS_title() %></h1>
            <div class="category-badge">
                <%= solution.getS_category().equals("kitchen") ? "🍳 주방 솔루션" : "🥬 재료 솔루션" %>
            </div>
        </div>

        <p class="product-desc"><%= solution.getS_summary() != null ? solution.getS_summary() : "" %></p>

        <div class="info-box">
            <div>👤 <%= solution.getM_nickname() %></div>
            <div>📅 <%= solution.getS_datetime() %></div>
            <button class="share-btn" onclick="copyUrl()">공유</button>
        </div>

        <div class="content-section">
            <h2 class="section-title">상세 내용</h2>
            <div class="content-box" style="white-space:pre-line; line-height:1.8; font-size:16px;">
                <%= solution.getS_content() %>
            </div>
        </div>

        <div class="author-section">
            <h2 class="section-title">작성자</h2>
            <div class="author-box">
                <div class="author-info">
                    <div class="author-name"><%= solution.getM_nickname() %></div>
                </div>
            </div>
        </div>

        <div style="margin-top:40px;">
            <button class="share-btn" onclick="history.back()">← 뒤로가기</button>
        </div>

    </div>
</div>

<div id="imgModal" class="modal">
    <span class="close-btn" onclick="closeModal()">×</span>
    <img id="modalImg" class="modal-content">
</div>

<div id="copyPopup" class="copy-popup">URL이 복사되었습니다 🙂</div>

<script>
function openModal(img) {
    document.getElementById("imgModal").style.display = "flex";
    document.getElementById("modalImg").src = img.src;
}
function closeModal() {
    document.getElementById("imgModal").style.display = "none";
}
document.getElementById("imgModal").addEventListener("click", function(e) {
    if (e.target === this) closeModal();
});
function copyUrl() {
    navigator.clipboard.writeText(window.location.href);
    const popup = document.getElementById("copyPopup");
    popup.classList.add("show");
    setTimeout(() => popup.classList.remove("show"), 2000);
}
</script>

</body>
</html>