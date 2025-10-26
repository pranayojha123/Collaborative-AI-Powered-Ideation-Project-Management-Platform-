<%@page import="db.DB"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>🧠 Team Task Management Board</title>
<style>
  * { margin:0; padding:0; box-sizing:border-box; font-family:"Poppins", sans-serif; }
  body { 
       background: linear-gradient(135deg, rgba(30, 30, 47, 0.9), rgba(10, 10, 25, 0.9)),
                  url('https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=1920&q=80');
      background-size: cover;
      background-position: center;
      color:#222; min-height:100vh; display:flex; flex-direction:column; align-items:center; 
  }

  header { 
    text-align:center; 
    padding:2rem 1rem 1.2rem; 
    width:100%; 
    background:rgba(255,255,255,0.7); 
    backdrop-filter:blur(5px); 
    box-shadow:0 3px 10px rgba(0,0,0,0.05); 
    position:relative;
  }

  h1 { font-size:2rem; color:#1a237e; margin-bottom:1rem; }

  /* ✅ Dashboard Button Styling */
  .dashboard-btn {
    position:absolute;
    top:1.5rem;
    left:1.5rem;
    background:#1a73e8;
    color:white;
    border:none;
    border-radius:6px;
    padding:0.6rem 1.2rem;
    font-weight:600;
    cursor:pointer;
    transition:background 0.3s, transform 0.2s;
  }
  .dashboard-btn:hover {
    background:#0b59d0;
    transform:scale(1.05);
  }

  form { display:flex; justify-content:center; gap:0.6rem; flex-wrap:wrap; margin-bottom:1.5rem; }
  input, select, button { padding:0.6rem 0.8rem; border:1px solid #ccc; border-radius:6px; outline:none; font-size:0.9rem; }
  input:focus, select:focus { border-color:#1a73e8; }
  button { background:#1a73e8; color:white; border:none; cursor:pointer; transition:background 0.3s ease, transform 0.2s ease; }
  button:hover { background:#0b59d0; transform:scale(1.05); }

  .board { display:flex; justify-content:center; align-items:flex-start; gap:1.5rem; padding:1rem 2rem 2rem; flex-wrap:wrap; width:100%; max-width:1200px; }
  .column { background:#fff; border-radius:10px; box-shadow:0 4px 12px rgba(0,0,0,0.08); width:300px; padding:1rem; min-height:380px; display:flex; flex-direction:column; }
  .column h2 { text-align:center; color:#0b59d0; border-bottom:2px solid #e3e7f3; padding-bottom:0.5rem; margin-bottom:1rem; }
  .task { background:#f9fbff; border-radius:8px; padding:0.8rem; margin-bottom:0.8rem; border-left:5px solid #1a73e8; }
  .task h3 { font-size:1rem; color:#222; margin-bottom:0.2rem; }
  .task p { font-size:0.8rem; color:#666; margin-bottom:0.4rem; }
  .tag { display:inline-block; font-size:0.75rem; padding:4px 8px; border-radius:5px; color:white; font-weight:500; }
  .dev { background:#1a73e8; }
  .research { background:#8e24aa; }
  .review { background:#fbc02d; color:#222; }
  .done-tag { background:#43a047; }
  footer { text-align:center; padding:1rem; color:#555; font-size:0.85rem; margin-top:auto; }
</style>
</head>
<body>

<header>
 
  <form action="Dashboard.jsp" method="get" style="display:inline;">
    <button type="submit" class="dashboard-btn">🏠 Dashboard</button>
  </form>

  <h1>🧠 Team Task Management Board</h1>

  <form action="TODO_ser" method="post">
    <input type="text" name="name" placeholder="Task name" required />
    <select name="level">
      <option value="To-Do">To-Do</option>
      <option value="In Progress">In Progress</option>
      <option value="Completed">Completed</option>
    </select>
    <select name="status">
      <option value="dev">Development</option>
      <option value="research">Research</option>
      <option value="review">Review</option>
      <option value="done-tag">Completed</option>
    </select>
    <button type="submit">Submit Task</button>
  </form>
</header>

<%
String email = (String) session.getAttribute("email");
if(email == null){ response.sendRedirect("Login.html"); return; }

Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;

List<Map<String,String>> todoTasks = new ArrayList<>();
List<Map<String,String>> progressTasks = new ArrayList<>();
List<Map<String,String>> doneTasks = new ArrayList<>();

try {
    conn = DB.connection();
    String sql = "SELECT * FROM todo WHERE email=? ORDER BY FIELD(level,'To-Do','In Progress','Completed'), date DESC";
    ps = conn.prepareStatement(sql);
    ps.setString(1, email);
    rs = ps.executeQuery();

    while(rs.next()){
        Map<String,String> task = new HashMap<>();
        task.put("name", rs.getString("name"));
        task.put("status", rs.getString("status"));
        task.put("date", rs.getString("date"));
        task.put("level", rs.getString("level"));

        switch(rs.getString("level")){
            case "To-Do": todoTasks.add(task); break;
            case "In Progress": progressTasks.add(task); break;
            case "Completed": doneTasks.add(task); break;
        }
    }
} catch(Exception e){
    out.println("Error: "+e.getMessage());
} 
%>

<main class="board">
  <div class="column todo">
    <h2>📝 To-Do</h2>
    <%
      for(Map<String,String> t : todoTasks){
    %>
    <div class="task">
      <h3><%=t.get("name")%></h3>
      <p>Added: <%=t.get("date")%></p>
      <span class="tag <%=t.get("status")%>"><%=t.get("status")%></span>
    </div>
    <% } %>
  </div>

  <div class="column progress">
    <h2>⚙️ In Progress</h2>
    <%
      for(Map<String,String> t : progressTasks){
    %>
    <div class="task">
      <h3><%=t.get("name")%></h3>
      <p>Added: <%=t.get("date")%></p>
      <span class="tag <%=t.get("status")%>"><%=t.get("status")%></span>
    </div>
    <% } %>
  </div>

  <div class="column done">
    <h2>✅ Completed</h2>
    <%
      for(Map<String,String> t : doneTasks){
    %>
    <div class="task">
      <h3><%=t.get("name")%></h3>
      <p>Added: <%=t.get("date")%></p>
      <span class="tag <%=t.get("status")%>"><%=t.get("status")%></span>
    </div>
    <% } %>
  </div>
</main>

<footer>© 2025 Team Task Management Board</footer>
</body>
</html>
