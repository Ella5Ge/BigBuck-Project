<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.SQLException"%>
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
        height: 600px;
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

        <%@ page import="com.ibm.security.appscan.altoromutual.util.DBUtil" %>
        <%@ page import="com.ibm.security.appscan.altoromutual.model.Holding" %>
        <%@ page import="com.ibm.security.appscan.altoromutual.util.ConnectYahooFinance" %>

        <div class="fl" style="width: 99%;">

            <%
                com.ibm.security.appscan.altoromutual.model.User user = (com.ibm.security.appscan.altoromutual.model.User)request.getSession().getAttribute("user");

                String error = "";

                double sharpe_ratio = ConnectYahooFinance.getSharpeRatio(user.getAccounts());
                String sharpeRatioStr = String.format("%.2f", sharpe_ratio);

                Holding[] holdings = DBUtil.getHolding(user.getAccounts());
            %>

            <h1>Trade Report</h1>

            <font style="bold" color="red"><%=error%></font>
            <form id="Form1" name="Form1" method="post" action="showHoldings">
                <div class="div_text">
                    <h2>Below is your Holdings</h2>
                </div>
                <div align="center">
                    <DIV ID='recent' STYLE='overflow: hidden; overflow-y: scroll; width:90%; height: 200px; padding:0px; margin: 0px' >
                <table cellspacing="0" cellpadding="3" rules="all" border="1" id="_ctl0__ctl0_Content_Main_MyTransactions" style="width:100%;border-collapse:collapse;">
                    <tr style="color:White;background-color:#BFD7DA;font-weight:bold;">
                        <td>Account ID</td>
                        <td>Stock Symbol</td>
                        <td>Stock Name</td>
                        <td>Shares Held</td>
                        <td>Price Per Share</td>
                    </tr>
                    <% for (int i=0; i<holdings.length; i++){
                        double dblPrice = holdings[i].getCostPrice();
                        String format = (dblPrice<1)?"$0.00":"$.00";
                        String price = new DecimalFormat(format).format(dblPrice);
                    %>

                    <tr>
                        <td><%=holdings[i].getAccountId()%></td>
                        <td><%=holdings[i].getStockSymbol()%></td>
                        <td><%=holdings[i].getStockName()%></td>
                        <td align="right"><%=holdings[i].getHoldingAmount()%></td>
                        <td align="right"><%=price%></td>
                    </tr>
                    <% } %>
                    <tr>
                        <!-- TODO PAGES: <td colspan="4"><span>1</span>&nbsp;<a href="javascript:__doPostBack('_ctl0$_ctl0$Content$Main$MyTransactions$_ctl54$_ctl1','')">2</a></td> -->
                    </tr>
                </table>
                        </DIV>
                </div>
                <div class="div_text">
                    <br />
                    <h2>Your Sharpe Ratio is <%=sharpeRatioStr%></h2>
                    <br />
                    <h2>What is the Sharpe Ratio?</h2>
                    The Sharpe Ratio (or Sharpe Index or Modified Sharpe Ratio) is commonly used to gauge the performance of an investment by adjusting for its risk. The higher the ratio, the greater the investment return relative to the amount of risk taken, and thus, the better the investment.
                    <br />
                    <h2>Sharpe Ratio Formula?</h2>
                    Sharpe Ratio = (Rx - Rf) / StdDev Rx
                    <br>Where:
                    <br>      Rx = Expected portfolio return
                    <br>      Rf = Risk-free rate of return
                    <br>      StdDev Rx = Standard deviation of portfolio return (or, volatility)
                </div>
            </form>

        </div>

    </td>
</div>

<jsp:include page="/footer.jspf"/>
