package controller;

import bean.MyConnection;
import dao.StaffDao;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteStaff extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String staffid = request.getParameter("id");
        
        StaffDao sd = new StaffDao(MyConnection.getConnection());
        
        if (sd.deleteStaff(staffid)) {
            request.setAttribute("status", "success");
            request.setAttribute("errorMsgs", "Successfully Deleted Staff Information");
            RequestDispatcher rd = request.getRequestDispatcher("dashboard-manager.jsp");
            rd.forward(request, response);
        } else {
            request.setAttribute("status", "danger");
            request.setAttribute("errorMsgs", "Failed to Deleted Staff Information");
            RequestDispatcher rd = request.getRequestDispatcher("dashboard-manager.jsp");
            rd.forward(request, response);
        }
    }

}
