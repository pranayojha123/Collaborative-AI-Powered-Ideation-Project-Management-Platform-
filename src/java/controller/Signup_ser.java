package controller;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import db.DB;

public class Signup_ser extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String pass = request.getParameter("password");
        String role = request.getParameter("role");

        try {
            Connection cn = DB.connection();
            
            PreparedStatement check = cn.prepareStatement("SELECT * FROM info WHERE emailid = ?");
            check.setString(1, email);
            ResultSet rs = check.executeQuery();

            if (rs.next()) {
                response.sendRedirect("Login.html");
                return;
            }

            
            PreparedStatement ps = cn.prepareStatement(
                "INSERT INTO info (name, emailid, password, role) VALUES (?, ?, ?, ?)"
            );
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, pass);
            ps.setString(4, role == null || role.isEmpty() ? "Member" : role);
            ps.executeUpdate();

            
            HttpSession session = request.getSession(true);
            session.setAttribute("email", email);
            session.setAttribute("name", name);
            response.sendRedirect("Dashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Error.html");
        }
    }
}
