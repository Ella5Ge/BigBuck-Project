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
    
<jsp:include page="/header.jspf"/>

<div id="wrapper" style="width: 99%;">
	<jsp:include page="membertoc.jspf"/>
    <td valign="top" colspan="3" class="bb">
		<%@page import="com.ibm.security.appscan.altoromutual.model.Account"%>
		<%
			com.ibm.security.appscan.altoromutual.model.User user = (com.ibm.security.appscan.altoromutual.model.User)request.getSession().getAttribute("user");
		%>

		<div class="fl" style="width: 99%;">

			<script type="text/javascript">

				function confirminput(myform) {
					var amt=document.getElementById("tradeAmount").value;

					if (!(amt > 0)){
						alert("Stock Amount must be a number greater than 0.");
						return false;
					}
					return true;
				}

			</script>

			<div class="fl" style="width: 99%;">

				<form action="doTrade" method="post" name="trade" id="trade" onsubmit="return (confirminput(trade));">

					<h1> Trade Stock</h1>
<%--			<p><span id="_ctl0__ctl0_Content_Main_message" style="color:#FF0066;font-size:12pt;font-weight:bold;">--%>
<%--				<%--%>
<%--					java.lang.String error = (String)request.getSession(true).getAttribute("loginError");--%>
<%--					if (error != null && error.trim().length() > 0){--%>
<%--						request.getSession().removeAttribute("loginError");--%>
<%--						out.print(error);--%>
<%--					}--%>
<%--				%>--%>
<%--			</span></p>--%>
					<table cellSpacing="0" cellPadding="1" width="100%" border="0">
						<tr>
							<td>
								Choose Account:
							</td>
							<td>
								<select size="1" id="chooseAccount" name="chooseAccount">
									<%
										for (Account account: user.getAccounts()){
											out.println("<option value=\""+account.getAccountId()+"\" >" + account.getAccountId() + " " + account.getAccountName() + "</option>");
										}
									%>
								</select>
							</td>
						</tr>
						<tr>
							<td><strong>Trade Type:</strong></td>
							<td>
								<select size="1" id="tradeType" name="tradeType">
									<option value="buy">Buy</option>
									<option value="sell">Sell</option>
								</select>
							</td>
						</tr>
						<tr>
							<td><strong>Stock Symbol:</strong></td>
							<td>
								<input type="text" id="stockSymbol" name="stockSymbol" style="width: 150px;">
							</td>
						</tr>
					<tr>
						<td><strong>Stock Amount:</strong></td>
						<td>
							<input type="number" id="tradeAmount" name="tradeAmount" style="width: 150px;">
						</td>
					</tr>
						<tr>
							<td colspan="2" align="center"><input type="submit" name="trade" value="Trade Stock" ID="trade"></td>
						</tr>
						<tr>
							<td colspan="2">&nbsp;</td>
						</tr>
						<tr>
							<td colspan="2" align="center">
								<span id="_ctl0__ctl0_Content_Main_postResp" align="center"><span style='color: Red'><%=(request.getAttribute("message")==null)?"":request.getAttribute("message") %></span></span>
								<span id="soapResp" name="soapResp" align="center" />
							</td>
						</tr>
				</table>
			</form>
		</div>
    </td>	
</div>

<jsp:include page="/footer.jspf"/>