<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.springmvc.domain.Recipe"%>
<%@ page import="com.springmvc.domain.RecipeIngredient"%>
<%@ page import="com.springmvc.domain.RecipeStep"%>
<%@ page import="com.springmvc.domain.RecipeReview"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 상세 - ReCook</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/recipe_detail.css">

</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<%
    Recipe recipe = (Recipe) request.getAttribute("recipe");
    List<RecipeIngredient> ingredientList = (List<RecipeIngredient>) request.getAttribute("ingredientList");
    List<RecipeStep> stepList = (List<RecipeStep>) request.getAttribute("stepList");
    List<RecipeReview> reviewList = (List<RecipeReview>) request.getAttribute("reviewList");

    String imageUrl;
    if (recipe.getR_image() == null || recipe.getR_image().isEmpty()) {
        imageUrl = request.getContextPath() + "/resources/images/default.png";
    } else {
        imageUrl = request.getContextPath() + "/recipeimage/" + recipe.getR_image();
    }

    // 평균 별점 계산
    double avgRating = 0;
    if (reviewList != null && !reviewList.isEmpty()) {
        int sum = 0;
        for (RecipeReview r : reviewList) {
            sum += r.getRr_rating();
        }
        avgRating = (double) sum / reviewList.size();
    }
%>

<div class="main-container">

	<div class="detail-wrapper">

		<!-- 대표 이미지 -->
		<div class="image-box">
			<img src="<%= imageUrl %>" class="recipe-img"
				onclick="openModal(this)"
				onerror="this.style.display='none'">
			<div class="hits">조회수 <%= recipe.getR_hit() %></div>
		</div>

		<div class="title-row">
			<h1 class="recipe-title"><%= recipe.getR_title() %></h1>
			<div class="star-display" id="avgRating">
				⭐ <%= String.format("%.1f", avgRating) %>
			</div>
		</div>

		<p class="recipe-desc"><%= recipe.getR_content() %></p>

		<div class="info-box">
			<div>👨‍🍳 <%= recipe.getR_servings() %>인분</div>
			<div>⏱ <%= recipe.getR_cooking_time() %>분</div>
			<div>🔥 <%= recipe.getR_difficulty() %></div>
			<button class="save-btn" onclick="toggleSave()">저장</button>
			<button class="share-btn" onclick="copyUrl()">공유</button>
		</div>

		<!-- 재료 -->
		<div class="ingredient-section">
			<h2 class="section-title">재료</h2>
			<div class="ingredient-box">
				<%
				if (ingredientList != null) {
					for (RecipeIngredient ingredient : ingredientList) {
				%>
				<div class="ingredient-item">
					<%= ingredient.getRi_name() %>
					<%= ingredient.getRi_quantity() %>
					<%= ingredient.getRi_unit() %>
					<% if (ingredient.getRi_note() != null && !ingredient.getRi_note().isEmpty()) { %>
						(<%= ingredient.getRi_note() %>)
					<% } %>
				</div>
				<%
					}
				}
				%>
			</div>
		</div>

		<!-- 조리순서 -->
		<div class="step-section">
			<h2 class="section-title">조리순서</h2>
			<div class="step-box">
				<%
				if (stepList != null) {
					for (RecipeStep step : stepList) {
						String stepImageUrl = null;
						if (step.getRs_image() != null && !step.getRs_image().isEmpty()) {
							stepImageUrl = request.getContextPath() + "/recipeimage/" + step.getRs_image();
						}
				%>
				<div class="step-item">
					<div class="step-num">STEP <%= step.getRs_order() %></div>
					<div class="step-content">
						<div class="step-text"><%= step.getRs_content() %></div>
						<% if (stepImageUrl != null) { %>
						<div class="step-images">
							<img src="<%= stepImageUrl %>" class="step-img"
								onclick="openModal(this)"
								onerror="this.style.display='none'">
						</div>
						<% } %>
					</div>
				</div>
				<%
					}
				}
				%>
			</div>
		</div>

		<!-- 작성자 -->
		<div class="author-section">
			<h2 class="section-title">작성자</h2>
			<div class="author-box">
				<img src="https://i.pravatar.cc/100" class="author-img"
					onerror="this.style.display='none'">
				<div class="author-info">
					<div class="author-name"><%= recipe.getM_nickname() %></div>
				</div>
			</div>
			<div class="recipe-date-box">
				<div class="recipe-date">등록일 : <%= recipe.getR_datetime() %></div>
			</div>
		</div>

		<!-- 후기 -->
		<div class="review-section">

			<div class="review-top">
				<div class="review-title-wrap">
					<h2 class="section-title">후기</h2>
					<div id="reviewCount">(<%= reviewList != null ? reviewList.size() : 0 %>)</div>
				</div>
				<div class="review-sort">
					<button onclick="sortReviews('latest')">최신순</button>
					<button onclick="sortReviews('rating')">별점순</button>
				</div>
			</div>

			<div class="review-list" id="reviewList">
				<%
				if (reviewList != null) {
					for (RecipeReview review : reviewList) {
						String reviewImageUrl = null;
						if (review.getRr_image() != null && !review.getRr_image().isEmpty()) {
							reviewImageUrl = request.getContextPath() + "/recipeimage/" + review.getRr_image();
						}
				%>
				<div class="review-item"
					data-date="<%= review.getRr_datetime() %>"
					data-rating="<%= review.getRr_rating() %>">
					<div class="review-header">
						<span class="review-user"><%= review.getM_nickname() %></span>
						<div class="review-right">
							<span class="review-rating">
								<% for(int i=0; i<review.getRr_rating(); i++) { %>★<% } %>
								<% for(int i=review.getRr_rating(); i<5; i++) { %>☆<% } %>
							</span>
							<span class="review-date"><%= review.getRr_datetime() %></span>
						</div>
					</div>
					<div class="review-content"><%= review.getRr_content() %></div>
					<% if (reviewImageUrl != null) { %>
					<img src="<%= reviewImageUrl %>" class="review-image">
					<% } %>
				</div>
				<%
					}
				}
				%>
			</div>

			<!-- 후기 작성 폼 -->
			<form action="${pageContext.request.contextPath}/recipe/review"
				method="post" enctype="multipart/form-data">
				<input type="hidden" name="r_no" value="<%= recipe.getR_no() %>">

				<div class="review-form">
					<div class="review-input-top">
						<div class="review-left-tools">
							<div class="review-upload">
								<label for="reviewImage" class="upload-btn">📷 사진추가</label>
								<input type="file" id="reviewImage" name="rr_image" accept="image/*">
							</div>
							<div class="review-star-input">
								<input type="hidden" name="rr_rating" id="rr_rating" value="0">
								<span onclick="setReviewRating(1)">★</span>
								<span onclick="setReviewRating(2)">★</span>
								<span onclick="setReviewRating(3)">★</span>
								<span onclick="setReviewRating(4)">★</span>
								<span onclick="setReviewRating(5)">★</span>
							</div>
						</div>
						<button type="button" class="report-btn" onclick="reportRecipe()">🚨 신고</button>
					</div>
					<textarea name="rr_content" id="reviewText" placeholder="후기를 작성해주세요"></textarea>
					<button type="submit" class="review-btn">등록</button>
				</div>
			</form>

		</div>

	</div>

