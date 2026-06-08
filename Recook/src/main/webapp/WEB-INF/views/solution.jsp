	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lifestyle Solution | ReCook</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,700;1,700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/solution.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css">
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <main class="premium-container">
        <div class="solution-wrapper">
           <header class="premium-header">
    <span class="reveal-text">Better Tools, Finer Ingredients</span>
    
    <h1 class="main-title">
        주방의 품격은 도구에서,<br>
        요리의 완성은 재료에서.
    </h1>
</header>

            <div class="premium-grid">
                <a href="${pageContext.request.contextPath}/solution/kitchen" class="premium-card kitchen">
     
                   <div class="image-wrapper">
                        <div class="bg-overlay"></div>
                        <div class="visual-thumb"></div>
                    </div>
                    
                    <div class="content-overlay">
                        <span class="cat-label">01 / KITCHEN</span>
                        <h2>주방 솔루션</h2>
                        <p>단순한 도구를 넘어 영감을 주는 주방 관리와 공간 미학을 위한 정리 시스템을 제안합니다.</p>
                        <div class="explore-btn">EXPLORE NOW</div>
                    </div>
                </a> 
                
                <a href="${pageContext.request.contextPath}/solution/ingredients" class="premium-card ingredients">
                    <div class="image-wrapper">
                        <div class="bg-overlay"></div>
                        <div class="visual-thumb"></div>
                    </div>
                    
                    <div class="content-overlay">
                        <span class="cat-label">02 / INGREDIENTS</span>
                        <h2>재료 솔루션</h2>
                        <p>재료 본연의 가치를 지키는 섬세한 보관 기술과 미식의 퀄리티를 높이는 활용법을 경험하세요.</p>
                        <div class="explore-btn">EXPLORE NOW</div>
                    </div>
                </a> 
            </div>
        </div>
    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>