<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<jsp:include page="header.jspf"/>

<div id="wrapper" style="width: 99%;">
    <jsp:include page="/toc.jspf"/>
    <td valign="top" colspan="3" class="bb">
        <div class="fl" style="width: 99%;">

            <h1>Online Banking Signup</h1>

            <form action="admin/addUser" method="post" name="signup" id="signup" onsubmit="return (confirminput(signup));">
                <table>
                    <tr>
                        <td>Username:</td>
                        <td><input type="text" id="username" name="username" style="width: 150px;"></td>
                    </tr>
                    <tr>
                        <td>Lastname:</td>
                        <td><input type="text" id="lastname" name="lastname" style="width: 150px;"></td>
                    </tr>
                    <tr>
                        <td>Firstname:</td>
                        <td><input type="text" id="firstname" name="firstname" style="width: 150px;"></td>
                    </tr>
                    <tr>
                        <td>Password:</td>
                        <td><input type="password" id="password1" name="password1" style="width: 150px;"></td>
                    </tr>

                    <tr>
                        <td>Rewrite Password:</td>
                        <td><input type="password" id="password2" name="password2" style="width: 150px;"></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><input type="submit" name="btnSubmit" value="Signup"></tr>
                    </tr>
                </table>
            </form>
        </div>
        <script type="text/javascript">
            function confirminput(myform) {
                if (myform.username.value.length && myform.lastname.value.length && myform.firstname.value.length && myform.password1.value.length) {
                    return (true);
                } else if (!(myform.username.value.length)) {
                    myform.reset();
                    myform.uid.focus();
                    alert ("You must enter a valid username");
                    return (false);
                } else if (!(myform.lastname.value.length)) {
                    myform.lastname.focus();
                    alert ("You must enter a valid lastname");
                    return (false);
                } else if (!(myform.firstname.value.length)) {
                    myform.firstname.focus();
                    alert("You must enter a valid firstname");
                    return (false);
                } else {
                    myform.password1.focus();
                    alert ("You must enter a valid password");
                    return (false);
                }
            }
            function confirminput(myform) {
                if (myform.password1.value != myform.password2.value) {
                    alert ("You must enter the same password");
                    return (false);
                }
            }
        </script>
    </td>
</div>


<jsp:include page="footer.jspf"/>