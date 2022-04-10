<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="com.ibm.security.appscan.altoromutual.util.ServletUtil"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
/**
 This application is for demonstration use only. It contains known application security
vulnerabilities that were created expressly for demonstrating the functionality of
application security testing tools. These vulnerabilities may present risks to the
technical environment in which the application is installed. You must delete and
uninstall this demonstration application upon completion of the demonstration for
which it is intended.

IBM DISCLAIMS ALL LIABILITY OF ANY KIND RESULTING FROM YOUR USE OF THE APPLICATION
OR YOUR FAILURE TO DELETE THE APPLICATION FROM YOUR ENVIRONMENT UPON COMPLETION OF
A DEMONSTRATION. IT IS YOUR RESPONSIBILITY TO DETERMINE IF THE PROGRAM IS APPROPRIATE
OR SAFE FOR YOUR TECHNICAL ENVIRONMENT. NEVER INSTALL THE APPLICATION IN A PRODUCTION
ENVIRONMENT. YOU ACKNOWLEDGE AND ACCEPT ALL RISKS ASSOCIATED WITH THE USE OF THE APPLICATION.

IBM AltoroJ
(c) Copyright IBM Corp. 2008, 2013 All Rights Reserved.
*/
%>
<title>Welcome Page</title>

<style type="text/css">
	hr{
		margin: 16px 1;
	}
	a{
		font-size: 16px;
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
		<br>Welcome to BigBucks Online!
		<br>We provide professional wealth management services for those who want to invest.
		<br>Please<a href="#" target="black"><a href="login.jsp"> log in </a> or <a href="signup.jsp"> register </a> the account to make stock purchases.</a>
		<br /><br /><br />
	</div>

</body>

<jsp:include page="footer.jspf"/>