package com.ibm.security.appscan.altoromutual.servlet;

import com.ibm.security.appscan.altoromutual.util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/SignupServlet")

public class SignupServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String message = null;
        String username = null;

        try {
            String firstName = request.getParameter("new_first");
            String lastName = request.getParameter("new_last");
            username = request.getParameter("new_uid");
            String passwd = request.getParameter("new_passw");
            String role = request.getParameter("new_role");

            String error = DBUtil.addUser(username, passwd, firstName, lastName, role);
            if (error != null) {
                message = "An error has occurred. Please try again later";
                throw new Exception(message);
            }

            String error2 = DBUtil.addAccount(username, "cash");
            if (error2 != null) {
                message = "An error has occurred. Please try again later";
                throw new Exception(message);
            }

            message = "Successful Sign up!";
        } catch (Exception e2) {
            request.getSession(true).setAttribute("loginError", e2.getLocalizedMessage());
            response.sendRedirect("signup.jsp");
            return;
        }
        request.getSession(true).setAttribute("loginError", message);
        response.sendRedirect("login.jsp");
    }
}
