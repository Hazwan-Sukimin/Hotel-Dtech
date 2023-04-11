package controller;

import bean.MyConnection;
import bean.Room;
import dao.RoomDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpdateRoom extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String roomno = request.getParameter("roomno");
        String status = request.getParameter("status");
        int categoryid = Integer.parseInt(request.getParameter("category"));
        
        Room r = new Room();
        r.setId(id);
        r.setRoomno(roomno);
        r.setStatus(status);
        r.setDetailid(categoryid);
        
//        request.setAttribute("show", r);
//        RequestDispatcher rd = request.getRequestDispatcher("success-page.jsp");
//        rd.forward(request, response);
        
        RoomDao rmd = new RoomDao(MyConnection.getConnection());
        
        // check null
        List error1 = rmd.isNull(r);
        if (!error1.isEmpty()) {
            request.setAttribute("errorMsgs", error1.toString().substring(1,error1.toString().length()-1));
            RequestDispatcher rd = request.getRequestDispatcher("update-facility.jsp?id"+id);
            rd.forward(request, response);
            return;
        }
        
        // update facility
        if (rmd.updateRoom(r)) {
            request.setAttribute("color", "success");
            request.setAttribute("errorMsgs", "Successfully Update Room");
            RequestDispatcher rd = request.getRequestDispatcher("update-room.jsp?id"+id);
            rd.forward(request, response);
        } else {
            request.setAttribute("color", "danger");
            request.setAttribute("errorMsgs", "Failed to Update Room");
            RequestDispatcher rd = request.getRequestDispatcher("update-room.jsp?id"+id);
            rd.forward(request, response);
        }
    }

}
