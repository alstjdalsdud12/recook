<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recook - 당신의 냉장고를 부탁해</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/home.css">
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <main class="container">
        <h1>냉장고 속 잠든 재료,<br><span>맛있는 요리</span>로 깨우다</h1>

        <div class="search-box">
            <input type="text" id="ingredientInput" placeholder="가지고 있는 재료를 입력하세요 (예: 감자, 돼지고기)">
            <button class="add-btn" id="addBtn"><i class="fa-solid fa-plus"></i></button>
        </div>

        <div class="tag-list" id="tagList">
            </div>
        </div>

        <button class="submit-btn" onclick="searchRecipe()">레시피 검색하기</button>
    </main>

    <script>
        const ingredientInput = document.getElementById('ingredientInput');
        const addBtn = document.getElementById('addBtn');
        const tagList = document.getElementById('tagList');

        function addTag() {
            const value = ingredientInput.value.trim(); 
            
            if (value !== "") {
                const newTag = document.createElement('div');
                newTag.className = 'ingredient-tag';
                newTag.innerHTML = value + ' <i class="fa-solid fa-xmark" onclick="this.parentElement.remove()"></i>';
                
                tagList.appendChild(newTag);
                ingredientInput.value = '';
            }
        }

        addBtn.addEventListener('click', addTag);

        ingredientInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                addTag();
            }
        });

        function searchRecipe() {
            alert('레시피를 검색합니다! (기능 구현 필요)');
        }
    </script>
</body>
</html>