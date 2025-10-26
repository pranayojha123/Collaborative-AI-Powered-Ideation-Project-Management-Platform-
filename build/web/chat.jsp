<%@ page import="java.sql.*,javax.servlet.http.*,db.DB,javax.servlet.ServletException" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1" />
<title>Global Chat</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">

<%
if(session.getAttribute("email")==null){response.sendRedirect("Login.html");return;}
if(session.getAttribute("name")==null){response.sendRedirect("Login.html");return;}
%>

<style>
:root{
  --bg:#0f1720;
  --panel:#0b1114;
  --text:#e6eef0;
  --muted:#98a3a6;
  --accent:#7de3c8;
}

*{box-sizing:border-box}
body{
  margin:0;
  font-family:Inter, system-ui, sans-serif;
  background:linear-gradient(180deg,#071219 0%, #0f1720 100%);
  color:var(--text);
  min-height:100vh;
  display:flex;
  align-items:center;
  justify-content:center;
  padding:20px;
}

.app{
  width:100%;
  max-width:1000px;
  height:80vh;
  display:grid;
  grid-template-columns:260px 1fr;
  gap:20px;
  background:var(--panel);
  border-radius:12px;
  overflow:hidden;
  box-shadow:0 10px 30px rgba(2,6,8,0.6);
}

.sidebar{
  padding:18px;
  background:rgba(255,255,255,0.02);
  border-right:1px solid rgba(255,255,255,0.03);
}

.brand{
  font-weight:700;
  margin-bottom:12px;
  font-size:18px;
}

.dashboard-btn {
  width: 100%;
  padding: 10px 0;
  border: none;
  border-radius: 8px;
  background: var(--accent);
  color: #002522;
  font-weight: 700;
  cursor: pointer;
  transition: background 0.3s;
  margin-bottom: 18px;
}
.dashboard-btn:hover {
  background: #5fd3b6;
}

.users-section h4{margin-top:10px;color:var(--text);font-size:15px}
.users-list{margin-top:8px;font-size:14px;color:var(--muted)}

.participant{
  display:flex;
  gap:10px;
  align-items:center;
  padding:8px 6px;
  border-radius:8px;
}
.participant .p-meta{display:flex;flex-direction:column;font-size:13px}
.participant .p-name{font-weight:600;color:var(--text)}
.participant .p-email{font-size:12px;color:var(--muted)}

.chat-area{
  display:flex;
  flex-direction:column;
  height:100%;
  position:relative;
  overflow:hidden;
}

.messages{
  padding:18px;
  overflow-y:auto;
  flex:1;
  display:flex;
  flex-direction:column;
  gap:12px;
  scrollbar-width: thin;
  scrollbar-color: var(--accent) rgba(255,255,255,0.05);
  height:100%;
}

.messages::-webkit-scrollbar { width: 8px; }
.messages::-webkit-scrollbar-thumb { background: var(--accent); border-radius: 6px; }
.messages::-webkit-scrollbar-track { background: rgba(255,255,255,0.05); }

.message-row{
  display:flex;
  gap:10px;
  align-items:flex-start;
  width:100%;
}
.message-row.me{ justify-content:flex-end; }

.avatar{
  width:44px;
  height:44px;
  border-radius:50%;
  display:inline-flex;
  align-items:center;
  justify-content:center;
  font-weight:700;
  color:#062821;
  background:linear-gradient(180deg,#c9f7ee,#7de3c8);
  flex:0 0 44px;
  font-size:14px;
  text-transform:uppercase;
}

.message{
  max-width:70%;
  padding:10px 12px;
  border-radius:10px;
  background:rgba(255,255,255,0.03);
  font-size:14px;
  line-height:1.25;
  display:flex;
  flex-direction:column;
}

.message.me{
  background:linear-gradient(90deg,var(--accent), #5fd3b6);
  color:#002522;
  font-weight:600;
}

.message-row.me .avatar{ order:2; }

.meta{
  font-size:12px;
  color:var(--muted);
  margin-bottom:6px;
  display:flex;
  gap:8px;
  align-items:center;
}

.composer{
  display:flex;
  gap:8px;
  padding:12px;
  border-top:1px solid rgba(255,255,255,0.03);
  align-items:center;
  background:var(--panel);
  position:sticky;
  bottom:0;
}

.composer input{
  flex:1;
  padding:10px;
  border-radius:8px;
  border:1px solid rgba(255,255,255,0.04);
  background:transparent;
  color:inherit;
}

.composer button{
  padding:10px 16px;
  border-radius:8px;
  border:none;
  background:var(--accent);
  color:#002522;
  font-weight:700;
  cursor:pointer;
}

@media (max-width:800px){
  .app{grid-template-columns:1fr;grid-template-rows:auto 1fr}
  .sidebar{order:2}
  .chat-area{order:1}
  .message{max-width:100%}
}
</style>
</head>

<body>
  <div class="app">
    <aside class="sidebar">
      <div class="brand">Global Chat</div>

      <!-- 🏠 Dashboard Button -->
      <form action="Dashboard.jsp" method="get">
        <button type="submit" class="dashboard-btn">🏠 Dashboard</button>
      </form>

      <div class="users-section">
        <h4>Participants</h4>
        <div class="users-list">
<%
try{
    Statement st=DB.statement();
    ResultSet rs=st.executeQuery("SELECT name,emailid FROM info");
    while(rs.next()){
%>
          <div class="participant">
            <div class="avatar">👤</div>
            <div class="p-meta">
              <div class="p-name"><%=rs.getString(1)%></div>
              <div class="p-email"><%=rs.getString(2)%></div>
            </div>
          </div>
<%
    }
}catch(Exception e){}
%>
        </div>
      </div>
    </aside>

    <main class="chat-area">
      <section class="messages" id="chatBox">
<%
String s=(String)session.getAttribute("email");
try{
    Statement st=DB.statement();
    ResultSet rs=st.executeQuery("SELECT * FROM chat");
    while(rs.next()){
        String name=rs.getString(2);
        String email=rs.getString(1);
        String msg=rs.getString(3);
        if(!s.equals(email)){
%>
        <div class="message-row">
          <div class="avatar">👤</div>
          <div class="message">
            <div class="meta"><span><%=name%></span></div>
            <div class="body"><%=msg%></div>
          </div>
        </div>
<%
        } else {
%>
        <div class="message-row me">
          <div class="message me">
            <div class="meta"><span><%=name%></span></div>
            <div class="body"><%=msg%></div>
          </div>
          <div class="avatar">👤</div>
        </div>
<%
        }
    }
}catch(Exception e){}
%>
      </section>

      <form class="composer" method="post" action="Chat_ser">
        <input type="text" placeholder="Write a message..." name="statement" required />
        <button type="submit">Send</button>
      </form>
    </main>
  </div>

  <script>
    const chatBox = document.getElementById("chatBox");
    chatBox.scrollTop = chatBox.scrollHeight;
  </script>
</body>
</html>
