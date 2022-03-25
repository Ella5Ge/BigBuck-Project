package com.ibm.security.appscan.altoromutual.servlet;

import com.ibm.security.appscan.altoromutual.util.OperationsUtil;
import com.ibm.security.appscan.altoromutual.util.ServletUtil;

import javax.persistence.criteria.CriteriaBuilder;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/TradeServlet")

public class TradeServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        if(!ServletUtil.isLoggedin(request)){
            response.sendRedirect("login.jsp");
            return ;
        }

        String message = null;
        try {
            String accountIdString = request.getParameter("chooseAccount");
            String tradeTypeString = request.getParameter("tradeType");
            String stockSymbol = request.getParameter("stockSymbol");
            int tradeAmount = Integer.parseInt(request.getParameter("tradeAmount"));
            double tradePrice = 10.25;

            if (tradeTypeString.equals("sell")) {
                tradeAmount = -tradeAmount;
            }

            // calculate volume

            // calculate balance in cash account

            message = OperationsUtil.doServletTrade(request, accountIdString, tradeAmount, tradePrice, stockSymbol);

            if(message != null) {
                throw new Exception("Failed to trade!");
            }
        } catch (Exception e) {
            request.setAttribute("loginError", e);
            response.sendRedirect("stocks.jsp");
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("stocks.jsp");
        request.setAttribute("message", message);
        dispatcher.forward(request, response);
    }
}
