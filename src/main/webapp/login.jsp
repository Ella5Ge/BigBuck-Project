<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
		 pageEncoding="ISO-8859-1"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<base href="<%=basePath%>">
	<title>BigBucks Login Page</title>
</head>

<body style="background-color: #2F4F4F"></body>
<style>
	body {
		background-color: gainsboro;
		font-size: 16px;
	}

	.div_top_1 {
		height: 120px;
		width: 100%;
	}

	.div_top_2 {
		height: 50px;
		width: 100%;
	}

	.main {
		width: 417.683px;
		height: 440px;
		background-color: #FFFFFF;
		margin: 0 auto;

	}

	.login {

		width: 360px;
		height: 360px;
		background-color: #FFFFFF;
		margin: 0 auto
	}

	.div_login_head {
		height: 36px;
		background-color: #FFFFFF;
		margin: 0 auto;
		line-height: 36px;
		text-align: center;
		color: #666;
		border-bottom: 3px solid #21b351;
		font-size: 18px;
		line-height: 24px;
		margin-bottom: -1px;
		font-family: "PingFang SC", "Microsoft yahei", "Helvetica Neue", "Helvetica", "Arial", sans-serif;
	}

	.div_input_account {
		width: 360px;
		height: 40px;

	}

	.div_input_pwd {
		width: 360px;
		height: 24px;

	}

	.input_account, .input_pwd {
		width: 360px;
		height: 40px;
		border: none;
		border-bottom: #ddd 1px solid;
		border-radius: 0;
		outline: 0;
		font: inherit;
		font-size: .875rem;
	}

	.div_button_login {
		width: 360px;
		height: 40px;
		margin-top: 36px;
		text-align: center;

	}

	.button_login {
		width: 180px;
		height: 40px;
		background: #1fa54a;
		font-size: 16px;
		cursor: pointer;
		color: white;
		border: none;
		border-radius: 2px;
		outline: 0;

	}

	.div_empty {
		width: 360px;
		height: 24px;

	}
	.div_signup {
		width: 360px;
		height: 24px;
		text-align: center;
	}

</style>
<body>
<div class="div_top_1">


</div>
<div align="center">
	<img src="images/BigBucks.png" alt="image" width="437" height="98">
	<br />
</div>
<div class="main">
	<div class="login">
		<div class="div_top_2">

		</div>
		<div class="div_login_head">
			BigBucks Account Login
		</div>

		<div class="div_empty">
		</div>
		<p><span id="_ctl0__ctl0_Content_Main_message" style="color:#FF0066;font-size:12pt;font-weight:bold;">
		<%
			java.lang.String error = (String)request.getSession(true).getAttribute("loginError");
			String expectedError = "Login Failed: We're sorry, but this username or password was not found in our system. Please try again.";
			String expectedSuccess = "Successful Sign up!";
			if (error != null && error.trim().length() > 0 && !error.equals(expectedSuccess)){
				request.getSession().removeAttribute("loginError");
		%>
			<script type="text/javascript" language="javascript">
				alert(<%=error%>);
			</script>
			<%
			} else if (error != null && error.trim().length() > 0 && error.equals(expectedSuccess)) {
				request.getSession().removeAttribute("loginError");
				out.print(error);
			}
			%>
		</span></p>
		<form action="doLogin" method="post" name="login" id="login" onsubmit="return (confirminput(login));">
			<div class="div_input_account">
				<input class="input_account" type="text" id="uid" name="uid" placeholder="Username" value="${userName }"/>
			</div>
			<div class="div_empty">
			</div>

			<div class="div_input_pwd">
			<input class="input_pwd" type="password" name="passw" placeholder="Password" value="${pwd }"/>
			</div>
			<div class="div_empty">
			</div>

			<div class="div_button_login">
				<input class="button_login" type="submit" name="btnSubmit" value="login"/>
			</div>
			<br /><br />
			<div align="center">
				Don't have an account? Please <a href="signup.jsp"> register</a>.
			</div>
		</form>

	</div>
	<script type="text/javascript">
		function setfocus() {
			if (document.login.uid.value=="") {
				document.login.uid.focus();
			} else {
				document.login.passw.focus();
			}
		}

		function confirminput(myform) {
			if (myform.uid.value.length && myform.passw.value.length) {
				return (true);
			} else if (!(myform.uid.value.length)) {
				myform.reset();
				myform.uid.focus();
				alert ("You must enter a valid username");
				return (false);
			} else {
				myform.passw.focus();
				alert ("You must enter a valid password");
				return (false);
			}
		}
		window.onload = setfocus;
	</script>

</div>
</body>
</html>
<jsp:include page="footer.jspf"/>