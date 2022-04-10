<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="com.ibm.security.appscan.altoromutual.util.ServletUtil"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<title>Welcome Page</title>

<style type="text/css">
	hr{
		margin: 20px 0;
	}
	a{
		font-size: 20px;
		font-weight: bold;
	}
	a:visited {
		color: #b1f158;
		text-decoration: none;
	}
</style>
<%--<div id="wrapper" style="width: 99%;">--%>
<body style="background-color: #2F4F4F"></body>
	<div align="center">
		<br /><br /><br />
		<img src="images/logo.png" alt="image" width="450" height="600">
		<br />
		<img src="images/BigBucks.png" alt="image" width="437" height="98">
		<br /><br />
	</div>
	<div align="center" style="color: #FFFFFF">
		<br><font size="5px">Welcome to BigBucks Online!</font>
		<br><font size="4px">We provide professional wealth management services for those who want to invest.</font>
		<br><font size="4px">Please<a href="#" target="black"><a href="login.jsp"> log in </a> or <a href="signup.jsp"> register </a> the account to make stock purchases.</a></font>
		<br /><br /><br />
	</div>

</body>

<jsp:include page="footer.jspf"/>