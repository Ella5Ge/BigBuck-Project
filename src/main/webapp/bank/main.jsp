<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<jsp:include page="/header.jspf"/>
<jsp:include page="membertoc.jspf"/>
<%--<div id="wrapper" style="width: 99%;">--%>
<body style="background-color: #2F4F4F"></body>
<style>
	body {
		background-color: gainsboro;
		font-size: 12px;
	}
	.div_top_1 {
		height: 5px;
		width: 100%;
	}
	.main {
		width: 90%;
		height: 400px;
		background-color: #FFFFFF;
		margin: 0 auto;
	}
	.div_text {
		width: 600px;
		margin-left: 5%;
		text-align: left;
	}
</style>
<body>
<div class="div_top_1">


</div>
<div class="main" id="wrapper">
	<td>
		<%@page import="com.ibm.security.appscan.altoromutual.model.Account"%>
		<div class="fl" style="width: 99%;">
			<%
				com.ibm.security.appscan.altoromutual.model.User user = (com.ibm.security.appscan.altoromutual.model.User)request.getSession().getAttribute("user");
			%>
			<center><h1>
				Hello <%= user.getFirstName() + " " + user.getLastName() %>
			</h1></center>
			<br />
		</div>
	</td>
		<div align="center" class="div_text" >
			<h2>Welcome to BigBucks Online.</h2>
			<h2>We provide you with real-time trading functionality.</h2>
			<h2>You have been credited $1,000,000 in your cash account, for use in buying and selling stocks.</h2>

			<br /><br />
			<form name="details" method="get" action="showAccount">
			<table border="0">
			  <TR valign="top">
			    <td>View Account Details:</td>
			    <td align="left">
				  <select size="1" name="listAccounts" id="listAccounts">
					<%
					for (Account account: user.getAccounts()){
						out.println("<option value=\""+account.getAccountId()+"\" >" + account.getAccountId() + " " + account.getAccountName() + "</option>");
					}
					%>
				  </select>
			      <input type="submit" id="btnGetAccount" value="   GO   ">
			    </td>
			  </tr>
			</table>
			</form>
		</div>
</div>

<jsp:include page="/footer.jspf"/>	