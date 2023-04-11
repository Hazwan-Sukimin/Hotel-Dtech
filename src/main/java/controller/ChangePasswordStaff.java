package controller;

import bean.Account;
import bean.MyConnection;
import bean.Staff;
import dao.StaffDao;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ChangePasswordStaff extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Get Parameter
        String cpassword = request.getParameter("cpassword");
        String password1 = request.getParameter("password1");
        String password2 = request.getParameter("password2");
        int staffid = Integer.parseInt(request.getParameter("staffid"));
        
        //Dao
        StaffDao sd = new StaffDao(MyConnection.getConnection());
        
        // check current password
        Staff acc = (Staff)session.getAttribute("staff");
        
        // match current password with user given | error checking
        if (!cpassword.equals(acc.getPassword())) {
            request.setAttribute("color", "danger");
            request.setAttribute("errorMsgs", "Wrong Current Password");
            RequestDispatcher rd = request.getRequestDispatcher("change-password-staff.jsp");
            rd.forward(request, response);
            return;
        }
        
        //  Current is same with new | error checking
        if (cpassword.equals(password1)) {
            request.setAttribute("color", "danger");
            request.setAttribute("errorMsgs", "You Are Trying to change same password");
            RequestDispatcher rd = request.getRequestDispatcher("change-password-staff.jsp");
            rd.forward(request, response);
            return;
        }
        
        if (password1.equals(password2)) {
            if (sd.changePassword(password1, staffid)) {
                request.setAttribute("errorMsgs", "Successfully Changed Password");
                request.setAttribute("color", "success");
                RequestDispatcher rd = request.getRequestDispatcher("change-password-staff.jsp");
                rd.forward(request, response);
            } else {
                request.setAttribute("color", "danger");
                request.setAttribute("errorMsgs", "Failed to Change Password");
                RequestDispatcher rd = request.getRequestDispatcher("change-password-staff.jsp");
                rd.forward(request, response);
            }
            
        } else {
                request.setAttribute("errorMsgs", "Password Not Same");
                RequestDispatcher rd = request.getRequestDispatcher("change-password-staff.jsp");
                rd.forward(request, response);
        }
    }

}
