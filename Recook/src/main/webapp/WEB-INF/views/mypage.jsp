<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>마이페이지</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/resources/css/mypage.css">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

</head>

<body>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<div class="mypage-container">

    <!-- 프로필 카드 -->

    <div class="profile-card">

        <div class="profile-left">

            <!-- 프로필 이미지 -->

            <div class="profile-image-box">

                <img
                    id="profilePreview"
                    class="profile-image"
                    src="${pageContext.request.contextPath}/resources/images/default-profile.png"
                    alt="프로필">

                <label
                    for="profileInput"
                    class="camera-btn">

                    <i class="fa-solid fa-camera"></i>

                </label>

                <input
                    type="file"
                    id="profileInput"
                    accept="image/*"
                    onchange="previewProfile(event)">

            </div>

            <!-- 프로필 정보 -->

            <div class="profile-info">

                <div class="name-row">

                    <h2>민성님</h2>

                    <!-- 등급 -->

                    <div class="grade-area">

                        <span class="grade-badge">

                            🍽 셰프

                        </span>

                        <button
                            type="button"
                            class="grade-info-btn"
                            onclick="toggleGradePopup()">

                            ⓘ

                        </button>

                        <!-- 팝업 -->

                        <div
                            id="gradePopup"
                            class="grade-popup">

                            <div>🌱 새싹 요리사 (0~2)</div>
                            <div>🍜 자취생 (3~9)</div>
                            <div>🥘 주부 (10~19)</div>
                            <div>👨‍🍳 주방장 (20~39)</div>
                            <div>🍽 셰프 (40~69)</div>
                            <div>⚫⚪ 흑백요리사 (70+)</div>

                        </div>

                    </div>

                </div>

                <p>

                    recook@naver.com

                </p>

                <!-- 상태메시지 -->

                <div class="status-box">

                    <div class="status-row">

                        <input
                            type="text"
                            id="statusInput"
                            class="status-input"
                            value="오늘도 맛있는 하루 🍳"
                            readonly>

                        <button
                            type="button"
                            class="status-edit-btn"
                            onclick="editStatus()">

                            수정

                        </button>

                    </div>

                </div>

            </div>

        </div>

        <!-- 회원정보 수정 -->

        <button
            class="edit-btn"
            onclick="location.href='${pageContext.request.contextPath}/edit_profile'">

            회원정보 수정

        </button>

    </div>

    <!-- 쿠폰 -->

    <!-- 쿠폰함 -->

<div
    class="coupon-menu"
    onclick="location.href='${pageContext.request.contextPath}/coupon'">

    <div>

        <div class="menu-icon">

            🎁

        </div>

        <div class="menu-title">

            쿠폰함

        </div>

        <div class="menu-desc">

            이벤트 보상 쿠폰 확인

        </div>

    </div>

    <div class="menu-count">

        4

    </div>

</div>

    <!-- 메뉴 -->

    <div class="menu-grid">

        <div
            class="menu-card"
            onclick="location.href='${pageContext.request.contextPath}/my_recipe'">

            <div class="menu-icon">📝</div>

            <div class="menu-title">

                내가 쓴 글

            </div>

            <div class="menu-count">

                12

            </div>

        </div>

        <div
            class="menu-card"
            onclick="location.href='${pageContext.request.contextPath}/my_favorite'">

            <div class="menu-icon">⭐</div>

            <div class="menu-title">

                즐겨찾기

            </div>

            <div class="menu-count">

                7

            </div>

        </div>

        <div
            class="menu-card"
            onclick="location.href='${pageContext.request.contextPath}/my_look'">

            <div class="menu-icon">🍳</div>

            <div class="menu-title">

                최근에 본 레시피

            </div>

            <div class="menu-count">

                23

            </div>

        </div>

    </div>

</div>

<script>

let editing = false;

function editStatus(){

    const input =
        document.getElementById(
        "statusInput");

    const btn =
        document.querySelector(
        ".status-edit-btn");

    if(!editing){

        input.removeAttribute(
        "readonly");

        input.focus();

        btn.innerText =
        "저장";

        editing = true;
    }

    else{

        input.setAttribute(
        "readonly",
        true);

        btn.innerText =
        "수정";

        editing = false;
    }
}

function previewProfile(event){

    const file =
        event.target.files[0];

    if(!file) return;

    const reader =
        new FileReader();

    reader.onload =
        function(e){

            document
            .getElementById(
            "profilePreview")
            .src =
            e.target.result;
        };

    reader.readAsDataURL(file);
}

function toggleGradePopup(){

    const popup =
        document.getElementById(
        "gradePopup");

    popup.classList.toggle(
        "show");
}

</script>

</body>
</html>