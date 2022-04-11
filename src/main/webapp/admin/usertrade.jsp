<%@page import="com.ibm.security.appscan.altoromutual.model.Trade"%>
<%@page import="com.ibm.security.appscan.altoromutual.model.Holding"%>
<%@page import="com.ibm.security.appscan.altoromutual.util.DBUtil"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>

<jsp:include page="/header.jspf"/>
<jsp:include page="/bank/membertoc.jspf"/>
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
    height: 850px;
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
    <%@ page import="com.ibm.security.appscan.altoromutual.model.Account" %>
    <%@ page import="java.text.DecimalFormat" %>
    <%@ page import="java.sql.SQLException" %>
    <%@ page import="java.sql.Timestamp" %>
    <%@ page import="java.text.SimpleDateFormat" %>
    <%@ page import="com.ibm.security.appscan.altoromutual.util.ConnectYahooFinance" %>


    <div class="fl" style="width: 99%;">
      <h1>Users Summary</h1>
<%--      <form id="trades" name="trades" method="post" action="/admin/viewTrade">--%>
<%--        <table width="700" border="0" style="padding-bottom:10px;">--%>

      <div align="center">
          <table border="0">
          <tr><td>
            <br><b>Users' Sharpe Ratio</b>
            <DIV ID='userSharpeRatio' STYLE='overflow: hidden; overflow-y: scroll; width:100%; height: 150px; padding:0px; margin: 0px'>
              <table border=1 cellpadding=2 cellspacing=0 id="_ctl0__ctl0_Content_Main_MyTransactions" style="width:100%;border-collapse:collapse;">
              <tr style="color:White;background-color:#BFD7DA;font-weight:bold;">
                <td>Account ID</td><td>Sharpe Ratio</td>
              </tr>
              <%
                Account[] allAccounts = DBUtil.getAllTradeAccounts();
                if (allAccounts != null) {
                  for (Account account: allAccounts) {
                    double sharpe_ratio = ConnectYahooFinance.getSharpeRatio(new Account[]{account});
                    if (!Double.isInfinite(sharpe_ratio)) {
                      String sharpeRatioStr = String.format("%.2f", sharpe_ratio);
              %>
              <tr>
                <td width=150><%=account.getAccountId()%></td>
                <td width=150 align=right><%=sharpeRatioStr%></td>
              </tr>
              <% } %>
              <% } %>
                <% } %>
            </table></DIV>
          </td></tr>
          <tr><td>
            <br><b>User's Holding Records</b>
            <DIV ID='userHolding' STYLE='overflow: hidden; overflow-y: scroll; width:100%; height: 220px; padding:0px; margin: 0px'>
            <table border=1 cellpadding=2 cellspacing=0 id="_ctl0__ctl0_Content_Main_MyTransactions" style="width:100%;border-collapse:collapse;">
              <tr style="color:White;background-color:#BFD7DA;font-weight:bold;">
                <td>Account ID</td><td>Stock Symbol</td><td>Stock Name</td><td>Shares Holding</td><td>Price Per Share</td>
              </tr>
              <%
                Holding[] holdings = DBUtil.getHolding(DBUtil.getAllTradeAccounts());
                if (holdings != null) {
                  for (Holding holding: holdings) {
                    double dblcostPrice = holding.getCostPrice();
                    String dollarFormat = (dblcostPrice<1)?"$0.00":"$.00";
                    String costPrice = new DecimalFormat(dollarFormat).format(dblcostPrice);
              %>
              <tr>
                <td width=15%><%=holding.getAccountId()%></td>
                <td width=15%><%=holding.getStockSymbol()%></td>
                <td width=34%><%=holding.getStockName()%></td>
                <td width=18% align=right><%=holding.getHoldingAmount()%></td>
                <td width=18% align=right><%=costPrice%></td>
              </tr>
              <% } %>
              <% } %>
            </table></DIV>
          </td></tr>
          <tr><td>
            <br><b>Today's Trade Records</b>
            <DIV ID='record' STYLE='overflow: hidden; overflow-y: scroll; width:100%; height: 220px; padding:0px; margin: 0px'>
              <table border=1 cellpadding=2 cellspacing=0 id="_ctl0__ctl0_Content_Main_MyTransactions" style="width:100%;border-collapse:collapse;">
              <tr style="color:White;background-color:#BFD7DA;font-weight:bold;">
                <td>Trade ID</td><td>Account ID</td><td>Description</td><td>Stock Symbol</td><td>Stock Name</td><td>Shares</td><td>Price Per Share</td>
              </tr>
              <% Trade[] trades = new Trade[0];
                try {
                  Timestamp date = new Timestamp(new java.util.Date().getTime());
                  SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
                  String dateStr = sd.format(date);
                  trades = DBUtil.getTradeRecords(dateStr,dateStr,allAccounts,0);
                } catch (SQLException e) {
                  e.printStackTrace();
                }
                if (trades != null) {
                  for (Trade trade: trades) {
                    double dblcostPrice = trade.getPrice();
                    String dollarFormat = (dblcostPrice<1)?"$0.00":"$.00";
                    String price = new DecimalFormat(dollarFormat).format(dblcostPrice);
              %>
              <tr>
                <td width=10%><%=trade.getTradeId()%></td>
                <td width=12%><%=trade.getAccountId()%></td>
                <td width=12%><%=trade.getTradeType()%></td>
                <td width=15%><%=trade.getStockSymbol()%></td>
                <td width=26%><%=trade.getStockName()%></td>
                <td width=10% align=right><%=trade.getAmount()%></td>
                <td width=15% align=right><%=price%></td>
              </tr>
              <% } %>
              <% } %>
            </table></DIV>
          </td></tr>
        </table>
      </div>
    </div>
  </td>
</div>

<jsp:include page="/footer.jspf"/>