<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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

<div class="main-container">

	<div class="detail-wrapper">

		<!-- STEP1 -->
		<div class="image-box">

			<img
				src="https://images.unsplash.com/photo-1604908176997-125f25cc6f3d"
				class="recipe-img"
				onclick="openModal(this)"
				onerror="this.style.display='none'">

			<div class="hits" id="viewCount">
				조회수 0
			</div>

		</div>

		<div class="title-row">

			<h1 class="recipe-title">김치볶음밥</h1>

			<div class="star-display" id="avgRating">
				⭐ 5.0
			</div>

		</div>

		<p class="recipe-desc">
			매콤하고 고소한 김치볶음밥은 누구나 쉽게 만들 수 있는 대표적인 한식 요리입니다.
		</p>

		<div class="info-box">

			<div>👨‍🍳 2인분</div>

			<div>⏱ 15분</div>

			<div>🔥 쉬움</div>

			<button class="save-btn" onclick="toggleSave()">
				저장
			</button>

			<button class="share-btn" onclick="copyUrl()">
				공유
			</button>

		</div>

		<!-- STEP2 -->
		<div class="ingredient-section">

			<h2 class="section-title">재료</h2>

			<div class="ingredient-box">

				<div class="ingredient-item">김치 1컵</div>
				<div class="ingredient-item">밥 1공기</div>
				<div class="ingredient-item">계란 1개</div>
				<div class="ingredient-item">대파 약간</div>
				<div class="ingredient-item">고추장 1스푼</div>

			</div>

		</div>

		<!-- STEP3 -->
		<div class="step-section">

			<h2 class="section-title">조리순서</h2>

			<div class="step-box">

				<div class="step-item">

					<div class="step-num">STEP 1</div>

					<div class="step-content">

						<div class="step-text">
							팬에 식용유를 두르고 중불로 예열합니다.
						</div>

						<div class="step-images">

							<img
								src="https://images.unsplash.com/photo-1504674900247-0877df9cc836"
								class="step-img"
								onclick="openModal(this)"
								onerror="this.style.display='none'">

						</div>

					</div>

				</div>

				<div class="step-item">

					<div class="step-num">STEP 2</div>

					<div class="step-content">

						<div class="step-text">
							김치를 넣고 볶아줍니다.
						</div>

					</div>

				</div>

				<div class="step-item">

					<div class="step-num">STEP 3</div>

					<div class="step-content">

						<div class="step-text">
							밥을 넣고 고루 섞어 볶습니다.
						</div>

						<div class="step-images">

							<img
								src="https://images.unsplash.com/photo-1512058564366-18510be2db19"
								class="step-img"
								onclick="openModal(this)"
								onerror="this.style.display='none'">

						</div>

					</div>

				</div>

			</div>

		</div>

		<!-- STEP4 작성자 -->
<div class="author-section">

    <h2 class="section-title">작성자</h2>

    <div class="author-box">

        <img
            src="https://i.pravatar.cc/100"
            class="author-img"
            onerror="this.style.display='none'">

        <div class="author-info">

            <div class="author-name">
                요리왕 민성
            </div>

            <div class="author-desc">
                간단하고 맛있는 집밥 레시피를 공유합니다 😊
            </div>

        </div>

    </div>

    <!-- 등록일 수정일 -->
    <div class="recipe-date-box">

        <div class="recipe-date">
            등록일 : 2026-05-08
        </div>

        <div class="recipe-date">
            수정일 : 2026-05-10
        </div>

    </div>

</div>




<div class="ai-summary">

    <h3>

        🤖 AI 댓글 요약

    </h3>

    <p>

        ${summary}

    </p>

</div>


		<!-- STEP5 후기 -->
		<div class="review-section">

			<div class="review-top">

    <div class="review-title-wrap">

        <h2 class="section-title">후기</h2>

        <div id="reviewCount">(1)</div>

    </div>

    <div class="review-sort">

        <button onclick="sortReviews('latest')">
            최신순
        </button>

        <button onclick="sortReviews('rating')">
            별점순
        </button>

    </div>

</div>

			<div class="review-list" id="reviewList"></div>

			<!-- 후기 작성 -->
<div class="review-form">

   <!-- 후기 상단 입력 -->
<div class="review-input-top">

    <div class="review-left-tools">

        <!-- 사진 추가 -->
        <div class="review-upload">

            <label for="reviewImage" class="upload-btn">
                📷 사진추가
            </label>

            <input
                type="file"
                id="reviewImage"
                accept="image/*">

        </div>

        <!-- 별점 -->
        <div class="review-star-input">

            <span onclick="setReviewRating(1)">★</span>
            <span onclick="setReviewRating(2)">★</span>
            <span onclick="setReviewRating(3)">★</span>
            <span onclick="setReviewRating(4)">★</span>
            <span onclick="setReviewRating(5)">★</span>

        </div>

    </div>

    <!-- 신고 버튼 -->
    <button
        type="button"
        class="report-btn"
        onclick="reportRecipe()">

        🚨 신고

    </button>

</div>

    <textarea
        id="reviewText"
        placeholder="후기를 작성해주세요"></textarea>

    <button
        type="button"
        class="review-btn"
        onclick="submitReview()">

        등록

    </button>

