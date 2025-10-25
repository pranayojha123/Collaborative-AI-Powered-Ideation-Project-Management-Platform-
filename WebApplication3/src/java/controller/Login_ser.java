package controller;

import db.DB;
import java.sql.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class Login_ser extends HttpServlet {
    
    public void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException {
        
        String email = request.getParameter("email");
        String pass = request.getParameter("password");

        try {
            Connection cn = DB.connection();
            PreparedStatement ps = cn.prepareStatement(
                "SELECT name FROM info WHERE emailid = ? AND password = ?"
            );
            ps.setString(1, email);
            ps.setString(2, pass);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
               
                HttpSession session = request.getSession(true);
                session.setAttribute("email", email);
                session.setAttribute("name", rs.getString(1));
                response.sendRedirect("Dashboard.jsp");
            } else {
               
                response.sendRedirect("Sign.html");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Error.html");
        }
    }
}
