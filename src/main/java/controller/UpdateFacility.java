package controller;

import bean.Facility;
import bean.MyConnection;
import dao.FacilityDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpdateFacility extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // get Parameter
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String type = request.getParameter("type");
        String icon = request.getParameter("icon");
        
        // Bean
        Facility f = new Facility();
        f.setId(id);
        f.setName(name);
        f.setType(type);
        f.setIcon(icon);
        
        // Dao
        FacilityDao fd = new FacilityDao(MyConnection.getConnection());
        
        // check null value
        List error1 = fd.isNull(f);
        if (!error1.isEmpty()) {
            request.setAttribute("errorMsgs", error1.toString().substring(1,error1.toString().length()-1));
            RequestDispatcher rd = request.getRequestDispatcher("update-facility.jsp?id"+id);
            rd.forward(request, response);
            return;
        }
        
        // update facility
        if (fd.updateFacility(f)) {
            request.setAttribute("color", "success");
            request.setAttribute("errorMsgs", "Successfully Update");
            RequestDispatcher rd = request.getRequestDispatcher("update-facility.jsp?id"+id);
            rd.forward(request, response);
        } else {
            request.setAttribute("color", "danger");
            request.setAttribute("errorMsgs", "Failed to Update");
            RequestDispatcher rd = request.getRequestDispatcher("update-facility.jsp?id"+id);
            rd.forward(request, response);
        }
        
        
        
    }

}
