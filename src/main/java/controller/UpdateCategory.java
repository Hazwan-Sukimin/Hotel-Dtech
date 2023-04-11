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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpdateCategory extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String size = request.getParameter("size");
        String suitable[] = request.getParameterValues("suitable");
        String price = request.getParameter("price");
        String deposit = request.getParameter("deposit");
        String submit = request.getParameter("submit");
        String image = request.getParameter("image");
        String facility[] = request.getParameterValues("facility");
        
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
        
        DetailDao dd = new DetailDao(MyConnection.getConnection());
        if (dd.updateCategory(d)) {
            
        }
        
        
        
        RequestDispatcher rd = request.getRequestDispatcher("aef");
        rd.forward(request, response);
    }

}
