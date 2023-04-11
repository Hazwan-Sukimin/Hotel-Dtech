package controller;

import bean.Account;
import bean.MyConnection;
import bean.Staff;
import dao.AccountDao;
import dao.StaffDao;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class LoginStaff extends HttpServlet {

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
            
        // make sure id not null
        if (request.getParameter("id").equals("")) {
            request.setAttribute("msg", "<b>ID</b> is null");
            RequestDispatcher rd = request.getRequestDispatcher("login-staff.jsp");
            rd.forward(request, response);
        }
        
        int id = Integer.parseInt(request.getParameter("id"));
        String password = request.getParameter("password");
        
        // Object Bean
        Staff st = new Staff();
        st.setId(id);
        st.setPassword(password);
        
        // DAO
        StaffDao sd = new StaffDao(MyConnection.getConnection());
        st = sd.logStaff(st);
        
        if ( st != null) {
            // goto dashboard
            session.setAttribute("staff", st);
            // go to manager dashboard
            if (st.getPosition().equals("Manager")) {
                RequestDispatcher rd = request.getRequestDispatcher("dashboard-manager.jsp");
                rd.forward(request, response);
            } else {
                // by default go to staff dashboard
                RequestDispatcher rd = request.getRequestDispatcher("dashboard-staff.jsp");
                rd.forward(request, response);
            }
            // if status is no
            if (st.getStatus().equals("Off")) {
                request.setAttribute("msg", "<b>Failed</b> your account is been off by manager");
                RequestDispatcher rd = request.getRequestDispatcher("login-staff.jsp");
                rd.forward(request, response);
            }
            
        } else {
            // login failed
            request.setAttribute("msg", "<b>Failed</b> to login");
            RequestDispatcher rd = request.getRequestDispatcher("login-staff.jsp");
            rd.forward(request, response);
        }
    }
}
