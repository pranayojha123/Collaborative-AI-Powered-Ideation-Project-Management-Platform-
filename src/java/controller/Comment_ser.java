
package controller;
import java.sql.*;
import javax.servlet.http.HttpSession;
import db.DB;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Comment_ser extends HttpServlet {
 
    public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException
    {
        try{
        HttpSession session=request.getSession(true);
        Connection cn=DB.connection();
        PreparedStatement p1=cn.prepareStatement("Insert into comments values(?,?,?,?)");
        p1.setString(1, request.getParameter("project_id"));
        p1.setString(2, (String)session.getAttribute("name"));
        p1.setString(3, (String)session.getAttribute("email"));
        p1.setString(4, request.getParameter("statements"));
        p1.executeUpdate();
        response.sendRedirect("AllProject.jsp");
        }catch(Exception e){}
        }
}
