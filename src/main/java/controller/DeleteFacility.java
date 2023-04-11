package controller;

import bean.MyConnection;
import dao.FacilityDao;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteFacility extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        
        FacilityDao fd = new FacilityDao(MyConnection.getConnection());
        
        if (fd.deleteFacility(id)) {
            request.setAttribute("status", "success");
            request.setAttribute("errorMsgs", "Successfully Deleted Facility Information");
            RequestDispatcher rd = request.getRequestDispatcher("dashboard-manager.jsp");
            rd.forward(request, response);
        } else {
            request.setAttribute("status", "danger");
            request.setAttribute("errorMsgs", "Failed to Deleted Facility Information");
            RequestDispatcher rd = request.getRequestDispatcher("dashboard-manager.jsp");
            rd.forward(request, response);
        }
        
    }

}
