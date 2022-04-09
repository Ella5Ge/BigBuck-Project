<%--
  Created by IntelliJ IDEA.
  User: liwanting
  Date: 3/22/22
  Time: 5:29 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<jsp:include page="/header.jspf"/>

<div id="wrapper" style="width: 99%;">
    <td valign="top" colspan="3" class="bb">
        <div class="fl" style="width: 99%;">

            <h1>Create a New User Account</h1>
            <p><span id="_ctl0__ctl0_Content_Main_message" style="color:#FF0066;font-size:12pt;font-weight:bold;">
                <%
                    java.lang.String error = (String)request.getSession(true).getAttribute("loginError");
                    if (error != null && error.trim().length() > 0){
                        request.getSession().removeAttribute("loginError");
                        out.print(error);
                    }
                %>
            </span></p>

            <form action="SignupServlet" method="post" name="signup" id="signup" onsubmit="return (confirminput(signup));">
                <table>
                    <tr>
                        <td>
                            First Name:
                        </td>
                        <td>
                            <input type="text" id="new_first" name="new_first" value="" style="width: 150px;">
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Last Name:
                        </td>
                        <td>
                            <input type="text" id="new_last" name="new_last" style="width: 150px;">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Username:
                        </td>
                        <td>
                            <input type="text" id="new_uid" name="new_uid" style="width: 150px;">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Password:
                        </td>
                        <td>
                            <input type="password" id="new_passw" name="new_passw" style="width: 150px;">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Re-confirmed Password:
                        </td>
                        <td>
                            <input type="password" id="new_passw2" name="new_passw2" style="width: 150px;">
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <input type="submit" name="btnSubmit" value="Sign up">
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <script type="text/javascript">
            function confirminput(myform) {
                if (myform.new_first.value.length && myform.new_last.value.length
                    && myform.new_uid.value.length && myform.new_passw.value.length
                    && myform.new_passw2.value.length && myform.new_passw.value == myform.new_passw2.value) {
                    return (true);
                } else if (!(myform.new_first.value.length)) {
                    myform.reset();
                    myform.new_first.focus();
                    alert ("You must enter a valid first name");
                    return (false);
                } else if (!(myform.new_last.value.length)) {
                    myform.new_last.focus();
                    alert ("You must enter a valid last name");
                    return (false);
                } else if (!(myform.new_uid.value.length)) {
                    myform.new_uid.focus();
                    alert("You must enter a valid username");
                    return (false);
                } else if (!(myform.new_passw.value.length)) {
                    myform.new_passw.focus();
                    alert("You must enter a valid password");
                    return (false);
                } else if (!(myform.new_passw2.value.length)) {
                    myform.new_passw2.focus();
                    alert("You must re-confirm the password");
                    return (false);
                } else if (myform.new_passw.value != myform.new_passw2.value){
                    myform.new_passw2.focus();
                    alert ("Your passwords do not match. Please try again.");
                    return (false);
                }
            }
        </script>
    </td>
</div>

<jsp:include page="/footer.jspf"/>

