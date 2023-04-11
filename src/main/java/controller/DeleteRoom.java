package controller;

import bean.MyConnection;
import dao.RoomDao;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteRoom extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String roomid = request.getParameter("id");
        
        RoomDao rmd = new RoomDao(MyConnection.getConnection());
        
        if (rmd.deleteRoom(roomid)) {
            request.setAttribute("status", "success");
            request.setAttribute("errorMsgs", "Successfully Deleted Room Information");
            RequestDispatcher rd = request.getRequestDispatcher("dashboard-manager.jsp");
            rd.forward(request, response);
        } else {
            request.setAttribute("status", "danger");
            request.setAttribute("errorMsgs", "Failed to Deleted Room Information");
            RequestDispatcher rd = request.getRequestDispatcher("dashboard-manager.jsp");
            rd.forward(request, response);
        }
    }

}
