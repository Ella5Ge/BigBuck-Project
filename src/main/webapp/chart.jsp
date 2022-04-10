<%--
  Created by IntelliJ IDEA.
  User: liwanting
  Date: 4/7/22
  Time: 8:51 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="header.jspf"/>

<div id="wrapper" style="width: 99%;">
    <jsp:include page="bank/membertoc.jspf"/>
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
            </form>
            </div>
        </div>
    </td>
</div>


<jsp:include page="footer.jspf"/>
