package controller;

import dao.ReservationDao;
import bean.MyConnection;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteReservation extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String reservationid = request.getParameter("id");
        
        ReservationDao rsd = new ReservationDao(MyConnection.getConnection());
        
        if (rsd.deleteReservation(reservationid)) {
            request.setAttribute("status", "success");
            request.setAttribute("errorMsgs", "Successfully Deleted Reservation Information");
            RequestDispatcher rd = request.getRequestDispatcher("dashboard-manager.jsp");
            rd.forward(request, response);
        }
        
        
    }
}
