<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A - ReCook</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/qna.css">

</head>
<body>

<div class="main-container">

    <div class="qna-wrapper">

        <div class="qna-header">
            <h1>자주 묻는 질문</h1>
            <p>자주 묻는 질문을 빠르게 확인하세요</p>
        </div>

        <!-- QnA 리스트 -->
        <div class="qna-list">

            <div class="qna-card">
                <div class="qna-question">
                    <span class="q-badge">Q</span>
                    회원가입은 어떻게 하나요?
                    <span class="arrow">▼</span>
                </div>
                <div class="qna-answer">
                    회원가입 페이지에서 정보를 입력하면 간단하게 가입할 수 있습니다.
                </div>
            </div>

            <div class="qna-card">
                <div class="qna-question">
                    <span class="q-badge">Q</span>
                    비밀번호를 잊어버렸어요
                    <span class="arrow">▼</span>
                </div>
                <div class="qna-answer">
                    비밀번호 찾기 기능을 통해 재설정할 수 있습니다.
                </div>
            </div>

            <div class="qna-card">
                <div class="qna-question">
                    <span class="q-badge">Q</span>
                    레시피는 무료인가요?
                    <span class="arrow">▼</span>
                </div>
                <div class="qna-answer">
                    네, 모든 레시피는 무료로 이용 가능합니다.
                </div>
            </div>

        </div>

    </div>

</div>

<script>
    const cards = document.querySelectorAll(".qna-card");

    cards.forEach(card => {
        card.addEventListener("click", () => {
            card.classList.toggle("active");
        });
    });
</script>

</body>
</html>