</div>

<!-- 이미지 팝업 -->
<div id="imgModal" class="modal">
	<span class="close-btn" onclick="closeModal()">×</span>
	<img id="modalImg" class="modal-content">
</div>

<!-- URL 복사 팝업 -->
<div id="copyPopup" class="copy-popup">URL이 복사되었습니다 🙂</div>

<!-- 저장 팝업 -->
<div id="savePopup" class="copy-popup">저장되었습니다</div>

<script>
function openModal(img) {
    const modal = document.getElementById("imgModal");
    const modalImg = document.getElementById("modalImg");
    modal.style.display = "flex";
    modalImg.src = img.src;
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

let saved = false;
function toggleSave() {
    const btn = document.querySelector(".save-btn");
    const popup = document.getElementById("savePopup");
    saved = !saved;
    btn.innerHTML = saved ? "저장됨" : "저장";
    popup.innerText = saved ? "저장되었습니다" : "저장이 취소되었습니다";
    popup.classList.add("show");
    setTimeout(() => popup.classList.remove("show"), 2000);
}

let selectedRating = 0;
function setReviewRating(num) {
    selectedRating = num;
    document.getElementById("rr_rating").value = num;
    const stars = document.querySelectorAll(".review-star-input span");
    stars.forEach((star, index) => {
        if (index < num) star.classList.add("active");
        else star.classList.remove("active");
    });
}

function sortReviews(type) {
    const list = document.getElementById("reviewList");
    const items = Array.from(list.children);
    items.sort((a, b) => {
        if (type === "latest") {
            return new Date(b.dataset.date) - new Date(a.dataset.date);
        } else {
            return parseInt(b.dataset.rating) - parseInt(a.dataset.rating);
        }
    });
    items.forEach(item => list.appendChild(item));
}

function reportRecipe() {
    alert("신고가 접수되었습니다.");
}
</script>

</body>
</html>