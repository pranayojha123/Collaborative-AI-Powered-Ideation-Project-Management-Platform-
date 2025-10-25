<%@page import="java.sql.*,db.DB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Submitted Projects Dashboard</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
  <style>
    :root{
      --bg:#f4f7fb; --card:#ffffff; --muted:#6b7280;
      --accent:#2563eb; --glass: rgba(255,255,255,0.6);
    }
    *{box-sizing:border-box;}
    html, body{height:100%; margin:0; font-family:Inter, sans-serif; background:linear-gradient(180deg,var(--bg) 0%, #eef2f7 100%);}
    body{
         background: linear-gradient(135deg, rgba(30, 30, 47, 0.9), rgba(10, 10, 25, 0.9)),
                  url('https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=1920&q=80');
      background-size: cover;
      background-position: center;
      color:#0f172a;}
    header{display:flex; justify-content:space-between; align-items:center; padding:16px 24px;
      background:rgba(255,255,255,0.6); backdrop-filter:blur(6px); box-shadow:0 2px 10px rgba(16,24,40,0.04);}
    .brand{font-weight:700;color:var(--accent); font-size:18px;}
    main.container{max-width:1100px; margin:26px auto; padding:0 18px;}
    .intro h1{font-size:26px; margin-bottom:6px;}
    .lead{color:var(--muted); margin-bottom:12px;}
    .projects{display:grid; grid-template-columns:repeat(auto-fill,minmax(260px,1fr)); gap:18px;}
    .card{background:var(--card); border-radius:12px; padding:16px; box-shadow:0 6px 16px rgba(17,24,39,0.06);
      display:flex; flex-direction:column; gap:10px; transition:transform .18s ease, box-shadow .18s ease;}
    .card:hover{transform:translateY(-6px); box-shadow:0 12px 30px rgba(2,6,23,0.08);}
    .row{display:flex; gap:12px; align-items:center;}
    .avatar{width:46px; height:46px; border-radius:10px; display:inline-grid; place-items:center;
      font-weight:700; color:#fff; background:linear-gradient(135deg,#6ee7b7,#3b82f6);}
    .title{font-weight:700;}
    .meta{color:var(--muted); font-size:13px;}
    .badges{display:flex; gap:8px; flex-wrap:wrap;}
    .badge{font-size:12px; padding:6px 8px; border-radius:999px; border:1px solid #eef2ff; color:#084298;}
    .actions{margin-top:auto; display:flex; gap:8px;}
    .btn{padding:8px 10px; border-radius:8px; border:none; cursor:pointer; font-weight:600;}
    .btn-primary{background:var(--accent); color:#fff; text-decoration:none; text-align:center; display:inline-block;}
    .footer{text-align:center; color:var(--muted); padding:22px 0;}
  </style>
</head>
<body>

<header>
  <div class="brand">Project Submission Dashboard</div>
</header>

<main class="container">
  <section class="intro">
    <h1>Submitted Projects</h1>
  </section>

  <section class="projects">
    <%
      String email = (String)session.getAttribute("email");
      boolean hasData = false;
      
          String s = "SELECT * FROM submission WHERE email='" + email + "'";
          Statement st = DB.statement();
          ResultSet rs = st.executeQuery(s);

          while(rs.next()) {
              hasData = true;
    %>
              <article class="card">
                <div class="row">
                  <div class="avatar">👤</div>
                  <div>
                    <div class="title"><%= rs.getString(5) %></div>
                    <div class="meta"><%= rs.getString(1) %></div>
                  </div>
                </div>
                <div class="meta"><%= rs.getString(3) %></div>
                <div class="badges">
                  <div class="badge">AI</div>
                  <div class="badge">Safety</div>
                </div>
                <div class="actions">
                  <input class="btn btn-primary" value="<%= rs.getString(6) %>" target="_blank">
                </div>
              </article>
    <%
          }
          if (!hasData) {
    %>
            <h2>No Project Submitted by You</h2>
    <%
          }
        
    %>
  </section>
</main>

</body>
</html>
