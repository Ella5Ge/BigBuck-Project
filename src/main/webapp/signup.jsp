<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <title>BigBucks Signup Page</title>
</head>

<body style="background-color: #2F4F4F"></body>>
<style>
    body {
        background-color: gainsboro;
        font-size: 16px;
    }

    .div_top_1 {
        height: 60px;
        width: 100%;
    }

    .div_top_2 {
        height: 50px;
        width: 100%;
    }

    .main {
        width: 417.683px;
        height: 560px;
        background-color: #FFFFFF;
        margin: 0 auto;

    }

    .signup {

        width: 360px;
        height: 480px;
        background-color: #FFFFFF;
        margin: 0 auto
    }

    .div_signup_head {
        height: 36px;
        background-color: #FFFFFF;
        margin: 0 auto;
        line-height: 36px;
        text-align: center;
        color: #666;
        border-bottom: 3px solid #21b351;
        font-size: 18px;
        line-height: 24px;
        margin-bottom: -1px;
        font-family: "PingFang SC", "Microsoft yahei", "Helvetica Neue", "Helvetica", "Arial", sans-serif;
    }

    .div_input_account {
        width: 360px;
        height: 40px;

    }
    .div_input_firstname {
        width: 360px;
        height: 40px;

    }
    .div_input_lastname {
        width: 360px;
        height: 40px;

    }
    .div_input_pwd {
        width: 360px;
        height: 24px;

    }
    .div_input_repwd {
        width: 360px;
        height: 24px;

    }
    .input_account, .input_firstname, .input_lastname, .input_pwd, .input_repwd {
        width: 360px;
        height: 40px;
        border: none;
        border-bottom: #ddd 1px solid;
        border-radius: 0;
        outline: 0;
        font: inherit;
        font-size: .875rem;
    }
    .div_button_signup {
        width: 360px;
        height: 40px;
        margin-top: 36px;
        text-align: center;

    }
    .button_signup {
        width: 180px;
        height: 40px;
        background: #1fa54a;
        font-size: 16px;
        cursor: pointer;
        color: white;
        border: none;
        border-radius: 2px;
        outline: 0;

    }
    .div_empty {
        width: 360px;
        height: 24px;

    }

</style>
<body>
<div class="div_top_1">


</div>
<div align="center">
    <img src="images/BigBucks.png" alt="image" width="437" height="98">
    <br />
</div>
<div class="main">
    <div class="signup">
        <div class="div_top_2">

        </div>
        <div align="center" class="div_signup_head">
            Create New User Account
        </div>

        <div class="div_empty">
        </div>

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
            <div class="div_input_account">
                <input class="input_account" type="text" id="new_uid" name="new_uid" placeholder="Username" value="${userName }"/>
            </div>
            <div class="div_empty">
            </div>

            <div class="div_input_firstname">
                <input class="input_firstname" type="text" id="new_first" name="new_first" placeholder="Firstname" value="${firstName }"/>
            </div>
            <div class="div_empty">
            </div>

            <div class="div_input_lastname">
                <input class="input_lastname" type="text" id="new_last" name="new_last" placeholder="Lastname" value="${lastName }"/>
            </div>
            <div class="div_empty">
            </div>

            <div class="div_input_pwd">
                <input class="input_pwd" type="password" id="new_passw" name="new_passw" placeholder="Password" value="${pwd }"/>
            </div>
            <div class="div_empty">
            </div>

            <div class="div_input_repwd">
                <input class="input_repwd" type="password" id="new_passw2" name="new_passw2" placeholder="Re-enter Password" value="${pwd }"/>
            </div>
            <div class="div_empty">
            </div>

            <div class="div_button_signup">
                <input class="button_signup" type="submit" value="Submit"/>
            </div>
            <br />
            <div align="center">
                Already hava an account? Please <a href="login.jsp"> log in</a>.
            </div>
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
            } else if (myform.new_passw.value != myform.new_passw2.value) {
                alert("Your passwords do not match. Please try again.");
                return (false);
            }
        }
    </script>

</div>
</body>
</html>
<jsp:include page="/footer.jspf"/>
