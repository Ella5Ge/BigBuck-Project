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
		font-size: 16px;
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

		<%@page import="java.util.Date"%>
		<%@page import="com.ibm.security.appscan.altoromutual.model.Transaction"%>
		<%@ page import="com.ibm.security.appscan.altoromutual.model.Trade" %>
		<%@ page import="com.ibm.security.appscan.altoromutual.util.DBUtil" %>

		<div class="fl" style="width: 99%;">

			<%
				com.ibm.security.appscan.altoromutual.model.User user = (com.ibm.security.appscan.altoromutual.model.User)request.getSession().getAttribute("user");
				String startString = request.getParameter("startTime");
				String endString = request.getParameter("endTime");

				String error = "";

				Trade[] trades = DBUtil.getTradeRecords(startString, endString, user.getAccounts(), -1);
			%>

			<h1>Transaction</h1>

			<div align="center">
				Please enter a date to view more transaction information.
				<br /><br />
			</div>
			<script type="text/javascript">
				function confirminput(myform) {

					if (myform.startDate.value != ""){
						var valid = false;
						var splitStrings = myform.startDate.value.split("-");
						if (splitStrings.length == 3) {
							var year = parseInt(splitStrings[0]);
							var month = parseInt((splitStrings[1].charAt(0)==0 && splitStrings[1].length == 2)?splitStrings[1].charAt(1):splitStrings[1]);
							var day = parseInt((splitStrings[2].charAt(0)==0 && splitStrings[2].length == 2)?splitStrings[2].charAt(1):splitStrings[2]);

							var validNums = !(isNaN(year) || isNaN(month) || isNaN(day));

							if (validNums)
								valid = validateDate(month, day, year);
						}

						if (!valid){
							alert ("'After' date of " + myform.startDate.value + " is not valid.");
							return false;
						}
					}

					if (myform.endDate.value != ""){
						var valid2 = false;
						var splitStrings2 = myform.endDate.value.split("-");
						if (splitStrings2.length == 3) {
							var year2 = parseInt(splitStrings2[0]);
							var month2 = parseInt((splitStrings2[1].charAt(0)==0 && splitStrings2[1].length == 2)?splitStrings2[1].charAt(1):splitStrings2[1]);
							var day2 = parseInt((splitStrings2[2].charAt(0)==0 && splitStrings2[2].length == 2)?splitStrings2[2].charAt(1):splitStrings2[2]);

							var validNums2 = !(isNaN(year2) || isNaN(month2) || isNaN(day2));

							if (validNums2)
								valid2 = validateDate(month2, day2, year2);
						}

						if (!valid2){
							alert ("'Before' date of " + myform.endDate.value + " is not valid.");
							return false;
						}
					}
					return true;
				}

				function validateDate(month, day, year){
					try {
						var thisDate = new Date();
						var wrongMonth = month<1 || month>12;
						var wrongDay = (day<1) || (day>31) || (day>30 && ((month==4)||(month==6)||(month==9)||(month==11))) || (day>29 && month==2 && (year%4==0) && (year%100!=0 || year%400==0)) || (day>28 && month==2 && ((year%4!=0) || (year%100==0 && year%400!=0)));
						var wrongYear = year < 1990 || year > parseInt(thisDate.getFullYear());

						var thisYear = parseInt(thisDate.getFullYear());
						var thisMonth = parseInt(thisDate.getMonth())+1;
						var thisDay = parseInt(thisDate.getDate());
						var wrongDate = year==thisYear && ((thisMonth<month) || (thisMonth==month && thisDay<(day-1)));

						if (wrongMonth ||wrongDay || wrongYear || wrongDate)
							return false;

					} catch (error){
						return false;
					}

					return true;
				}
			</script>

			<font style="bold" color="red"><%=error%></font>
			<form id="Form1" name="Form1" method="post" action="showTrades" onsubmit="return (confirminput(Form1));">
				<div align="center">
				<table border="0" style="padding-bottom:10px;">
					<tr>
						<td valign=top>After</td>
						<td><input id="startDate" name="startDate" type="text" value="<%=(request.getParameter("startDate")==null)?"":request.getParameter("startDate")%>"/><br /><span class="credit">yyyy-mm-dd</span></td>
						<td valign=top>Before</td>
						<td><input name="endDate" id="endDate" type="text" value="<%=(request.getParameter("endDate")==null)?"":request.getParameter("endDate") %>"/><br /><span class="credit">yyyy-mm-dd</span></td>
						<td valign=top><input type=submit value=Submit /></td>
					</tr>
				</table>

				<DIV ID='recent' STYLE='overflow: hidden; overflow-y: scroll; width:90%; height: 300px; padding:0px; margin: 0px' >
				<table cellspacing="0" cellpadding="3" rules="all" border="1" id="_ctl0__ctl0_Content_Main_MyTransactions" style="width:100%;border-collapse:collapse;">
					<tr style="color:White;background-color:#BFD7DA;font-weight:bold;">
						<td>Trade ID</td><td>Trade Time</td><td>Account ID</td><td>Action</td><td>Stock Symbol</td><td>Stock Name</td><td>Amount</td><td>Price Per Share</td>
					</tr>
					<% for (int i=0; i<trades.length; i++){
						//limit to 100 entries
						if (i==100)
							break;

						double dblPrice = trades[i].getPrice();
						String format = (dblPrice<1)?"$0.00":"$.00";
						String price = new DecimalFormat(format).format(dblPrice);
						String date = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(trades[i].getDate());
					%>

					<tr>
						<td><%=trades[i].getTradeId()%></td>
						<td><%=date%></td>
						<td><%=trades[i].getAccountId()%></td>
						<td><%=trades[i].getTradeType()%></td>
						<td><%=trades[i].getStockSymbol()%></td>
						<td><%=trades[i].getStockName()%></td>
						<td align="right"><%=trades[i].getAmount()%></td>
						<td align="right"><%=price%></td>
					</tr>
					<% } %>
					<tr>
						<!-- TODO PAGES: <td colspan="4"><span>1</span>&nbsp;<a href="javascript:__doPostBack('_ctl0$_ctl0$Content$Main$MyTransactions$_ctl54$_ctl1','')">2</a></td> -->
					</tr>
				</table></DIV>
				</div>
			</form>

		</div>

	</td>
</div>

<jsp:include page="/footer.jspf"/>