</div>

		</div>

	</div>

</div>

<!-- 이미지 팝업 -->
<div id="imgModal" class="modal">

	<span class="close-btn" onclick="closeModal()">×</span>

	<img id="modalImg" class="modal-content">

</div>

<!-- URL 복사 팝업 -->
<div id="copyPopup" class="copy-popup">
	URL이 복사되었습니다 🙂
</div>

<!-- 저장 팝업 -->
<div id="savePopup" class="copy-popup">
	저장되었습니다
</div>

<script>
function openModal(img){

    const modal = document.getElementById("imgModal");
    const modalImg = document.getElementById("modalImg");

    modal.style.display = "flex";
    modalImg.src = img.src;
}

function closeModal(){

    document.getElementById("imgModal").style.display = "none";
}

document.getElementById("imgModal")
.addEventListener("click", function(e){

    if(e.target === this){

        closeModal();
    }
});

// 조회수
let viewCount = localStorage.getItem("recipeViewCount");

if(viewCount === null){

    viewCount = 0;
}

viewCount++;

localStorage.setItem("recipeViewCount", viewCount);

document.getElementById("viewCount").innerText =
    "조회수 " + viewCount;

// 공유
function copyUrl(){

    navigator.clipboard.writeText(window.location.href);

    const popup =
        document.getElementById("copyPopup");

    popup.classList.add("show");

    setTimeout(function(){

        popup.classList.remove("show");

    }, 2000);
}

// 저장
let saved = false;

function toggleSave(){

    const btn =
        document.querySelector(".save-btn");

    const popup =
        document.getElementById("savePopup");

    saved = !saved;

    if(saved){

        btn.innerHTML = "저장됨";

        popup.innerText = "저장되었습니다";

    }else{

        btn.innerHTML = "저장";

        popup.innerText = "저장이 취소되었습니다";
    }

    popup.classList.add("show");

    setTimeout(function(){

        popup.classList.remove("show");

    }, 2000);
}

// 후기 별점
let selectedRating = 0;

// 후기 데이터
let reviews = [

    {
        user: "홍길동",
        date: "2026-05-08",
        content: "정말 맛있어요!",
        rating: 5
    }

];

// 별점 선택
function setReviewRating(num){

    selectedRating = num;

    const stars =
        document.querySelectorAll(".review-star-input span");

    stars.forEach((star, index) => {

        if(index < num){

            star.classList.add("active");

        }else{

            star.classList.remove("active");
        }
    });
}

// 후기 등록
function submitReview(){

    const text =
        document.getElementById("reviewText").value;

    if(selectedRating === 0){

        alert("별점을 선택해주세요");
        return;
    }

    if(text.trim() === ""){

        alert("후기를 입력해주세요");
        return;
    }

    const fileInput =
        document.getElementById("reviewImage");

    let imageUrl = "";

    if(fileInput.files[0]){

        imageUrl =
            URL.createObjectURL(fileInput.files[0]);
    }

    const review = {

        user: "사용자",

        date: new Date()
            .toISOString()
            .split('T')[0],

        content: text,

        rating: selectedRating,

        image: imageUrl
    };

    reviews.push(review);

    renderReviews();

    updateAverage();

    document.getElementById("reviewText").value = "";

    document.getElementById("reviewImage").value = "";

    selectedRating = 0;

    document
        .querySelectorAll(".review-star-input span")
        .forEach(s => s.classList.remove("active"));
}

// 후기 출력
function renderReviews(){

    const list =
        document.getElementById("reviewList");

    list.innerHTML = "";

    reviews.forEach(function(r){

        const stars =
            "★".repeat(r.rating) +
            "☆".repeat(5 - r.rating);

        list.innerHTML +=
        '<div class="review-item">' +

            '<div class="review-header">' +

                '<span class="review-user">' +
                    r.user +
                '</span>' +

                '<div class="review-right">' +

                    '<span class="review-rating">' +
                        stars +
                    '</span>' +

                    '<span class="review-date">' +
                        r.date +
                    '</span>' +

                '</div>' +

            '</div>' +

            '<div class="review-content">' +
            r.content +
        '</div>' +

        (r.image
        ? '<img src="' + r.image + '" class="review-image">'
        : '') +

        '</div>';
    });

    document.getElementById("reviewCount").innerText =
        "(" + reviews.length + ")";
}

// 평균 별점
function updateAverage(){

    if(reviews.length === 0){

        document.getElementById("avgRating").innerText =
            "⭐ 0.0";

        return;
    }

    let sum = 0;

    reviews.forEach(function(r){

        sum += r.rating;

    });

    const avg =
        (sum / reviews.length).toFixed(1);

    document.getElementById("avgRating").innerText =
        "⭐ " + avg;
}

//후기 정렬
function sortReviews(type){

    if(type === "latest"){

        reviews.sort(function(a, b){

            return new Date(b.date) - new Date(a.date);

        });

    }else if(type === "rating"){

        reviews.sort(function(a, b){

            return b.rating - a.rating;

        });
    }

    renderReviews();
}

//레시피 신고
function reportRecipe(){

    alert("신고가 접수되었습니다.");
}

// 처음 실행
renderReviews();
updateAverage();

</script>

</body>
</html>