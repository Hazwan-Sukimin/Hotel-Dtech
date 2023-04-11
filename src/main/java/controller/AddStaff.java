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

public class AddStaff extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String position = request.getParameter("position");
        int manager = Integer.parseInt(request.getParameter("manager"));
        String submit = request.getParameter("submit");
        
        // Staff Bean
        Staff st = new Staff();
        st.setFullname(fullname);
        st.setEmail(email);
        st.setAddress(address);
        st.setPhone(phone);
        st.setPosition(position);
        st.setStatus("On");
        st.setManager(manager);
        st.setPassword("123");
        
        // DAO Staff
        StaffDao sd = new StaffDao(MyConnection.getConnection());
        
        // check null value
        List error1 = sd.isNull(st);
        if (!error1.isEmpty()) {
            request.setAttribute("errorMsgs", error1.toString().substring(1,error1.toString().length()-1));
            RequestDispatcher rd = request.getRequestDispatcher("register-staff.jsp");
            rd.forward(request, response);
            return;
        }
        
        //check format | address, phone
        List error2 = sd.isFormat(st);
        if (!error2.isEmpty()) {
            request.setAttribute("errorMsgs", error2.toString().substring(1,error2.toString().length()-1));
            RequestDispatcher rd = request.getRequestDispatcher("register-staff.jsp");
            rd.forward(request, response);
            return;
        }
        
        // check duplication | email, phone
        List error3 = sd.isDuplicate(st);
        if (!error3.isEmpty()) {
            request.setAttribute("errorMsgs", error3.toString().substring(1,error3.toString().length()-1));
            RequestDispatcher rd = request.getRequestDispatcher("register-staff.jsp");
            rd.forward(request, response);
            return;
        }
        
        // add staff to the database
        if (sd.addStaff(st)) {
            request.setAttribute("staff", st);
            request.setAttribute("staffSubmit", submit);
            request.setAttribute("link", "register-staff.jsp");
            RequestDispatcher rd = request.getRequestDispatcher("success-page.jsp");
            rd.forward(request, response);
        } else {
            request.setAttribute("staffSubmit", submit);
            request.setAttribute("link", "register-staff.jsp");
            RequestDispatcher rd = request.getRequestDispatcher("error-page.jsp");
            rd.forward(request, response);
        }
        
        
        
    }
}
