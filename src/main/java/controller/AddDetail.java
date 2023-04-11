package controller;

import bean.Detail;
import bean.MyConnection;
import dao.DetailDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class AddDetail extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String size = request.getParameter("size");
        String suitable[] = request.getParameterValues("suitable");
        String price = request.getParameter("price");
        String deposit = request.getParameter("deposit");
        String submit = request.getParameter("submit");
        String image = request.getParameter("image");
        
        
        // get multiple checkbox
        String facility[] = request.getParameterValues("facility");
        
        // checkbox cannot leave null
        if (facility == null) {
            request.setAttribute("errorMsgs", "Please Choose at least 1 Facility");
            RequestDispatcher rd = request.getRequestDispatcher("register-category.jsp");
            rd.forward(request, response);
        }
        
        if (suitable == null) {
            request.setAttribute("errorMsgs", "Please Choose at least 1 Suitable");
            RequestDispatcher rd = request.getRequestDispatcher("register-category.jsp");
            rd.forward(request, response);
        }
        
        List facilityid = new ArrayList();
        for (int i = 0; i < facility.length; i++) {
            facilityid.add(Integer.parseInt(facility[i]));
        }
        
        List suitableName = new ArrayList();
        for (int i = 0; i < suitable.length; i++) {
            suitableName.add(suitable[i]);
        }
        
        // Bean Object
        Detail d = new Detail();
        d.setName(name);
        d.setDescription(description);
        d.setSize(size);
        d.setSuitable((ArrayList) suitableName);
        d.setPrice(price);
        d.setDeposit(deposit);
        d.setFacility((ArrayList) facilityid);
        d.setImage(image);
        
        // Dao
        DetailDao dd = new DetailDao(MyConnection.getConnection());
        
        // check null value
        List error1 = dd.isNull(d);
        if (!error1.isEmpty()) {
            request.setAttribute("errorMsgs", error1.toString().substring(1,error1.toString().length()-1));
            RequestDispatcher rd = request.getRequestDispatcher("register-room.jsp");
            rd.forward(request, response);
            return;
        }
        
        // check name duplication
        List error2 = dd.isDuplicate(d);
        if (!error2.isEmpty()) {
            request.setAttribute("errorMsgs", error2.toString().substring(1,error2.toString().length()-1));
            RequestDispatcher rd = request.getRequestDispatcher("register-room.jsp");
            rd.forward(request, response);
            return;
        }
        
        
        // add room detail
        if (dd.addDetail(d)) {
            request.setAttribute("detail", d);
            request.setAttribute("detailSubmit", submit);
            request.setAttribute("link", "register-category.jsp");
            RequestDispatcher rd = request.getRequestDispatcher("success-page.jsp");
            rd.forward(request, response);
        } else {
            request.setAttribute("errorMsgs", "Database failed");
            RequestDispatcher rd = request.getRequestDispatcher("register-category.jsp");
            rd.forward(request, response);
        }
        
//request.setAttribute("show", d);
//        RequestDispatcher rd = request.getRequestDispatcher("success-page.jsp");
//        rd.forward(request, response);
    }
}
