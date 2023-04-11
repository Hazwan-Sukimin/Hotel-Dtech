package controller;

import bean.Facility;
import bean.MyConnection;
import dao.FacilityDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class AddFacility extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // Get parameter
        String name = request.getParameter("name");
        String type = request.getParameter("type");
        String icon = request.getParameter("icon");
        String submit = request.getParameter("submit");
        
        // Bean object
        Facility f = new Facility();
        f.setName(name);
        f.setType(type);
        f.setIcon(icon);
        
        // Dao
        FacilityDao fd = new FacilityDao(MyConnection.getConnection());
        
        // check any error
        List error = fd.isNull(f);
        if (!error.isEmpty()) {
            request.setAttribute("errorMsgs", error.toString().substring(1,error.toString().length()-1));
            RequestDispatcher rd = request.getRequestDispatcher("register-facility.jsp");
            rd.forward(request, response);
            return;
        }
        
        // check duplicate
        List error2 = fd.isDuplicate(f);
        if (!error2.isEmpty()) {
            request.setAttribute("errorMsgs", error2.toString().substring(1,error2.toString().length()-1));
            RequestDispatcher rd = request.getRequestDispatcher("register-facility.jsp");
            rd.forward(request, response);
            return;
        }
        
        // add facility
        if (fd.addFacility(f)) {
            request.setAttribute("facility", f);
            request.setAttribute("FacilitySubmit", submit);
            request.setAttribute("link", "register-facility.jsp");
            RequestDispatcher rd = request.getRequestDispatcher("success-page.jsp");
            rd.forward(request, response);
        } else {
            request.setAttribute("FacilitySubmit", submit);
            request.setAttribute("link", "register-facility.jsp");
            RequestDispatcher rd = request.getRequestDispatcher("error-page.jsp");
            rd.forward(request, response);
        }
        
    }

}
