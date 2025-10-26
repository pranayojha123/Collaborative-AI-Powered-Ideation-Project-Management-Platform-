<%@page import="java.sql.*,db.DB"%>
<%@page  contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>Project Management</title>

  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700;800&display=swap" rel="stylesheet">

  <style>
  :root{
    --blue: #1e73ff;
    --bg: #f6f9fc;
    --card: #ffffff;
    --muted: #6b7280;
    --border: #e6e9ee;
    --radius: 10px;
  }

  *{ box-sizing: border-box; }
  html,body{ height:100%; }
  body{
    margin:0;
    font-family: "Inter", system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial;
    
    color:#0f1724;
    padding:28px;
     background: linear-gradient(135deg, rgba(30, 30, 47, 0.9), rgba(10, 10, 25, 0.9)),
                  url('https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=1920&q=80');
      background-size: cover;
      background-position: center;
  }

  .container{
    max-width: 980px;
    margin: 0 auto;
    border-radius: var(--radius);
    padding: 20px;
  }

  .card{
    background: var(--card);
    border-radius: var(--radius);
    padding: 22px;
    box-shadow: 0 6px 22px rgba(15,23,36,0.06);
    border: 1px solid var(--border);
  }

  .header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    gap:12px;
    margin-bottom:12px;
  }

  .brand{ display:flex; align-items:center; gap:12px; }
  .brand svg { border-radius: 8px; }
  h1{
    margin:0;
    font-size:22px;
    color:var(--blue);
    font-weight:800;
    letter-spacing:0.2px;
  }
  .small-muted{ color:var(--muted); font-size:13px; }

  .form-grid{
    display:grid;
    grid-template-columns: 1fr;
    gap:14px;
  }

  .field label{ display:block; font-weight:700; margin-bottom:8px; font-size:14px; color:#0f1724; }
  .field input[type="text"], .field textarea{
    width:100%;
    padding:11px 12px;
    border-radius:8px;
    border:1px solid var(--border);
    font-family: inherit;
    font-size:14px;
    background: #fff;
    outline:none;
    transition: box-shadow .15s ease, border-color .12s ease;
  }

  .field textarea{ min-height:82px; resize:vertical; }
  .field input:focus, .field textarea:focus{
    box-shadow: 0 6px 18px rgba(30,115,255,0.08);
    border-color: var(--blue);
  }

  @media (min-width: 880px){
    .form-grid{
      grid-template-columns: 1fr 1fr;
    }
    .field:nth-child(1){ grid-column: 1 / 3; }
    .field:nth-child(4){ grid-column: 1 / 3; }
    .actions{ display:flex; gap:10px; align-items:center; justify-content:flex-start; }
  }

  .btn{
    border: none;
    padding:10px 14px;
    font-weight:700;
    border-radius:8px;
    cursor:pointer;
  }
  .btn.primary{
    background: var(--blue);
    color: #fff;
    box-shadow: 0 6px 14px rgba(30,115,255,0.12);
  }
  .btn.ghost{
    background: transparent;
    color: var(--muted);
    border-radius:8px;
    border:1px solid transparent;
  }

  .divider{ border: none; border-top: 1px solid #eef3f9; margin:18px 0; }

  .table-wrap{
    overflow:auto;
    border-radius:8px;
    border:1px solid #eef3f9;
  }
  .projects-table{
    width:100%;
    border-collapse:collapse;
    min-width: 860px;
  }
  .projects-table thead th{
    text-align:left;
    padding:12px 14px;
    font-weight:800;
    background: linear-gradient(90deg,var(--blue), #1862e6);
    color: #fff;
    font-size:13px;
  }
  .projects-table tbody td{
    padding:12px 14px;
    border-bottom: 1px solid #f3f6fb;
    vertical-align:top;
    font-size:14px;
    color:#111827;
  }
  .num-col{
    width:48px;
    text-align:center;
    color:#fff;
    background: var(--blue);
    border-radius:6px;
    font-weight:700;
  }

  .actions-col{ width:120px; text-align:center; }
  .row-actions{ display:flex; gap:8px; justify-content:center; align-items:center; }
  .icon-btn{
    background:transparent;
    border: none;
    cursor:pointer;
    font-size:16px;
    padding:6px 8px;
    border-radius:6px;
  }
  .icon-btn:hover{ background:#f3f6fb; }

  .modal{
    display:none;
    position:fixed;
    inset:0;
    align-items:center;
    justify-content:center;
    background: rgba(8,15,28,0.35);
  }

  .modal-panel{
    width: 96%;
    max-width:720px;
    background:var(--card);
    border-radius:12px;
    padding:14px;
    box-shadow: 0 10px 40px rgba(2,6,23,0.3);
  }

  .modal-header{ display:flex; justify-content:space-between; align-items:center; gap:8px; margin-bottom:8px; }
  .modal-body label{ display:block; margin-bottom:10px; }
  .modal-body input, .modal-body textarea{ margin-top:6px; }
  .modal-actions{ display:flex; gap:10px; justify-content:flex-end; margin-top:6px; }

  .section-title{ font-size:18px; margin:0 0 8px 0; font-weight:800; }
  .hint{ color:var(--muted); font-size:12px; margin-top:6px; }
  .required{ color:#d53f3f; font-weight:800; margin-left:4px; }
  </style>
</head>

<body>
  <main class="page">
    <div class="container card">
      <header class="header">
        <div class="brand">
          <svg width="36" height="36" viewBox="0 0 24 24" aria-hidden="true">
            <circle cx="12" cy="12" r="10" fill="#1e73ff"/>
            <path d="M6 12h12" stroke="#fff" stroke-width="1.4" stroke-linecap="round"/>
          </svg>
          <h1>Project Management</h1>
        </div>
        <div class="small-muted">Manage & track projects easily</div>
      </header>

      <!-- Form Section -->
      <form class="form-grid" action="AddProject_ser" method="post">
        <div class="field">
          <label>Project Name <span class="required">*</span></label>
          <input type="text" placeholder="Enter project name" name="name" required  />
          <div class="hint">Give the project a short, descriptive name.</div>
        </div>

        <div class="field">
          <label>Project Details</label>
          <textarea placeholder="Enter project details" name="details"></textarea>
        </div>

        <div class="field">
          <label>Problem Statement</label>
          <textarea placeholder="Enter problem statement" name="statement"></textarea>
        </div>

        <div class="field">
          <label>Other Details</label>
          <textarea placeholder="Any other details" name="other"></textarea>
        </div>

        <div class="actions" style="grid-column: 1 / -1;">
          <button class="btn primary" type="submit">Add Project</button>
        </div>
      </form>

      <hr class="divider"/>
<%
try{
    String s="Select * from addproject";
    Statement st=DB.statement();
    ResultSet rs=st.executeQuery(s);

    

%>
    
      <section>
        <h2 class="section-title">All Projects</h2>
        <div class="table-wrap">
          <table class="projects-table">
            <thead>
              <tr>
                <th class="num-col">#</th>
                <th>Project Name</th>
                <th>Project Details</th>
                <th>Problem Statement</th>
                <th>Other Details</th>
                <th class="actions-col">Actions</th>
              </tr>
            </thead>
            <tbody>
                
<%
while(rs.next()){ 

%>                
                
              <tr>
                <td class="num-col">1</td>
                <td><%=rs.getString(1)%></td>
                <td><%=rs.getString(2)%></td>
                <td><%=rs.getString(3)%></td>
                <td><%=rs.getString(4)%></td>
                <td class="actions-col">
                  <div class="row-actions">
                    <button class="icon-btn">✏️</button>
                    <button class="icon-btn">🗑️</button>
                  </div>
                </td>
              </tr>
              <%}%>
            </tbody>
          </table>
        </div>
      </section>
    </div>
  </main>
<%}
catch(Exception e){}

%>
  <div class="modal">
    <div class="modal-panel">
      <header class="modal-header">
        <h3>Edit Project</h3>
        <button class="icon-btn" aria-label="Close edit dialog">&times;</button>
      </header>
      <form class="modal-body">
        <label>Project Name <span class="required">*</span>
          <input type="text" placeholder="Project name" />
        </label>
        <label>Project Details
          <textarea placeholder="Project details"></textarea>
        </label>
        <label>Problem Statement
          <textarea placeholder="Problem statement"></textarea>
        </label>
        <label>Other Details
          <textarea placeholder="Other details"></textarea>
        </label>
        <div class="modal-actions">
          <button class="btn primary" type="button">Save</button>
          <button class="btn ghost" type="button">Cancel</button>
        </div>
      </form>
    </div>
  </div>
</body>
</html>
