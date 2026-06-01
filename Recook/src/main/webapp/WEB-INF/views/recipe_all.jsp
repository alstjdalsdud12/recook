<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.springmvc.domain.Recipe"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모든 레시피 - ReCook</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/recipe_all.css">

</head>
<body>

	<%@ include file="/WEB-INF/views/common/header.jsp"%>

	<div class="main-container">

		<div class="recipe-all-wrapper">

			<div class="recipe-all-header">
				<h1>모든 레시피</h1>
				<p>등록된 레시피를 확인해보세요</p>
			</div>

			<div class="sort-container">
				<button class="sort-btn" onclick="sortRecipes('hits')">조회순</button>
				<button class="sort-btn" onclick="sortRecipes('latest')">최신순</button>
			</div>

			<div class="recipe-grid" id="recipeGrid">

				<%
				List<Recipe> recipeList = (List<Recipe>) request.getAttribute("recipeList");
				if (recipeList != null && !recipeList.isEmpty()) {
					for (Recipe recipe : recipeList) {
						String imagePath = recipe.getR_image();
						String imageUrl;
						if (imagePath == null || imagePath.isEmpty()) {
					imageUrl = request.getContextPath() + "/resources/images/default.png";
						} else {
					imageUrl = request.getContextPath() + "/recipeimage/" + imagePath;
						}
				%>

				<a
					href="${pageContext.request.contextPath}/recipe_detail?r_no=<%= recipe.getR_no() %>"
					class="recipe-card" data-date="<%= recipe.getR_datetime() %>"
					data-hits="<%= recipe.getR_hit() %>">
					<div class="thumb"
						style="background-image: url('<%=imageUrl%>'); background-size: cover; background-position: center;"></div>
					<div class="recipe-info">
						<div class="title"><%=recipe.getR_title()%></div>
						<div class="author"><%=recipe.getM_nickname()%></div>
						<div class="rating">
							⭐
							<%=String.format("%.1f", recipe.getAvg_rating())%>
							(<%=recipe.getReview_count()%>)
						</div>
						<div class="hits">
							조회
							<%=recipe.getR_hit()%></div>
					</div>
				</a>

				<%
				}
				}
				%>

			</div>

		</div>

	</div>

	<div class="pagination" id="pagination"></div>

	<script>
		const itemsPerPage = 10;
		let currentPage = 1;

		const grid = document.getElementById("recipeGrid");
		let items = Array.from(grid.children);

		function showPage(page) {
		    currentPage = page;

		    const start = (page - 1) * itemsPerPage;
		    const end = start + itemsPerPage;

		    items.forEach((item, index) => {
		        if (index >= start && index < end) {
		            item.style.display = "block";
		        } else {
		            item.style.display = "none";
		        }
		    });
		}

		function changePage(page) {
		    showPage(page);
		}

		function updatePagination() {
		    const totalPages = Math.ceil(items.length / itemsPerPage);
		    const pagination = document.getElementById("pagination");
		    pagination.innerHTML = "";
		    for (let i = 1; i <= totalPages; i++) {
		        const btn = document.createElement("button");
		        btn.textContent = i;
		        btn.onclick = () => changePage(i);
		        pagination.appendChild(btn);
		    }
		}

		function sortRecipes(type) {
		    items.sort((a, b) => {
		        if (type === "hits") {
		            return parseInt(b.dataset.hits) - parseInt(a.dataset.hits);
		        } else {
		            return new Date(b.dataset.date) - new Date(a.dataset.date);
		        }
		    });

		    items.forEach(item => grid.appendChild(item));
		    updatePagination();
		    showPage(1);
		}

		sortRecipes('latest');
	</script>

</body>
</html>