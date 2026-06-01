<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 작성 - ReCook</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/recipe_write.css">

</head>
<body>

	<div class="main-container">
		<div class="write-wrapper">

			<h1>레시피 작성</h1>

			<form action="${pageContext.request.contextPath}/recipe/write"
				method="post" enctype="multipart/form-data">

				<!-- 작성자 (hidden) -->
				<input type="hidden" name="m_no"
					value="<%=session.getAttribute("m_no")%>">

				<!-- 제목 -->
				<div class="form-group">
					<label>제목</label> <input type="text" name="r_title"
						placeholder="레시피 제목을 입력하세요" required>
				</div>

				<!-- 이미지 -->
				<div class="form-group">
					<label>대표 이미지</label> <input type="file" name="r_imageFile"
						accept="image/*">
				</div>

				<!-- 본문 -->
				<div class="form-group">
					<label>본문</label>
					<textarea name="r_content" placeholder="레시피 설명을 입력하세요" required></textarea>
				</div>

				<!-- 카테고리 -->
				<div class="form-row">
					<div class="form-group">
						<label>종류</label> <select name="r_type" required>
							<option value="">-- 선택 --</option>
							<option value="밥">밥</option>
							<option value="국">국</option>
							<option value="반찬">반찬</option>
							<option value="국수">국수</option>
							<option value="찌개">찌개</option>
							<option value="디저트">디저트</option>
						</select>
					</div>

					<div class="form-group">
						<label>상황</label> <select name="r_situation" required>
							<option value="">-- 선택 --</option>
							<option value="일상">일상</option>
							<option value="손님 접대">손님 접대</option>
							<option value="파티">파티</option>
							<option value="도시락">도시락</option>
						</select>
					</div>

					<div class="form-group">
						<label>방법</label> <select name="r_method" required>
							<option value="">-- 선택 --</option>
							<option value="볶음">볶음</option>
							<option value="끓임">끓임</option>
							<option value="조림">조림</option>
							<option value="구이">구이</option>
							<option value="찜">찜</option>
							<option value="무침">무침</option>
						</select>
					</div>
				</div>

				<!-- 정보 -->
				<div class="form-row">
					<div class="form-group">
						<label>인원 수</label> <input type="number" name="r_servings"
							placeholder="2" required>
					</div>

					<div class="form-group">
						<label>요리시간 (분)</label> <input type="number" name="r_cooking_time"
							placeholder="15" required>
					</div>

					<div class="form-group">
						<label>난이도</label> <select name="r_difficulty" required>
							<option value="">-- 선택 --</option>
							<option value="쉬움">쉬움</option>
							<option value="중간">중간</option>
							<option value="어려움">어려움</option>
						</select>
					</div>
				</div>

				<!-- 재료 -->
				<div class="form-group">
					<label>재료</label>
					<div id="ingredients">
						<div class="ingredient-row">
							<input type="text" name="ri_name" placeholder="재료명"> <input
								type="number" name="ri_quantity" placeholder="수량" step="0.1">
							<select name="ri_unit">
								<option value="g">g</option>
								<option value="ml">ml</option>
								<option value="개">개</option>
								<option value="줌">줌</option>
								<option value="스푼">스푼</option>
								<option value="컵">컵</option>
							</select> <input type="text" name="ri_note" placeholder="비고">
							<button type="button" class="btn-remove"
								onclick="removeIngredient(this)">삭제</button>
						</div>
					</div>
					<button type="button" class="btn-add" onclick="addIngredient()">+
						재료 추가</button>
				</div>

				<!-- 조리 순서 -->
				<div class="form-group">
					<label>조리 순서</label>
					<div id="steps">
						<div class="step-row">
							<div class="step-order">STEP 1</div>
							<textarea name="rs_content" placeholder="조리 방법을 입력하세요" required></textarea>
							<input type="file" name="rs_imageFile" accept="image/*">
							<button type="button" class="btn-remove"
								onclick="removeStep(this)">삭제</button>
						</div>
					</div>
					<button type="button" class="btn-add" onclick="addStep()">+
						단계 추가</button>
				</div>

				<!-- 버튼 -->
				<div class="button-group">
					<button type="submit" class="btn-submit">등록</button>
					<a href="${pageContext.request.contextPath}/" class="btn-cancel">취소</a>
				</div>

			</form>

		</div>
	</div>

	<script>
		function addIngredient() {
			const div = document.createElement('div');
			div.className = 'ingredient-row';
			div.innerHTML = `
				<input type="text" name="ri_name" placeholder="재료명">
				<input type="number" name="ri_quantity" placeholder="수량" step="0.1">
				<select name="ri_unit">
					<option value="g">g</option>
					<option value="ml">ml</option>
					<option value="개">개</option>
					<option value="줌">줌</option>
					<option value="스푼">스푼</option>
					<option value="컵">컵</option>
				</select>
				<input type="text" name="ri_note" placeholder="비고">
				<button type="button" class="btn-remove" onclick="removeIngredient(this)">삭제</button>
			`;
			document.getElementById('ingredients').appendChild(div);
		}

		function removeIngredient(btn) {
			btn.parentElement.remove();
		}

		function addStep() {
			const stepsDiv = document.getElementById('steps');
			const stepCount = stepsDiv.children.length + 1;
			const div = document.createElement('div');
			div.className = 'step-row';
			div.innerHTML = `
				<div class="step-order">STEP \${stepCount}</div>
				<textarea name="rs_content" placeholder="조리 방법을 입력하세요" required></textarea>
				<input type="file" name="rs_imageFile" accept="image/*">
				<button type="button" class="btn-remove" onclick="removeStep(this)">삭제</button>
			`;
			stepsDiv.appendChild(div);
		}

		function removeStep(btn) {
			btn.parentElement.remove();
		}
	</script>

</body>
</html>