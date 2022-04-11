<%@page import="com.ibm.security.appscan.altoromutual.api.ChartAPI"%>
<%@ page import="org.jfree.chart.servlet.ServletUtilities" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<jsp:include page="header.jspf"/>
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
        height: 550px;
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
        <div class="fl" style="width: 99%;" align="center">
            <%
                String stockSymbol = request.getParameter("symbol");
                String graphType = request.getParameter("graphType");
                String indexSymbol = "SPY";
                String chart = null;
                String title = null;
                try {
                    if (graphType.equals("chart1")) {
                        chart = ServletUtilities.saveChartAsPNG(ChartAPI.getStockPriceChart(stockSymbol),800,500,null);
                        title = stockSymbol + " Price Line Chart";
                    }
                    else if (graphType.equals("chart2")) {
                        chart = ServletUtilities.saveChartAsPNG(ChartAPI.getStockReturnChart(stockSymbol),800,500,null);
                        title = stockSymbol + " Return Scatter Chart";
                    }
                    else if (graphType.equals("chart3")) {
                        chart = ServletUtilities.saveChartAsPNG(ChartAPI.getStockAutoCorrChart(stockSymbol),800,500,null);
                        title = stockSymbol + " Today's Rate of Return vs Yesterday's";
                    }
                    else if (graphType.equals("chart4")) {
                        chart = ServletUtilities.saveChartAsPNG(ChartAPI.getFreqHistogram(stockSymbol),800,500,null);
                        title = stockSymbol + " Return Histogram";
                    }
                    else if (graphType.equals("chart5")) {
                        chart = ServletUtilities.saveChartAsPNG(ChartAPI.getCumReturnChart(stockSymbol, indexSymbol),800,500,null);
                        title = stockSymbol + " vs SPY Index Cumulative Return";
                    }
                    else if (graphType.equals("chart6")) {
                        chart = ServletUtilities.saveChartAsPNG(ChartAPI.getStockVSIndexDailyReturn(stockSymbol, indexSymbol),800,500,null);
                        title = stockSymbol + " vs SPY Index Daily Return";
                    }
                    else if (graphType.equals("chart7")) {
                        chart = ServletUtilities.saveChartAsPNG(ChartAPI.getCAPM(stockSymbol, indexSymbol),800,500,null);
                        title = stockSymbol + " CAPM Regression Line";
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
            <h1><%=title%></h1>
            <img src="DisplayChart?filename=<%=chart%>" alt="API Exceeds Limit" width="600" height="400" />

            <br>
            <br>
            <form method="post" name="chart" action="chart" id="chart">
                <input type="submit" value="Back to Chart" name="backButton">
            </form>
        </div>
    </td>
</div>
<jsp:include page="footer.jspf"/>
