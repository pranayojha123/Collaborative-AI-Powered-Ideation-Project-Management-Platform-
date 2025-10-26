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

public class Submission_ser extends HttpServlet {
    

   public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException
   {
       String select=request.getParameter("select");
       String link=request.getParameter("link");
       String other=request.getParameter("other");
       String s="Select id,statement from addproject where name='"+select+"'";
       try{
       String id;
       String statement;
       Statement st=DB.statement();
       ResultSet rs=st.executeQuery(s);
       if(rs.next())
       {
           HttpSession session=request.getSession(true);
           String email=(String)session.getAttribute("email");
           if(email==null){response.sendRedirect("Login.html");return;}
           id=rs.getString(1);
           statement=rs.getString(2);
           Connection cn=DB.connection();
           String t="Insert into submission values(?,?,?,?,?,?)";
           PreparedStatement p=cn.prepareStatement(t);
           p.setString(1, email);
           p.setString(2, id);
           p.setString(3, statement);
           p.setString(4, other);
           p.setString(5, select);
           p.setString(6,link);
           p.executeUpdate();
           response.sendRedirect("Dashboard.jsp");
       }
       
           
       }catch(Exception e){
       e.printStackTrace();
            response.sendRedirect("Error.html");}
   }        
}
