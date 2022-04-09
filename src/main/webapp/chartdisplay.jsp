<%--
  Created by IntelliJ IDEA.
  User: liwanting
  Date: 4/7/22
  Time: 8:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page import="com.ibm.security.appscan.altoromutual.api.ChartAPI"%>
<%@ page import="org.jfree.chart.servlet.ServletUtilities" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<jsp:include page="header.jspf"/>


<div id="wrapper" style="width: 99%;">
    <jsp:include page="/bank/membertoc.jspf"/>
    <td valign="top" colspan="3" class="bb">
        <div class="fl" style="width: 99%;">
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
                        title = stockSymbol + " Auto Correlation Scatter Chart";
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
            <form method="post" name="chart" action="chart" id="chart">
                <input type="submit" value="Back to Chart">
            </form>
        </div>
    </td>
</div>
<jsp:include page="footer.jspf"/>
