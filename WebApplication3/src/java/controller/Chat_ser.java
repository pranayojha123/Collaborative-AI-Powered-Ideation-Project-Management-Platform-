package controller;
import db.DB;
import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
public class Chat_ser extends HttpServlet {

  public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
  {
      HttpSession session =request.getSession(true);
      if(session.getAttribute("email")==null){response.sendRedirect("Login.html");return;}
      if(session.getAttribute("name")==null){response.sendRedirect("Login.html");return;}
      String email=(String)session.getAttribute("email");
      String name=(String)session.getAttribute("name");
      try{
          Connection cn=DB.connection();
          PreparedStatement p=cn.prepareStatement("Insert into chat values(?,?,?)");
          p.setString(1,email);
          p.setString(2, name);
          p.setString(3, request.getParameter("statement"));
          p.executeUpdate();
          response.sendRedirect("chat.jsp");
      }
      catch(Exception e){}
  }
    
}
