package controller;

import bean.Reservation;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CheckAvailability extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // get parameter
        String dateStart = request.getParameter("datestart");
        String dateEnd = request.getParameter("dateend");
        
        //check null
        if (dateStart.equals("") || dateEnd.equals("")) {
            request.setAttribute("errorMsgs", "<b>Null</b> Please not leave Start Date and End Date Null");
            RequestDispatcher rd = request.getRequestDispatcher("register-reservation.jsp");
            rd.forward(request, response);
            return;
        }
        
        // check date logic
        try {
            Date date1 = new SimpleDateFormat("yyyy-MM-dd").parse(dateStart);
            Date date2 = new SimpleDateFormat("yyyy-MM-dd").parse(dateEnd);
            
            if (date2.compareTo(date1) == -1) {
                request.setAttribute("errorMsgs", "<b>Start Date</b> is higher than <b>End Date</b>");
                RequestDispatcher rd = request.getRequestDispatcher("register-reservation.jsp");
                rd.forward(request, response);
                return;
            }
            if (date2.compareTo(date1) == 0) {
                request.setAttribute("errorMsgs", "<b>Date</b> for End cannot same as Start");
                RequestDispatcher rd = request.getRequestDispatcher("register-reservation.jsp");
                rd.forward(request, response);
                return;
            }
        } catch (ParseException ex) { }
        
        
        
        request.setAttribute("view", "1");
        RequestDispatcher rd = request.getRequestDispatcher("register-reservation.jsp");
        rd.forward(request, response);
            
            
    }

}
