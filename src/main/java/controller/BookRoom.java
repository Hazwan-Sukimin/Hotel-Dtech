package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class BookRoom extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoryid = request.getParameter("categoryid");
        String roomid = request.getParameter("roomid");
        
        if (roomid == null) {
            request.setAttribute("errorMsgs", "No room is selected !");
            RequestDispatcher rd = request.getRequestDispatcher("dasboard-user.jsp");
            rd.forward(request, response);
            return;
        }
        
        request.setAttribute("categoryid", categoryid);
        request.setAttribute("roomid", roomid);
        
        RequestDispatcher rd = request.getRequestDispatcher("register-reservation.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

}
