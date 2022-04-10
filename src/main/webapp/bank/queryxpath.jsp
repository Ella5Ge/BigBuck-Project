<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<jsp:include page="/header.jspf"/>
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
	<jsp:include page="membertoc.jspf"/>
    <td valign="top" colspan="3" class="bb">
		<%@page import="com.ibm.security.appscan.altoromutual.util.ServletUtil"%>
		<div class="fl" style="width: 99%;">
			<h1>Search News Articles</h1>
			<form id="QueryXpath" method="get" action="<%=request.getRequestURL()%>">
			  Search our news articles database
			  <br /><br />
				<input type="hidden" id=content" name="content" value="queryxpath.jsp"/>
				<input type="text" id="query" name="query" width=450 value="<%=(request.getParameter("query")==null)?"Enter title (e.g. Watchfire)":request.getParameter("query")%>"/>
				<input type="submit" width=75 id="Button1" value="Query">
			  <br /><br />
			<%
				if (request.getParameter("query") != null) {
				String[] results = ServletUtil.searchArticles(request.getParameter("query"), request.getSession().getServletContext().getRealPath("/pr/Docs.xml"));
				if (results == null)
					out.println("News title not found, try again");
				else {
					out.println("Found news title:<br/>");
					for(String result:results)
				out.println(result+"<br/>");
				}
			}
			%>
			
			</form>
		</div>    
    </td>	
</div>

<jsp:include page="/footer.jspf"/>  