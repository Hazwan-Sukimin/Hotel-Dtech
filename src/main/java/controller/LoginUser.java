
package controller;

import bean.Account;
import bean.MyConnection;
import dao.AccountDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class LoginUser extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            
        
            // get parameter
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            // Bean Object
            Account acc = new Account();
            acc.setUsername(username);
            acc.setPassword(password);

            // Dao
            AccountDao ad = new AccountDao(MyConnection.getConnection());

            // check null error
            List error = ad.isLogNull(username, password);
            if (!error.isEmpty()) {
                request.setAttribute("errorMsgs", error.toString().substring(1,error.toString().length()-1));
                RequestDispatcher rd = request.getRequestDispatcher("login-user.jsp");
                rd.forward(request, response);
                return;
            }

            HttpSession session = request.getSession();
            acc = ad.logAccount(username, password);

            if (acc != null) {
                session.setAttribute("account", acc);
                RequestDispatcher rd = request.getRequestDispatcher("dashboard-user.jsp");
                rd.forward(request, response);
            } else {
                request.setAttribute("errorMsgs", "Database Failed");
                RequestDispatcher rd = request.getRequestDispatcher("login-user.jsp");
                rd.forward(request, response);
            }
        } catch(Exception e){System.out.println(e);}
    }
}
