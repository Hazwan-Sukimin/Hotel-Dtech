package controller;

import bean.Account;
import bean.MyConnection;
import dao.AccountDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AddUser extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get Parameter
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String phone = request.getParameter("phone");
        String password1 = request.getParameter("password1");
        String password2 = request.getParameter("password2");
        String submit = request.getParameter("submit");
        
        String citizen = request.getParameter("citizen");
        String ic = request.getParameter("ic");
        
        // DAO Method
        AccountDao ad = new AccountDao(MyConnection.getConnection());
        boolean checkPassword = ad.checkPassword(password1, password2);
        boolean checkPhone = ad.checkPhone(phone);
        
        // check if input field is null
        List error1 = ad.isNull(fullname, email, username, phone, password1, password2);
        if (!error1.isEmpty()) {
            request.setAttribute("errorMsgs", error1.toString().substring(1,error1.toString().length()-1));
            RequestDispatcher rd = request.getRequestDispatcher("register-user.jsp");
            rd.forward(request, response);
            return;
        }
        
        // check ic format
        if (ad.checkIc(ic)) {
            request.setAttribute("errorMsgs", "<b>Ic</b> number is Wrong Format");
            RequestDispatcher rd = request.getRequestDispatcher("register-user.jsp");
            rd.forward(request, response);
            return;
        }
        
        // check duplication | email,username,ic
        List error2 = ad.isDuplicate(email, username, ic);
        if (!error2.isEmpty()) {
            request.setAttribute("errorMsgs", error2.toString().substring(1,error2.toString().length()-1));
            RequestDispatcher rd = request.getRequestDispatcher("register-user.jsp");
            rd.forward(request, response);
            return;
        }
        
        // add account to database
        Account acc = new Account();
        acc.setFullname(fullname);
        acc.setEmail(email);
        acc.setUsername(username);
        acc.setPhone(phone);
        acc.setPassword(password1);
        acc.setIc(ic);
        
//        request.setAttribute("account", ad.addAccount(acc));
//        RequestDispatcher rd = request.getRequestDispatcher("register-user.jsp");
//        rd.forward(request, response);

        if (ad.addAccount(acc)) {
            // success add account to the database
            request.setAttribute("link", "login-user.jsp");
            request.setAttribute("account", acc);
            request.setAttribute("userSubmit", submit);
            RequestDispatcher rd = request.getRequestDispatcher("success-page.jsp");
            rd.forward(request, response);
        }else {
            // fail add account to the database
            request.setAttribute("link", "register-user.jsp");
            RequestDispatcher rd = request.getRequestDispatcher("error-page.jsp");
            rd.forward(request, response);
        }

    }
    
    
    
}