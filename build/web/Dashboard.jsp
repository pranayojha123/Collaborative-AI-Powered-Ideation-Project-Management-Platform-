<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Smart Dashboard</title>

  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
  <!-- Remix Icons -->
  <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet">
<%
if(session.getAttribute("email")==null){response.sendRedirect("Login.html");return;}
if(session.getAttribute("name")==null){response.sendRedirect("Login.html");return;}
%>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Poppins', sans-serif;
    }

    body {
      background: linear-gradient(135deg, rgba(30, 30, 47, 0.9), rgba(10, 10, 25, 0.9)),
                  url('https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=1920&q=80');
      background-size: cover;
      background-position: center;
      color: #fff;
      padding: 40px;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    h1 {
      text-align: center;
      font-size: 2.8em;
      color: #fff;
      margin-bottom: 40px;
      text-shadow: 0 4px 20px rgba(0, 0, 0, 0.6);
      letter-spacing: 1px;
    }

    .dashboard {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 30px;
      width: 100%;
      max-width: 1200px;
    }

    .card {
      background: rgba(255, 255, 255, 0.08);
      border: 1px solid rgba(255, 255, 255, 0.15);
      border-radius: 20px;
      padding: 30px;
      box-shadow: 0 6px 20px rgba(0,0,0,0.4);
      transition: all 0.3s ease;
      backdrop-filter: blur(15px);
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }

    .card:hover {
      transform: translateY(-8px) scale(1.02);
      box-shadow: 0 10px 30px rgba(0,0,0,0.6);
      border-color: rgba(255,255,255,0.25);
    }

    .icon {
      font-size: 46px;
      margin-bottom: 18px;
      background: linear-gradient(135deg, #00c6ff, #0072ff);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }

    .card h2 {
      font-size: 22px;
      margin-bottom: 10px;
      color: #fff;
    }

    .card p {
      font-size: 15px;
      color: rgba(255,255,255,0.8);
      margin-bottom: 25px;
      line-height: 1.5;
    }

    /* Modern Animated Button */
    .btn {
      position: relative;
      display: inline-block;
      padding: 12px 24px;
      background: linear-gradient(135deg, #0072ff, #00c6ff);
      color: white;
      font-weight: 600;
      font-size: 14px;
      border: none;
      border-radius: 10px;
      cursor: pointer;
      text-align: center;
      letter-spacing: 0.5px;
      overflow: hidden;
      transition: all 0.4s ease;
    }

    .btn::before {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100%;
      background: linear-gradient(120deg, transparent, rgba(255,255,255,0.6), transparent);
      transition: 0.5s;
    }

    .btn:hover::before {
      left: 100%;
    }

    .btn:hover {
      transform: scale(1.08);
      box-shadow: 0 4px 15px rgba(0,114,255,0.6);
    }

    .btn:active {
      transform: scale(1.02);
      box-shadow: 0 2px 10px rgba(0,114,255,0.5);
    }

    .task .icon { background: linear-gradient(135deg, #00c9a7, #92fe9d); -webkit-background-clip: text; }
    .project .icon { background: linear-gradient(135deg, #0072ff, #00c6ff); -webkit-background-clip: text; }
    .chat .icon { background: linear-gradient(135deg, #bc4e9c, #f80759); -webkit-background-clip: text; }
    .comments .icon { background: linear-gradient(135deg, #ff9966, #ff5e62); -webkit-background-clip: text; }
    .documents .icon { background: linear-gradient(135deg, #56ab2f, #a8e063); -webkit-background-clip: text; }
    .ai .icon { background: linear-gradient(135deg, #f7971e, #ffd200); -webkit-background-clip: text; }
    .analytics .icon { background: linear-gradient(135deg, #ff416c, #ff4b2b); -webkit-background-clip: text; }

    @media (max-width: 600px) {
      body { padding: 25px; }
      h1 { font-size: 2.2em; }
    }
  </style>
</head>
<body>

  <h1>Smart Dashboard</h1>

  <div class="dashboard">

    
    <div class="card project">
        <form method="post" action="AddProject.jsp">  
      <i class="ri-folder-3-line icon"></i>
      <h2>Add Projects</h2>
      <p>Track team milestones, deadlines, and overall progress across all projects efficiently.</p>
      <button class="btn">View Projects</button>
        </form>
    </div>

    <div class="card chat">
        <form method="post" action="chat.jsp">  
      <i class="ri-chat-3-line icon"></i>
      <h2>Chat</h2>
      <p>Stay connected with your teammates through instant messages and topic-specific group chats.</p>
      <button class="btn">Open Chat</button>
        </form>
    </div>

    <div class="card comments">
        <form method="post" action="AllProject.jsp">  
      <i class="ri-discuss-line icon"></i>
      <h2>Projects and Comments</h2>
      <p>Platform to organized on project progress.Enables seamless teamwork by consolidating all communication and suggestions.</p>
      <button class="btn">View Projects and Comments</button>
        </form>
    </div>
      
      <div class="card task">
       <form method="post" action="TODO.jsp">
      <i class="ri-task-line icon"></i>
      <h2>Tasks</h2>
      <p>View and manage your assigned tasks with due dates and real-time progress tracking.</p>
      <button class="btn">Manage Tasks</button>
       </form>
    </div>

    <div class="card documents">
        <form method="post" action="Submission.jsp">  
      <i class="ri-file-list-3-line icon"></i>
      <h2>Submission</h2>
      <p>Project submission involves presenting the finalized project definition, including objectives, scope, methodology, and expected outcomes, to supervisors or evaluators for approval, assessment, and further development or implementation.</p>
      <button class="btn">Open Documents</button>
        </form>
    </div>

    <div class="card ai">
        <form method="post" action="WhiteBoard.html">  
      <i class="ri-robot-line icon"></i>
      <h2>White Board</h2>
      <p>An online whiteboard is a digital platform for real-time collaborative drawing, brainstorming, and note-taking.</p>
      <button class="btn">View Suggestions</button>
        </form>
    </div>
    
      <div class="card documents">
        <form method="post" action="Submitted.jsp">  
      <i class="ri-file-list-3-line icon"></i>
      <h2>Submitted Project</h2>
      <p>A submitted project refers to the finalized version of a project proposal or work that has been completed and officially submitted for review or evaluation.</p>
      <button class="btn">Open Documents</button>
        </form>
    </div>
   

  </div>

</body>
</html>
