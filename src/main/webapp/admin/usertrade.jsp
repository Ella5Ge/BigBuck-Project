<%@page import="com.ibm.security.appscan.altoromutual.model.Trade"%>
<%@page import="com.ibm.security.appscan.altoromutual.model.Holding"%>
<%@page import="com.ibm.security.appscan.altoromutual.util.DBUtil"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>



<jsp:include page="/header.jspf"/>

<div id="wrapper" style="width: 99%;">
  <jsp:include page="/bank/membertoc.jspf"/>
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
        <table width="700" border="0" style="padding-bottom:10px;">
          <tr><td>
            <br><h2>Users' Sharpe Ratio</h2>
            <table border=1 cellpadding=2 cellspacing=0 width='300'>
              <tr style="color:Black;background-color:#BFD7DA;font-weight:bold;">
                <th width=150>Account ID</th>
                <th width=150>Sharpe Ratio</th>
              </tr>
            </table>
            <DIV ID='userSharpeRatio' STYLE='width:590px; padding:0px; margin: 0px' ><table border=1 cellpadding=2 cellspacing=0 width='300'>
              <%
                Account[] allAccounts = DBUtil.getAllTradeAccounts();
                if (allAccounts != null) {
                  for (Account account: allAccounts) {
                    double sharpe_ratio = ConnectYahooFinance.getSharpeRatio(new Account[]{account});
                    String sharpeRatioStr = String.format("%.2f", sharpe_ratio);
              %>
              <tr>
                <td width=150><%=account.getAccountId()%></td>
                <td width=150 align=right><%=sharpeRatioStr%></td>
              </tr>
              <% } %>
              <% } %>
            </table></DIV>
          </td></tr>
          <tr><td>
            <br><h2>User's Holding Records</h2>
            <table border=1 cellpadding=2 cellspacing=0 width='700'>
              <tr style="color:Black;background-color:#BFD7DA;font-weight:bold;">
                <th width=15%>Account ID</th>
                <th width=15%>Stock Symbol</th>
                <th width=34%>Stock Name</th>
                <th width=18%>Shares Holding</th>
                <th width=18%>Price per share</th>
              </tr>
            </table>
            <DIV ID='userHolding' STYLE='width:700px; padding:0px; margin: 0px' ><table border=1 cellpadding=2 cellspacing=0 width='700'>
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
            <br><h2>Today's Trade Records</h2>
            <table border=1 cellpadding=2 cellspacing=0 width='840'>
              <tr style="color:Black;background-color:#BFD7DA;font-weight:bold;">
                <th width=10%>Trade ID</th>
                <th width=12%>Account ID</th>
                <th width=12%>Description</th>
                <th width=15%>Stock Symbol</th>
                <th width=26%>Stock Name</th>
                <th width=10%>Shares</th>
                <th width=15%>Price per share</th>
              </tr>
            </table>
            <DIV ID='record' STYLE='width:880px; padding:0px; margin: 0px' ><table border=1 cellpadding=2 cellspacing=0 width='840'>
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
<%--      </form>--%>
    </div>
  </td>
</div>
