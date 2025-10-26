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


public class TODO_ser extends HttpServlet {

   public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException
   {
       HttpSession session=request.getSession(true);
       String email=(String)session.getAttribute("email");
       if(email==null){response.sendRedirect("Login.html");return;}
       String name=request.getParameter("name");
       String level=request.getParameter("level");
       String status=request.getParameter("status");
       try{
       Connection cn=DB.connection();
       PreparedStatement p=cn.prepareStatement("Insert into todo values(?,?,?,?,?)");
       p.setString(1, level);
       p.setString(2,status);
       p.setString(3,email);
       java.sql.Date today = new java.sql.Date(System.currentTimeMillis());
       p.setDate(4,today);
       p.setString(5, name);
       p.executeUpdate();
       response.sendRedirect("TODO.jsp");
       }
       catch(Exception e){}
   }
}
