<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 이벤트 등록 - ReCook</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin.css">
</head>
<body>

	<div class="admin-container">

		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

		<div class="main">

			<div class="top-bar">
				<h1>이벤트 등록</h1>
			</div>

			<div class="recent">
				<form action="${pageContext.request.contextPath}/admin/event/write" method="post">

					<div class="form-group" style="margin-bottom:20px;">
						<label>제목</label>
						<input type="text" name="e_title" required
							style="width:100%; padding:10px; border:1px solid #ddd; border-radius:8px; margin-top:8px;">
					</div>

					<div class="form-group" style="margin-bottom:20px;">
						<label>설명</label>
						<textarea name="e_desc" rows="4" required
							style="width:100%; padding:10px; border:1px solid #ddd; border-radius:8px; margin-top:8px; resize:none;"></textarea>
					</div>

					<!-- 기간 - 달력 -->
					<div class="form-group" style="margin-bottom:20px;">
						<label>기간</label>
						<div style="display:flex; align-items:center; gap:10px; margin-top:8px;">
							<input type="date" id="startDate"
								style="padding:10px; border:1px solid #ddd; border-radius:8px;">
							<span>~</span>
							<input type="date" id="endDate"
								style="padding:10px; border:1px solid #ddd; border-radius:8px;">
							<input type="hidden" name="e_period" id="e_period">
						</div>
					</div>

					<div class="form-group" style="margin-bottom:20px;">
						<label>보상</label>
						<input type="text" name="e_reward" placeholder="예: 쿠폰 3,000원"
							style="width:100%; padding:10px; border:1px solid #ddd; border-radius:8px; margin-top:8px;">
					</div>

					<div class="form-group" style="margin-bottom:20px;">
						<label>참여방법</label>
						<input type="text" name="e_method" placeholder="예: 레시피 3개 이상 등록"
							style="width:100%; padding:10px; border:1px solid #ddd; border-radius:8px; margin-top:8px;">
					</div>

					<div class="form-group" style="margin-bottom:20px;">
						<label>아이콘 (이모지)</label>
						<input type="text" name="e_icon" placeholder="예: 🎉"
							style="width:100%; padding:10px; border:1px solid #ddd; border-radius:8px; margin-top:8px;">
					</div>

					<!-- 뱃지 - 드롭다운 -->
					<div class="form-group" style="margin-bottom:20px;">
						<label>뱃지</label>
						<select name="e_badge"
							style="width:100%; padding:10px; border:1px solid #ddd; border-radius:8px; margin-top:8px;">
							<option value="HOT">🔥 HOT</option>
							<option value="NEW">✨ NEW</option>
							<option value="EVENT">🎉 EVENT</option>
							<option value="BEST">⭐ BEST</option>
							<option value="LIMITED">⏰ LIMITED</option>
							<option value="SALE">💰 SALE</option>
						</select>
					</div>

					<div style="display:flex; gap:10px; margin-top:20px;">
						<button type="submit" class="btn-submit" onclick="setPeriod()">등록하기</button>
						<a href="${pageContext.request.contextPath}/admin/event"
							class="btn-submit" style="background:#888; text-decoration:none;">취소</a>
					</div>

				</form>
			</div>

		</div>

	</div>

	<script>
	function setPeriod() {
		const start = document.getElementById("startDate").value;
		const end = document.getElementById("endDate").value;
		if (start && end) {
			document.getElementById("e_period").value = start + " ~ " + end;
		} else if (start) {
			document.getElementById("e_period").value = start + " ~";
		}
	}
	</script>

</body>
</html>