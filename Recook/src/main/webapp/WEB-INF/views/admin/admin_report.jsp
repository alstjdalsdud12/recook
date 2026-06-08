<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true"%>
<%@ page import="com.springmvc.domain.RecipeReport"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 신고 관리 - ReCook</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin.css">
</head>
<body>

	<div class="admin-container">

		<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>

		<div class="main">

			<div class="top-bar">
				<h1>신고 관리</h1>
			</div>

			<div class="recent">

				<div style="margin-bottom: 20px;">
					<h2 style="margin: 0;">신고 목록</h2>
				</div>

				<table>
					<thead>
						<tr>
							<th>번호</th>
							<th>레시피</th>
							<th>신고자</th>
							<th>신고 사유</th>
							<th>신고일</th>
							<th>상태</th>
							<th>관리</th>
						</tr>
					</thead>
					<tbody>
						<%
						List<RecipeReport> reportList = (List<RecipeReport>) request.getAttribute("reportList");
						if (reportList != null && !reportList.isEmpty()) {
							for (RecipeReport report : reportList) {
						%>
						<tr>
							<td><%= report.getRp_no() %></td>
							<td>
								<a href="${pageContext.request.contextPath}/recipe_detail?r_no=<%= report.getR_no() %>">
									<%= report.getR_title() %>
								</a>
							</td>
							<td><%= report.getM_nickname() %></td>
							<td><%= report.getRp_reason() != null ? report.getRp_reason() : "-" %></td>
							<td><%= report.getRp_datetime() %></td>
							<td>
								<% if (report.getRp_status() == 0) { %>
									<span style="color:#ff6b6b; font-weight:bold;">미처리</span>
								<% } else { %>
									<span style="color:#4dabf7; font-weight:bold;">처리완료</span>
								<% } %>
							</td>
							<td>
								<div class="action-buttons">
									<% if (report.getRp_status() == 0) { %>
									<a href="${pageContext.request.contextPath}/admin/report/done?rp_no=<%= report.getRp_no() %>"
										class="btn-small btn-save"
										onclick="return confirm('처리 완료로 변경하시겠습니까?');">처리완료</a>
									<button class="btn-small btn-delete"
										onclick="showDeleteForm(<%= report.getRp_no() %>, <%= report.getR_no() %>)">레시피삭제</button>
									<% } %>
								</div>
							</td>
						</tr>
						<%
							}
						} else {
						%>
						<tr>
							<td colspan="7" style="text-align: center; color: #999;">신고 내역이 없습니다.</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>

			</div>

		</div>

	</div>

	<!-- 삭제 사유 팝업 -->
	<div id="deletePopup" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); z-index:9999; justify-content:center; align-items:center;">
		<div style="background:white; border-radius:20px; padding:30px; width:400px;">
			<h3>레시피 삭제 사유</h3>
			<form action="${pageContext.request.contextPath}/admin/recipe/delete/notify" method="get">
				<input type="hidden" name="r_no" id="deleteR_no">
				<input type="hidden" name="rp_no" id="deleteRp_no">
				<textarea name="reason" placeholder="삭제 사유를 입력해주세요" required
					style="width:100%; height:120px; border:1px solid #ddd; border-radius:12px; padding:12px; resize:none; box-sizing:border-box; margin:15px 0;"></textarea>
				<div style="display:flex; gap:10px; justify-content:flex-end;">
					<button type="submit" class="btn-small btn-delete">삭제하기</button>
					<button type="button" class="btn-small" onclick="closeDeletePopup()">취소</button>
				</div>
			</form>
		</div>
	</div>

	<script>
	function showDeleteForm(rp_no, r_no) {
	    document.getElementById("deleteR_no").value = r_no;
	    document.getElementById("deleteRp_no").value = rp_no;
	    const popup = document.getElementById("deletePopup");
	    popup.style.display = "flex";
	}

	function closeDeletePopup() {
	    document.getElementById("deletePopup").style.display = "none";
	}
	</script>

</body>
</html>