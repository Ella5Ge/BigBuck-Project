<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="header.jspf"/>
<jsp:include page="bank/membertoc.jspf"/>
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
        <div class="fl" style="width: 99%;">
            <script type="text/javascript">
                function confirminput(myform) {
                    if(!myform.symbol.value.length) {
                        alert("You must enter a stock symbol.");
                        return false;
                    }
                    var stock=document.getElementById("symbol").value;
                    var type=document.getElementById("graphType").value;

                    if ((type === "chart5" || type === "chart6" || type === "chart7") && stock === "SPY"){
                        alert("Please enter a valid stock symbol.");
                        return false;
                    }
                    return true;
                }
            </script>
            <div class="fl" style="width: 99%;">
            <form method="post" name="chart" action="chartdisplay.jsp" id="chart" onsubmit="return (confirminput(chart));">
                <h1>Advanced Charting</h1>
                <div class="div_text">
                    <dr />
                    <dr>Please enter stock symbol and choose one of charts.
                        <dr /><dr />
                <table cellSpacing="0" cellPadding="1" width="100%" border="0">
                    <tr>
                        <td><strong>Enter Stock Symbol:</strong></td>
                        <td><input type="text" id="symbol" name="symbol" style="width: 150px;"></td>
                    </tr>
                    <tr>
                        <td><strong>Choose Graph Type:</strong></td>
                        <td>
                            <select size="1" id="graphType" name="graphType">
                                <option value="chart1">Stock Price Line Chart</option>
                                <option value="chart2">Stock Return Scatter Chart</option>
                                <option value="chart3">Stock AR(1) Scatter Chart</option>
                                <option value="chart4">Stock Return Histogram</option>
                                <option value="chart5">Stock vs SPY Index Cumulative Return</option>
                                <option value="chart6">Stock vs SPY Index Daily Return</option>
                                <option value="chart7">Stock CAPM Regression Line</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center"><input type="submit" value="Submit" name="submit"></td>
                    </tr>
                </table>
                </div>
            </form>

            <div class="div_text">
                <br />
                <h2>What do you need charts?</h2>
                Don’t just buy a stock bases on advice. Some people may make money buying a stock because of something like cheap valuation but if you have no clue on how to read financial statements and understand the industry that the stock is in then you will probably lose money.
                <br>And the best way to understand stock market and evaluate a stock is by looking at a stock chart.
                <br />
                <h2>What kind of charts we provides?</h2>
                Stock Price Plot
                <br>Stock Return Plot
                <br>Stock AR(1) Scatter Plot
                <br>Stock Return Histogram
                <br>Stock Price versus SPY Index Price Plot
                <br>Stock Return versus SPY Index Return Plot
                <br>The Scatter Plot of Stock Return versus Index Return
            </div>
            </div>
        </div>
    </td>
</div>

<jsp:include page="footer.jspf"/>
