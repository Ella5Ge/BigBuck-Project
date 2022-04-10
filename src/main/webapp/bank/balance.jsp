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
			<table width="700" border="0">
				<tr><td colspan=2>
					<table cellSpacing="0" cellPadding="1" width="100%" border="1">
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
					<table border=1 cellpadding=2 cellspacing=0 width='700'>
						<tr><th bgcolor=#cccccc width=90>Date</th>
							<th width=90>Description</th>
							<th width=90>Ticker Symbol</th>
							<th width=90>Stock Name</th>
							<th width=90>Amount</th>
							<th width=90>Price per share</th>
						</tr>
					</table>
					<DIV ID='recent' STYLE='overflow: hidden; overflow-y: scroll; width:710px; height: 152px; padding:0px; margin: 0px' >
						<table border=1 cellpadding=2 cellspacing=0 width='700'>
						<%
							Trade[] trades = DBUtil.getTradeRecords(null, null, new Account[]{DBUtil.getAccount(Long.valueOf(paramName))}, 10);
							for (Trade trade: trades){
								double dblPrice = trade.getPrice();
								String dollarFormat = (dblPrice<1)?"$0.00":"$.00";
								String price = new DecimalFormat(dollarFormat).format(dblPrice);
								String date = new SimpleDateFormat("yyyy-MM-dd").format(trade.getDate());
						%>
						<tr><td width=90><%=date%></td>
							<td width=90><%=trade.getTradeType()%></td>
							<td width=90><%=trade.getStockSymbol()%></td>
							<td width=90><%=trade.getStockName()%></td>
							<td width=90 align=right><%=trade.getAmount()%></td>
							<td width=90 align=right><%=price%></td>
						</tr>
						<% } %>
					</table></DIV>
				</td></tr>
				<tr><td>
					<br><b>Holding List</b>
					<table border=1 cellpadding=2 cellspacing=0 width='600'>
						<tr><th width=90>Ticker Symbol</th>
							<th width=90>Stock Name</th>
							<th width=90>Shares Holding</th>
							<th width=90>Price per share</th>
						</tr>
					</table>
					<DIV ID='hold' STYLE='overflow: hidden; overflow-y: scroll; width:710px; height: 152px; padding:0px; margin: 0px' ><table border=1 cellpadding=2 cellspacing=0 width='600'>
						<%
							Holding[] holdings = DBUtil.getHolding(new Account[]{DBUtil.getAccount(Long.valueOf(paramName))});
							for (Holding holding: holdings){
								double dblcostPrice = holding.getCostPrice();
								String dollarFormat2 = (dblcostPrice<1)?"$0.00":"$.00";
								String costPrice = new DecimalFormat(dollarFormat2).format(dblcostPrice);
						%>
						<tr><td width=90><%=holding.getStockSymbol()%></td>
							<td width=90><%=holding.getStockName()%></td>
							<td width=90 align=right><%=holding.getHoldingAmount()%></td>
							<td width=90 align=right><%=costPrice%></td>
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
