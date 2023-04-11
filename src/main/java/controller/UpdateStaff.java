package controller;

import bean.MyConnection;
import bean.Staff;
import dao.StaffDao;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class UpdateStaff extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String position = request.getParameter("position");
        String manager = request.getParameter("manager");
        String submit = request.getParameter("submit");
        
        // Bean Object
        Staff st = new Staff();
        
        st.setId(id);
        st.setFullname(fullname);
        st.setEmail(email);
        st.setPhone(phone);
        st.setAddress(address);
        st.setPosition(position);
        st.setManager(Integer.parseInt(manager));
        
        // Dao
        StaffDao sd = new StaffDao(MyConnection.getConnection());
        
        // check null value
        List error1 = sd.isNull(st);
        if (!error1.isEmpty()) {
            request.setAttribute("errorMsgs", error1.toString().substring(1,error1.toString().length()-1));
            RequestDispatcher rd = request.getRequestDispatcher("update-staff.jsp?id"+id);
            rd.forward(request, response);
            return;
        }
        
        //check format | address, phone
        List error2 = sd.isFormat(st);
        if (!error2.isEmpty()) {
            request.setAttribute("errorMsgs", error2.toString().substring(1,error2.toString().length()-1));
            RequestDispatcher rd = request.getRequestDispatcher("update-staff.jsp?id"+id);
            rd.forward(request, response);
            return;
        }
        
//        request.setAttribute("staff", st);
//        RequestDispatcher rd = request.getRequestDispatcher("testing.jsp");
//        rd.forward(request, response);
        
        // Update staff at database
        if (sd.updateStaff(st)) {
            request.setAttribute("color", "success");
            request.setAttribute("errorMsgs", "Successfully Update");
            RequestDispatcher rd = request.getRequestDispatcher("update-staff.jsp?id"+id);
            rd.forward(request, response);
        } else {
            request.setAttribute("color", "danger");
            request.setAttribute("errorMsgs", "Failed to Update");
            RequestDispatcher rd = request.getRequestDispatcher("update-staff.jsp?id"+id);
            rd.forward(request, response);
        }
    }


}
