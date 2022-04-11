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
		height: 300px;
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
		
		<%
			String content = request.getParameter("content");
			if (content != null && !content.equalsIgnoreCase("customize.jsp")){
				if (content.startsWith("http://") || content.startsWith("https://")){
					response.sendRedirect(content);
				}
			}
		%>
		
		<h1>Customize Site Language</h1>

			<div class="div_text">
		<form method="post">
		  <p>
		  Current Language: <%=(request.getParameter("lang")==null)?"":request.getParameter("lang")%>
		  </p>
		
		  <p>
		  You can change the language setting by choosing:
		  </p>
		  <p>
			  <br><font color="#00008b"><a id="HyperLink1" href="./customize.jsp?content=customize.jsp&lang=international">International</a></font>
			  <br><font color="#00008b"><a id="HyperLink2" href="./customize.jsp?content=customize.jsp&lang=english">English</a></font>
		  </p>
		</form>
			</div>
		</div>
    </td>	
</div>

<jsp:include page="/footer.jspf"/>  