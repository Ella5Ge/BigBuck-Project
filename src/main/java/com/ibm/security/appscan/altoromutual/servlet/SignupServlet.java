package com.ibm.security.appscan.altoromutual.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ibm.security.appscan.altoromutual.api.RegisterDao;
import com.ibm.security.appscan.altoromutual.model.User;

public class SignupServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String username = request.getParameter("username");
        String passwd = request.getParameter("passwd");
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");

        if(username==null) {
            username = "";
        }
        passwd = (passwd==null)? "" :passwd;
        firstname = (firstname==null)? "" :firstname;
        lastname = (lastname==null)? "" :lastname;

        // 设置用户数据信息
        User user = new User();
        user.setUsername(username);
        user.setFirstName(firstname);
        user.setLastName(lastname);
        user.setPasswd(passwd);

        int status = 0;
        try{
            status = RegisterDao.save(user);
            if (status > 0) {
                out.print("The registered user information is successful...");
            }else {
                out.print("Failed to register user information...");
            }
        }catch (Exception e2) {
            System.out.println(e2);
        }
        out.close();
    }
}
