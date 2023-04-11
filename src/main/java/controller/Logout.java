package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class Logout extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session!=null) {
            session.invalidate(); // remove all session
            request.setAttribute("msg", "You have logged out successfully");
            
            // redirect user to login pages
            RequestDispatcher rd = request.getRequestDispatcher("homepage.jsp");
            rd.forward(request, response);
        }
    }
}
