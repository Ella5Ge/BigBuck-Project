package com.ibm.security.appscan.altoromutual.servlet;

import com.ibm.security.appscan.altoromutual.util.DBUtil;
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
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doPost(req, resp);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        if(!ServletUtil.isLoggedin(request)){
            response.sendRedirect("login.jsp");
            return ;
        }

        String accountIdString = request.getParameter("chooseAccount");
        String tradeTypeString = request.getParameter("tradeType");
        String stockSymbol = request.getParameter("stockSymbol");  // 还没检验stock symbol是否存在
        int tradeAmount = Integer.parseInt(request.getParameter("tradeAmount"));
        double tradePrice = 10.25;

        // calculate volume

        // calculate balance in cash account

        String message = DBUtil.tradeStock(accountIdString, tradeTypeString, tradeAmount, tradePrice, stockSymbol);

        if (message == null) {
            message = "Trade Successfully";
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("stocks.jsp");
        request.setAttribute("message", message);
        dispatcher.forward(request, response);
    }
}
