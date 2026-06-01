<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="sidebar">

    <h2 class="logo">ReCook __Admin__</h2>

    <ul class="menu">

        <li><a href="#">대시보드</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/user">회원 관리</a></li>
        <li><a href="#">레시피 관리</a></li>

        <!-- 🔥 고객센터 -->
        <li class="menu-item">

            <div class="menu-title" onclick="toggleMenu(this)">
                고객센터
                <span class="arrow">▼</span>
            </div>

            <ul class="submenu">
                <li><a href="${pageContext.request.contextPath}/admin/admin_notice">공지사항</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/inquiry">문의 관리</a></li>
            </ul>

        </li>

        <!-- 홈으로 돌아가기 -->
        <li><a href="${pageContext.request.contextPath}/" class="home-link">홈으로</a></li>

    </ul>

</div>

<script>
function toggleMenu(element) {
    const submenu = element.nextElementSibling;
    const arrow = element.querySelector(".arrow");

    if (submenu.style.display === "block") {
        submenu.style.display = "none";
        arrow.style.transform = "rotate(0deg)";
    } else {
        submenu.style.display = "block";
        arrow.style.transform = "rotate(180deg)";
    }
}
</script>