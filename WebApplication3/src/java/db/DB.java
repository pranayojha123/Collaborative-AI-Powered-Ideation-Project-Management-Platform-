package db;
import java.sql.*;
public class DB {
  static Connection cn=null;
  static Statement st=null;
  PreparedStatement st1=null;
  public static Statement statement()
  {return st;}
  public static Connection connection()
  {return cn;}
  static{  
  try{
      Class.forName("com.mysql.jdbc.Driver");
      cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/project","root","root");
      st=cn.createStatement();
  }
  catch(Exception e)
  {System.out.println(e);}
  }
}
