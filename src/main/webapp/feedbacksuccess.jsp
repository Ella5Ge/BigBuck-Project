<%@page import="com.ibm.security.appscan.altoromutual.model.Feedback"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

    <%@page import="com.ibm.security.appscan.altoromutual.util.ServletUtil" errorPage="notfound.jsp"%>
    <%@page import="org.apache.commons.lang.StringEscapeUtils" errorPage="notfound.jsp"%>


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

<div class="main" id="wrapper" style="width: 99%;">
    <td valign="top" colspan="3" class="bb">
    
    
		
		<div class="fl" style="width: 99%;">
		
		 <h1>Thank You</h1>
		 
		 <p>Thank you for your comments<%= (request.getAttribute("message_feedback")!=null)?", "+request.getAttribute("message_feedback"):"" %>.  They will be reviewed by our Customer Service staff and given the full attention that they deserve. 
		 <% String email = (String) request.getParameter("email_addr"); 
		 	boolean regExMatch = email!=null && email.matches(ServletUtil.EMAIL_REGEXP);
		 	if (email != null && email.trim().length() != 0 && regExMatch) {%> 
			 Our reply will be sent to your email: <%= ServletUtil.sanitzieHtmlWithRegex(email.toLowerCase())/*ServletUtil.sanitizeWeb(email.toLowerCase())*/%>
		<% } else {%>
			However, the email you gave is incorrect (<%=ServletUtil.sanitzieHtmlWithRegex(email.toLowerCase()) /*ServletUtil.sanitizeWeb(email.toLowerCase())*/%>) and you will not receive a response.
		<% }%>
		</p>
		<% if (ServletUtil.isAppPropertyTrue("enableFeedbackRetention")){%>
		<br><br>
		<h3>Details of your feedback submission</h3>
		<p>
		<% 
		long feedbackId = -1;
		Object feedbackIdObj = request.getAttribute("feedback_id");
		if (feedbackIdObj != null && feedbackIdObj instanceof String) {
//			try {
				feedbackId = Long.parseLong((String)feedbackIdObj);
//			} (catch NumberFormatException e){
//				// do nothing
//			}
		}
		
		Feedback feedbackDetails = ServletUtil.getFeedback(feedbackId);
		
		if (feedbackDetails != null){
			
		%>
			<table border=0>
			  <tr>
			    <td align=right>Your Name:</td>
			    <td valign=top><%=feedbackDetails.getName() %></td>
			  </tr>
			  <tr>
			    <td align=right>Your Email Address:</td>
			    <td valign=top><%=feedbackDetails.getEmail() %></td>
			  </tr>
			  <tr>
			    <td align=right>Subject:</td>
			    <td valign=top><%=feedbackDetails.getSubject() %></td>
			  </tr>
			  <tr>
			    <td align=right valign=top>Question/Comment:</td>
			    <td><%=feedbackDetails.getMessage()%></td>
			  </tr>
			</table>
		<% } %>
		</p>
		<% } %>
		</div>
    </td>	
</div>

<jsp:include page="footer.jspf"/>