<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 - ReCook</title>


<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/sign_up.css">

<script>
// 🔥 비밀번호 일치 확인
function checkPassword() {
    const pw = document.getElementsByName("pw")[0].value;
    const pwConfirm = document.getElementsByName("pwConfirm")[0].value;
    const msg = document.getElementById("pwMsg");

    if(pwConfirm === "") {
        msg.innerHTML = "";
        return;
    }

    if(pw === pwConfirm) {
        msg.innerHTML = "✔ 비밀번호가 일치합니다.";
        msg.style.color = "green";
    } else {
        msg.innerHTML = "✖ 비밀번호가 일치하지 않습니다.";
        msg.style.color = "red";
    }
}

// 🔥 전화번호 자동 하이픈
function autoHyphen(target) {
    target.value = target.value
        .replace(/[^0-9]/g, '')
        .replace(/^(\d{3})(\d{4})(\d{4})$/, `$1-$2-$3`);
}
</script>

</head>
<body>

	<div class="main-container">
		<div class="signup-box">

			<div class="signup-title">회원가입</div>

			<form action="${pageContext.request.contextPath}/sign_up"
				method="post">

				<div class="input-group">
					<label>닉네임</label>
					<input type="text" name="nickname">
				</div>

				<div class="input-group">
					<label>아이디</label>
					<input type="text" name="id">
				</div>

				<div class="input-group">
					<label>비밀번호</label>
					<input type="password" name="pw" onkeyup="checkPassword()">
				</div>

				<div class="input-group">
					<label>비밀번호 확인</label>
					<input type="password" name="pwConfirm" onkeyup="checkPassword()">
					<div id="pwMsg" style="font-size:13px; margin-top:5px;"></div>
				</div>

				<div class="input-group">
					<label>생년월일</label>

					<div class="birth-box">
						<select name="birthYear">
							<option value="">년</option>
							<% for(int i = 1950; i <= 2026; i++) { %>
								<option value="<%=i%>"><%=i%></option>
							<% } %>
						</select>

						<select name="birthMonth">
							<option value="">월</option>
							<% for(int i = 1; i <= 12; i++) { %>
								<option value="<%=i%>"><%=i%></option>
							<% } %>
						</select>

						<select name="birthDay">
							<option value="">일</option>
							<% for(int i = 1; i <= 31; i++) { %>
								<option value="<%=i%>"><%=i%></option>
							<% } %>
						</select>
					</div>
				</div>

				<div class="input-group">
					<label>성별</label>

					<div class="gender-box">
						<input type="radio" id="male" name="gender" value="M" hidden>
						<label for="male" class="gender-btn">남</label>

						<input type="radio" id="female" name="gender" value="F" hidden>
						<label for="female" class="gender-btn">여</label>
					</div>
				</div>

				<div class="input-group">
					<label>전화번호</label>
					<input type="text" name="phone"
						placeholder="010-1234-5678"
						oninput="autoHyphen(this)"
						maxlength="13">
				</div>

				<div class="input-group">
					<label>이메일</label>
					<input type="email" name="email"
						placeholder="ex) abc@naver.com">
				</div>

				<button type="submit" class="signup-submit">회원가입</button>

			</form>

			<div class="extra">
				이미 계정이 있으신가요?
				<a href="${pageContext.request.contextPath}/login">로그인</a>
			</div>

		</div>
	</div>

</body>
</html>