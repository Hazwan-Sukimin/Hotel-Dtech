package controller;

import bean.MyConnection;
import bean.Room;
import dao.RoomDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class AddRoom extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // get parameter
        String roomno = request.getParameter("roomno");
        String status = request.getParameter("status");
        int detailid = Integer.parseInt(request.getParameter("category"));
        
        String submit = request.getParameter("submit");
        
        // bean object
        Room r = new Room();
        r.setRoomno(roomno);
        r.setStatus(status);
        r.setDetailid(detailid);
        
        // Dao
        RoomDao roomDao = new RoomDao(MyConnection.getConnection());
        
        // check null
        List error1 = roomDao.isNull(r);
        if (!error1.isEmpty()) {
            request.setAttribute("errorMsgs", error1.toString().substring(1,error1.toString().length()-1));
            RequestDispatcher rd = request.getRequestDispatcher("register-room.jsp");
            rd.forward(request, response);
            return;
        }
        
        // check duplication
        List error2 = roomDao.isDuplicate(r);
        if (!error2.isEmpty()) {
            request.setAttribute("errorMsgs", error2.toString().substring(1,error2.toString().length()-1));
            RequestDispatcher rd = request.getRequestDispatcher("register-room.jsp");
            rd.forward(request, response);
            return;
        }
        
        // add room
        if (roomDao.addRoom(r)) {
            request.setAttribute("room", r);
            request.setAttribute("RoomSubmit", submit);
            request.setAttribute("link", "register-room.jsp");
            RequestDispatcher rd = request.getRequestDispatcher("success-page.jsp");
            rd.forward(request, response);
        } else {
            request.setAttribute("RoomSubmit", submit);
            request.setAttribute("link", "register-room.jsp");
            RequestDispatcher rd = request.getRequestDispatcher("error-page.jsp");
            rd.forward(request, response);
        }
    }

}
