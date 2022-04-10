<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

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
<div class="main" id="wrapper" style="width: 99%;">
    <td valign="top" colspan="3" class="bb">
		<%@page import="com.ibm.security.appscan.altoromutual.model.User"%>

		<%User user = null;
		try {
		 user = (User)request.getSession().getAttribute("user"); 
		} catch (Exception e) { /* do nothing */ }%>
		
		<div class="fl" style="width: 99%;">
		<div align="center">
			<h1>Feedback</h1>
		</div>
		<div class="div_text">
		
		<p>Our Frequently Asked Questions area will help you with many of your inquiries.<br />
		If you can't find your question, return to this page and use the e-mail form below.</p>
		
		<p><b>IMPORTANT!</b> This feedback facility is not secure.  Please do not send any <br />
		account information in a message sent from here.</p>
		
		<form name="cmt" method="post" action="sendFeedback">
		
		<!--- Dave- Hard code this into the final script - Possible security problem.
		  Re-generated every Tuesday and old files are saved to .bak format at L:\backup\website\oldfiles    --->
		<input type="hidden" name="cfile" value="comments.txt">
		
		<table border=0>
		  <tr>
		    <td align=right>To:</td>
		    <td valign=top><b>Online Banking</b> </td>
		  </tr>
		  <tr>
		    <td align=right>Your Name:</td>
		    <td valign=top><input name="name" size=25 type=text value = "<%= ((user != null && user.getFirstName() != null)?user.getFirstName()+" ":"") + ((user != null && user.getLastName() != null)?user.getLastName():"") %>"></td>
		  </tr>
		  <tr>
		    <td align=right>Your Email Address:</td>
		    <td valign=top><input name="email_addr" type=text size=25></td>
		  </tr>
		  <tr>
		    <td align=right>Subject:</td>
		    <td valign=top><input name="subject" size=25></td>
		  </tr>
		  <tr>
		    <td align=right valign=top>Question/Comment:</td>
		    <td><textarea cols=65 name="comments" rows=8 wrap=PHYSICAL align="top"></textarea></td>
		  </tr>
		  <tr>
		    <td>&nbsp;</td>
		    <td><input type=submit value=" Submit " name="submit">&nbsp;<input type=reset value=" Clear Form " name="reset"></td>
		  </tr>
		</table>
		</form>
		
		<br /><br />
		
		<img id="bug" src="" height=1 width=1 />
		</div>
		</div>
    </td>
	
</div>

<jsp:include page="footer.jspf"/>