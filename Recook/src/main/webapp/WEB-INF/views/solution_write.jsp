<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Share Your Wisdom | ReCook</title>
    
    <link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;1,400&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/solution_write.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css">
</head>
<body>
    <%@ include file="/WEB-INF/views/common/header.jsp"%>

    <main class="write-container">
        <div class="write-wrapper">
            
            <header class="write-header">
                <span class="sub-label">CONTRIBUTE</span>
                <h1>Share Your Wisdom.</h1>
                <p>당신만의 주방 노하우와 식재료 관리 지혜를 아카이브에 기록해 주세요.</p>
            </header>

            <form action="${pageContext.request.contextPath}/solution/insert" method="post" enctype="multipart/form-data" class="premium-form">
                
                <div class="form-group">
                    <label>CATEGORY</label>
                    <div class="category-selector">
                        <input type="radio" name="category" value="kitchen" id="cat-kitchen" checked>
                        <label for="cat-kitchen">주방 솔루션</label>
                        
                        <input type="radio" name="category" value="ingredients" id="cat-ingredients">
                        <label for="cat-ingredients">재료 솔루션</label>
                    </div>
                </div>

                <div class="form-group">
                    <label for="title">TITLE</label>
                    <input type="text" id="title" name="title" placeholder="제목을 입력하세요 (예: 스테인리스 팬 연마법)" required>
                </div>

                <div class="form-group">
                    <label for="summary">SUMMARY</label>
                    <input type="text" id="summary" name="summary" placeholder="목록에 표시될 짧은 설명을 입력하세요" required>
                </div>

                <div class="form-group">
                    <label for="content">CONTENT</label>
                    <textarea id="content" name="content" rows="12" placeholder="상세한 방법과 노하우를 자유롭게 기록해 주세요." required></textarea>
                </div>

                <div class="form-group">
                    <label>VISUAL ASSET</label>
                    <div class="file-upload-wrapper">
                        <input type="file" id="image" name="image" accept="image/*" onchange="previewImage(this)">
                        <div class="custom-file-box">
                            <i class="fa-solid fa-cloud-arrow-up"></i>
                            <p id="file-name">이미지를 클릭하여 업로드하거나 드래그하세요</p>
                            <div id="image-preview" class="image-preview"></div>
                        </div>
                    </div>
                </div>

                <div class="form-actions">
                    <a href="javascript:history.back();" class="btn-cancel">CANCEL</a>
                    <button type="submit" class="btn-submit">ARCHIVE NOW</button>
                </div>

            </form>

        </div>
    </main>

    <%@ include file="/WEB-INF/views/common/footer.jsp" %>

    <script>
        // 파일 업로드 시 파일명 노출 및 미리보기
        function previewImage(input) {
            const fileName = input.files[0].name;
            document.getElementById('file-name').textContent = fileName;
            
            const preview = document.getElementById('image-preview');
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.style.backgroundImage = 'url(' + e.target.result + ')';
                    preview.style.display = 'block';
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</body>
</html>