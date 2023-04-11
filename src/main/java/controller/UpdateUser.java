package controller;

import bean.Account;
import bean.MyConnection;
import dao.AccountDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UpdateUser extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        // get parameter
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String phone = request.getParameter("phone");
        
        String citizen = request.getParameter("citizen");
        if (citizen == null || citizen == "") {
            citizen = "no";
        } else {
            citizen = "yes";
        }
        
        String ic = request.getParameter("ic");
        
        // Check Number Format
        int age = 0;
        if (request.getParameter("age") == null || request.getParameter("age").equals("")) {
            age = 0;
        } else {
            age = Integer.parseInt(request.getParameter("age"));
        }
        
        String gender = request.getParameter("gender");
        
        // Bean
        Account acc = new Account();
        acc.setFullname(fullname);
        acc.setUsername(username);
        acc.setEmail(email);
        acc.setPhone(phone);
        acc.setIc(ic);
        acc.setCitizen(citizen);
        acc.setGender(gender);
        acc.setAge(age);
        
        // citizen checkbox
        if (acc.getCitizenC().equals("yes") && (acc.getIc()==null || acc.getIc().equals(""))) {
            request.setAttribute("errorMsgs", "<b>Ic</b> is null");
            RequestDispatcher rd = request.getRequestDispatcher("user-info.jsp");
            rd.forward(request, response);
            return;
        } else {
            acc.setIc(ic);
        }
        
        if (acc.getCitizenC().equals("no") && (acc.getIc() == null || acc.getIc().equals(""))) {
            
        } else {
            request.setAttribute("errorMsgs", "<b>Citizen</b> checkbox is not tick while IC is not null");
            RequestDispatcher rd = request.getRequestDispatcher("user-info.jsp");
            rd.forward(request, response);
            return;
        }
        
        
        
        // if ic not null make sure citizen always yes
        if (acc.getIc() == null || acc.getIc().equals("")) {
            acc.setCitizen("no");
        } else {
            acc.setCitizen("yes");
        }
        
        // Dao
        AccountDao ad = new AccountDao(MyConnection.getConnection());
        
        // Check Null Value
        List error1 = ad.isNull(acc);
        if (!error1.isEmpty()) {
            request.setAttribute("errorMsgs", error1.toString().substring(1,error1.toString().length()-1));
            RequestDispatcher rd = request.getRequestDispatcher("user-info.jsp");
            rd.forward(request, response);
            return;
        }
        
        // check ic formatting 
        if (ad.checkIc(ic)) {
            request.setAttribute("errorMsgs", "<b>IC</b> Format is invalid");
            RequestDispatcher rd = request.getRequestDispatcher("user-info.jsp");
            rd.forward(request, response);
            return;
        }
        
        /*
            Tinggal Buat Update sahaja
        */
        
        
//        session.setAttribute("", age);
        request.setAttribute("accUpdate", acc);
        RequestDispatcher rd = request.getRequestDispatcher("user-info.jsp");
        rd.forward(request, response);
    }

}
