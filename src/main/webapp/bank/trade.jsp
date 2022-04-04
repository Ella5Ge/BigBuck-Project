<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.SQLException"%>
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

        <%@ page import="com.ibm.security.appscan.altoromutual.util.DBUtil" %>
        <%@ page import="com.ibm.security.appscan.altoromutual.model.Holding" %>

        <div class="fl" style="width: 99%;">

            <%
                com.ibm.security.appscan.altoromutual.model.User user = (com.ibm.security.appscan.altoromutual.model.User)request.getSession().getAttribute("user");

                String error = "";

                Holding[] holdings = DBUtil.getHolding(user.getAccounts());
            %>

            <h1>Trade Report</h1>

            <font style="bold" color="red"><%=error%></font>
            <form id="Form1" name="Form1" method="post" action="showHoldings">
                <h2>Sharpe Ratio</h2>
                <h2>Holdings</h2>
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
            </form>

        </div>

    </td>
</div>

<jsp:include page="/footer.jspf"/>
