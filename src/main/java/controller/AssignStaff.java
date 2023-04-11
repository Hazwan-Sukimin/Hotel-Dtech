package controller;

import bean.MyConnection;
import dao.ReservationDao;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AssignStaff extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // get parameter
        String staffid = request.getParameter("staffid");
        String reservationid = request.getParameter("reservationid");
        
        if (staffid == null) {
            request.setAttribute("errorMsgs", "Please choose at least 1 staff");
            RequestDispatcher rd = request.getRequestDispatcher("assign-staff.jsp?reservationid="+reservationid);
            rd.forward(request, response);
        }
        
        ReservationDao rsd = new ReservationDao(MyConnection.getConnection());
        
        if (rsd.addStaff(staffid, reservationid)) {
            request.setAttribute("color", "success");
            request.setAttribute("errorMsgs", "Successfully assign staff");
            RequestDispatcher rd = request.getRequestDispatcher("dashboard-manager.jsp");
            rd.forward(request, response);
        } else {
            request.setAttribute("color", "danger");
            request.setAttribute("errorMsgs", "Failed to assign staff");
            RequestDispatcher rd = request.getRequestDispatcher("assign-staff.jsp?reservationid="+reservationid);
            rd.forward(request, response);
        }
        
        
    }

}
