package controller;

import bean.Account;
import bean.MyConnection;
import bean.Reservation;
import dao.ReservationDao;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class AddReservation extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            
            String categoryid = request.getParameter("categoryid");
            String roomid = request.getParameter("roomid");
            String datestart = request.getParameter("datestart");
            String dateend = request.getParameter("dateend");
            int totalAdult = Integer.parseInt(request.getParameter("totaladult"));
            int totalChild = Integer.parseInt(request.getParameter("totalchild"));
            String fullname = request.getParameter("fullname");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String price = request.getParameter("price");


            HttpSession session = request.getSession();

            // get session id
            Account acc = (Account) session.getAttribute("account");
            response.setContentType("text/html;charset=UTF-8");

            int accid = acc.getId();

            // Bean Reservation
            Reservation r = new Reservation();
            r.setDateStart(datestart);
            r.setDateEnd(dateend);
            r.setTotalAdult(totalAdult);
            r.setTotalChild(totalChild);

            // get total day
            int totalDay = (int)r.countDay();

            r.setTotalDay(totalDay);
            r.setAccId(accid);
            r.setRoomId(Integer.parseInt(roomid));

            double totalPrice = totalDay * Integer.parseInt(price);
            r.setTotalPrice(totalPrice);

            
            // Dao
            ReservationDao rsd = new ReservationDao(MyConnection.getConnection());
            out.print(rsd.addReservation(r));
            if (rsd.addReservation(r)) {
                request.setAttribute("errorMsgs", totalDay);
                RequestDispatcher rd = request.getRequestDispatcher("booking-detail.jsp");
                rd.forward(request, response);
            } else {
                request.setAttribute("errorMsgs", "Failed to book your room");
                RequestDispatcher rd = request.getRequestDispatcher("register-reservation.jsp");
                rd.forward(request, response);
            }  
        } catch(Exception e){System.out.println(e);}
    }
}
