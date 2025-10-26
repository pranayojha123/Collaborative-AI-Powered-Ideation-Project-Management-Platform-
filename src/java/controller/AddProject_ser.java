package controller;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import db.DB;
public class AddProject_ser extends HttpServlet {

    public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException
    { 
        try{
        String s="Insert into addproject values(?,?,?,?)";
        Connection cn=DB.connection();
        PreparedStatement p=cn.prepareStatement(s);
        p.setString(1, request.getParameter("name"));
        p.setString(2, request.getParameter("details"));
        p.setString(3, request.getParameter("statement"));
        p.setString(4, request.getParameter("other"));
        p.executeUpdate();
        response.sendRedirect("AddProject.jsp");
        }catch(Exception e){}
    }
    
}
