<%@page import="java.util.ArrayList"%>
<%@page import="com.sun.xml.internal.bind.v2.runtime.unmarshaller.XsiNilLoader.Array"%>
<%@page import="com.ibm.security.appscan.altoromutual.model.Feedback"%>
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
		height: 400px;
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
		<%@page import="com.ibm.security.appscan.altoromutual.util.ServletUtil"%>
		
		<% if (ServletUtil.isAppPropertyTrue("enableFeedbackRetention")){%>
		<br><br>
		<h1>Customer feedback submissions</h1>
		<p>
		<% 
		
		ArrayList<Feedback> feedbackDetails = ServletUtil.getAllFeedback();
		
		for (int i=0; i<feedbackDetails.size();i++){
			
		%>
			<table border=0>
			  <tr>
			    <td align=right>Feedback ID:</td>
			    <td valign=top><%=feedbackDetails.get(i).getFeedbackID() %></td>
			  </tr>
			  <tr>
			    <td align=right>Customer Name:</td>
			    <td valign=top><%=feedbackDetails.get(i).getName() %></td>
			  </tr>
			  <tr>
			    <td align=right>Customer Email Address:</td>
			    <td valign=top><%=feedbackDetails.get(i).getEmail() %></td>
			  </tr>
			  <tr>
			    <td align=right>Customer Subject:</td>
			    <td valign=top><%=feedbackDetails.get(i).getSubject() %></td>
			  </tr>
			  <tr>
			    <td align=right valign=top>Customer Question/Comment:</td>
			    <td><%=feedbackDetails.get(i).getMessage()%></td>
			  </tr>
			</table>
			<hr>
		<% } %>
		</p>
		<% } %>
		</div>
    </td>
</div>
</body>
<jsp:include page="/footer.jspf"/>		