<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<jsp:include page="/header.jspf"/>
<jsp:include page="membertoc.jspf"/>
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
					<div class="div_text">
						<br>Please enter the information for the stock you want to buy or sell.
						<br>Please pay attention that BigBucks does not support short selling, and make sure the correctness of the information you enter.
						<br /><br />
					<table cellSpacing="0" cellPadding="1" width="100%" border="0">
						<tr>
							<td><strong>Choose Account</strong></td>
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
							<td colspan="2" align="center"><input type="submit" name="trade" value="Trade Stock" ID="stockTrade"></td>
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
					</div>
				</form>
			</div>
		</div>
    </td>	
</div>

<jsp:include page="/footer.jspf"/>