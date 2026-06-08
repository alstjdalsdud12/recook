<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recook | Your Premium Kitchen</title>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/home.css">
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <main class="container">
        <section class="hero-section">
            <h1>냉장고 속 잠든 재료,<br><span>프리미엄 레시피</span>로 깨우다</h1>
            <p class="sub-text">무엇이든 입력해보세요. 최고의 미식 경험을 제안합니다.</p>
        </section>

        <div class="search-container">
            <input type="text" id="ingredientInput" placeholder="아보카도, 연어, 스테이크..." autocomplete="off">
            <button type="button" class="add-btn" id="addBtn">
                <i class="fa-solid fa-plus"></i>
            </button>
        </div>

        <div class="recommend-chips">
            인기: 
            <span class="chip" onclick="quickAdd('계란')">계란</span>
            <span class="chip" onclick="quickAdd('닭가슴살')">닭가슴살</span>
            <span class="chip" onclick="quickAdd('와인')">와인</span>
        </div>

        <div class="tag-list" id="tagList"></div>

        <button type="button" class="submit-btn" onclick="searchRecipe()">
            레시피 발견하기 <i class="fa-solid fa-arrow-right"></i>
        </button>
    </main>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const ingredientInput = document.getElementById('ingredientInput');
            const addBtn = document.getElementById('addBtn');
            const tagList = document.getElementById('tagList');

            window.addTag = function(text) {
                const value = (typeof text === 'string') ? text : ingredientInput.value.trim(); 
                
                if (value !== "") {
                    const currentTags = Array.from(tagList.querySelectorAll('.tag-text')).map(t => t.textContent.trim());
                    if (currentTags.includes(value)) {
                        ingredientInput.value = '';
                        return;
                    }

                    const newTag = document.createElement('div');
                    newTag.className = 'ingredient-tag';
                    newTag.innerHTML = `
                        <span class="tag-text">\${value}</span>
                        <i class="fa-solid fa-xmark" onclick="removeTag(this)"></i>
                    `;
                    
                    tagList.appendChild(newTag);
                    ingredientInput.value = '';
                    ingredientInput.focus();
                }
            };

            window.removeTag = function(element) {
                const tag = element.parentElement;
                tag.style.transform = 'scale(0) translateY(-20px)';
                tag.style.opacity = '0';
                tag.style.marginRight = '-' + tag.offsetWidth + 'px';
                setTimeout(() => tag.remove(), 300);
            };

            window.quickAdd = function(item) {
                window.addTag(item);
            };

            addBtn.addEventListener('click', window.addTag);

            ingredientInput.addEventListener('keypress', function(e) {
                if (e.key === 'Enter') {
                    e.preventDefault();
                    window.addTag();
                }
            });
        });

        function searchRecipe() {
            const tags = Array.from(document.querySelectorAll('.tag-text')).map(t => t.textContent.trim());
            
            if (tags.length === 0) {
                alert('검색을 위해 재료를 하나 이상 추가해주세요.');
                return;
            }

            const submitBtn = document.querySelector('.submit-btn');
            submitBtn.disabled = true;
            submitBtn.innerHTML = `미식 레시피 탐색 중... <i class="fa-solid fa-spinner fa-spin"></i>`;

            // 한글 깨짐 방지 파라미터 인코딩
            const ingredientsParam = encodeURIComponent(tags.join(','));
            const contextPath = '${pageContext.request.contextPath}';
            
            // [최종 수정] 컨트롤러 매핑 주소(/recipe/search)로 전송합니다.
            location.href = contextPath + "/recipe/search?ingredients=" + ingredientsParam;
        }
        
     // 뒤로가기 시 버튼 초기화
        window.addEventListener('pageshow', function(e) {
            const submitBtn = document.querySelector('.submit-btn');
            submitBtn.disabled = false;
            submitBtn.innerHTML = '레시피 발견하기 <i class="fa-solid fa-arrow-right"></i>';
        });
    </script>
</body>
</html>