<%@page import="com.ibm.security.appscan.altoromutual.model.Trade"%>
<%@page import="com.ibm.security.appscan.altoromutual.model.Holding"%>
<%@page import="com.ibm.security.appscan.altoromutual.util.DBUtil"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
		 pageEncoding="ISO-8859-1"%>

<jsp:include page="/header.jspf"/>
<jsp:include page="membertoc.jspf"/>
<body style="background-color: #2F4F4F"></body>
<style>
	body {
		background-color: gainsboro;
		font-size: 16px;
	}
	.div_top_1 {
		height: 5px;
		width: 100%;
	}
	.main {
		width: 90%;
		height: 700px;
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
		<%@page import="java.text.SimpleDateFormat"%>
		<%@page import="java.text.NumberFormat"%>
		<%@page import="java.text.DecimalFormat"%>
		<%@page import="java.util.ArrayList"%>
		<div class="fl" style="width: 99%;">

			<%
				com.ibm.security.appscan.altoromutual.model.User user = (com.ibm.security.appscan.altoromutual.model.User)request.getSession().getAttribute("user");
				ArrayList<Account> accounts = new ArrayList<Account>();
				java.lang.String paramName = request.getParameter("acctId");
				String accountName = paramName;

				for (Account account: user.getAccounts()){

					if (!String.valueOf(account.getAccountId()).equals(paramName))
						accounts.add(account);
					else {
						accounts.add(0, account);
						accountName = account.getAccountId() + " " + account.getAccountName();
					}
				}
			%>

			<!-- To modify account information do not connect to SQL source directly.  Make all changes
            through the admin page. -->

			<h1>Account History - <%=accountName%></h1>

			<div align="center">
			<table border="0">
				<tr><td colspan=2>
					<table cellSpacing="0" cellPadding="1" width=90% border="1" id="_ctl0__ctl0_Content_Main_MyTransactions" style="width:100%;border-collapse:collapse;">
						<tr>
							<th colSpan="2">
								Balance Detail</th></tr>
						<tr>
							<th align="left" width="80%" height="26">
								<form id="Form1" method="get" action="showAccount">
									<select size="1" name="listAccounts" id="listAccounts">
										<%
											for (Account account: accounts){
												out.println("<option value=\""+account.getAccountId()+"\">" + account.getAccountId() + " " + account.getAccountName() + "</option>");
											}
											double dblBalance = Account.getAccount(paramName).getBalance();
											String format = (dblBalance<1)?"$0.00":"$.00";
											String balance = new DecimalFormat(format).format(dblBalance);
										%>
									</select>
									<input type="submit" id="btnGetAccount" Value="Select Account">
								</form>
							</th>
							<th align="middle" height="26">Amount</th>
						</tr>
						<tr>
							<td>Ending balance as of <%= new SimpleDateFormat().format(new java.util.Date()) %></td>
							<td align="right"><% out.println(balance); %></td>
						</tr>
						<tr><td>Available balance</td><td align="right"><% out.println(balance); %></td></tr>
					</table>
				</td></tr>
				<tr><td>
					<br><b>10 Most Recent Trade Records</b>
					<DIV ID='recent' STYLE='overflow: hidden; overflow-y: scroll; width:100%; height: 152px; padding:0px; margin: 0px' >
						<table cellspacing="0" cellpadding="3" rules="all" border="1" id="_ctl0__ctl0_Content_Main_MyTransactions" style="width:100%;border-collapse:collapse;">
							<tr style="color:White;background-color:#BFD7DA;font-weight:bold;">
								<td>Date</td><td>Description</td><td>Stock Symbol</td><td>Stock Name</td><td>Amount</td><td>Price Per Share</td>
							</tr>
						<%
							Trade[] trades = DBUtil.getTradeRecords(null, null, new Account[]{DBUtil.getAccount(Long.valueOf(paramName))}, 10);
							for (Trade trade: trades){
								double dblPrice = trade.getPrice();
								String dollarFormat = (dblPrice<1)?"$0.00":"$.00";
								String price = new DecimalFormat(dollarFormat).format(dblPrice);
								String date = new SimpleDateFormat("yyyy-MM-dd").format(trade.getDate());
						%>
						<tr><td><%=date%></td>
							<td><%=trade.getTradeType()%></td>
							<td><%=trade.getStockSymbol()%></td>
							<td><%=trade.getStockName()%></td>
							<td align=right><%=trade.getAmount()%></td>
							<td align=right><%=price%></td>
						</tr>
						<% } %>
					</table></DIV>
				</td></tr>
				<tr><td>
					<br><b>Holding List</b>

					<DIV ID='hold' STYLE='overflow: hidden; overflow-y: scroll; width:100%; height: 152px; padding:0px; margin: 0px' >
						<table cellspacing="0" cellpadding="3" rules="all" border="1" id="_ctl0__ctl0_Content_Main_MyTransactions" style="width:100%;border-collapse:collapse;">
							<tr style="color:White;background-color:#BFD7DA;font-weight:bold;">
								<td>Ticker Symbol</td><td>Stock Name</td><td>Shares Holding</td><td>Price per share</td>
							</tr>
						<%
							Holding[] holdings = DBUtil.getHolding(new Account[]{DBUtil.getAccount(Long.valueOf(paramName))});
							for (Holding holding: holdings){
								double dblcostPrice = holding.getCostPrice();
								String dollarFormat2 = (dblcostPrice<1)?"$0.00":"$.00";
								String costPrice = new DecimalFormat(dollarFormat2).format(dblcostPrice);
						%>
						<tr><td><%=holding.getStockSymbol()%></td>
							<td><%=holding.getStockName()%></td>
							<td align=right><%=holding.getHoldingAmount()%></td>
							<td align=right><%=costPrice%></td>
						</tr>
						<% } %>
					</table></DIV>
				</td></tr>
			</table>
			</div>
		</div>
	</td>
</div>

<jsp:include page="/footer.jspf"/>
