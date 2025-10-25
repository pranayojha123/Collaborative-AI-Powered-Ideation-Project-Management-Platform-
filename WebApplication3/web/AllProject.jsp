<%@page import="java.sql.*,db.DB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Team Collaboration Platform - Projects Dashboard</title>

  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: "Poppins", sans-serif;
    }

    body {
      background: linear-gradient(rgba(0, 0, 0, 0.4), rgba(0, 0, 0, 0.4)),
        url('https://img.freepik.com/free-photo/still-life-books-versus-technology_23-2150062913.jpg?t=st=1760017330~exp=1760020930~hmac=204660f69fcd208d4227fb07fbe5a417fabef27386f32f927a101a878a126502&w=2000');
      background-size: cover;
      background-position: center;
      min-height: 100vh;
      backdrop-filter: blur(2px);
      background-attachment: fixed;
    }

    header {
      color: white;
      text-align: center;
      padding: 40px 20px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
      border-radius: 0 0 25px 25px;
      position: relative;
    }

    header h1 {
      font-size: 2rem;
      font-weight: 600;
      letter-spacing: 0.5px;
    }

    header p {
      font-size: 1rem;
      margin-top: 5px;
      opacity: 0.9;
    }

    /* 🔹 Dashboard Button */
    .dashboard-btn {
      position: absolute;
      top: 20px;
      right: 30px;
      background: linear-gradient(90deg, #3b82f6, #2563eb);
      color: white;
      text-decoration: none;
      padding: 10px 18px;
      border-radius: 8px;
      font-size: 0.9rem;
      font-weight: 500;
      transition: all 0.3s ease;
    }

    .dashboard-btn:hover {
      background: linear-gradient(90deg, #2563eb, #1d4ed8);
      box-shadow: 0 4px 10px rgba(37, 99, 235, 0.3);
      transform: scale(1.05);
    }

    .dashboard {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(290px, 1fr));
      gap: 30px;
      padding: 20px 60px;
      max-width: 1200px;
      margin: 0 auto;
    }

    .project-card {
      background-color: #43434350;
      border-radius: 18px;
      padding: 25px;
      backdrop-filter: blur(10px);
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
      transition: all 0.3s ease;
      border: 1px solid rgba(255, 255, 255, 0.4);
      position: relative;
      overflow: hidden;
      color: #ffffffb0;
      animation: fadeInUp 0.6s ease forwards;
      opacity: 0;
    }

    .project-card:hover {
      transform: translateY(8px);
      box-shadow: 0 12px 25px rgba(0, 0, 0, 0.15);
      backdrop-filter: blur(3px);
      background: linear-gradient(117deg, rgba(63, 94, 251, 0.722) 0%, rgba(252, 70, 106, 0.695) 100%);
    }

    .card-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 10px;
    }

    .project-card h2 {
      font-size: 1.1rem;
      font-weight: 600;
    }

    .status {
      padding: 5px 12px;
      border-radius: 20px;
      font-size: 0.8rem;
      font-weight: 500;
      color: white;
    }

    .status.in-progress { background: #fbbf24; }
    .status.planned { background: #10b981; }
    .status.completed { background: #22c55e; }

    .desc {
      font-size: 0.9rem;
      margin-bottom: 12px;
    }

    .project-card p {
      font-size: 0.88rem;
      margin: 6px 0;
    }

    button {
      margin-top: 15px;
      background: linear-gradient(90deg, #3b82f6, #2563eb);
      color: #fff;
      border: none;
      border-radius: 10px;
      padding: 8px 16px;
      cursor: pointer;
      font-weight: 500;
      transition: all 0.3s ease;
    }

    button:hover {
      background: linear-gradient(90deg, #2563eb, #1d4ed8);
      box-shadow: 0 4px 10px rgba(37, 99, 235, 0.3);
    }

    @keyframes fadeInUp {
      from { opacity: 0; transform: translateY(30px); }
      to { opacity: 1; transform: translateY(0); }
    }
  </style>
</head>

<body>
  <header>
    <h1>Team Collaboration Platform</h1>
    <p>Projects Dashboard</p>
    <a href="Dashboard.jsp" class="dashboard-btn">🏠 Dashboard</a>
  </header>

  <%
  String s = "SELECT * FROM addproject";
  try {
      Statement st = DB.statement();
      ResultSet rs = st.executeQuery(s);
  %>

  <main class="dashboard">
    <%
      while(rs.next()) {
    %>
    <form action="Comments.jsp" method="post"> 
      <div class="project-card">
        <div class="card-header">
          <h2><%=rs.getString(1)%></h2>
          <span class="status in-progress">In Progress</span>
        </div>
        <p class="desc"><%=rs.getString(2)%></p>
        <p><strong>Details:</strong> <%=rs.getString(3)%></p>
        <p><strong>Team:</strong> 5 Members</p>
        <input type="hidden" name="project_id" value="<%=rs.getString(5)%>">
        <button>View Comments</button>
      </div>
    </form>
    <% } } catch(Exception e) { e.printStackTrace(); } %>
  </main>
</body>
</html>
