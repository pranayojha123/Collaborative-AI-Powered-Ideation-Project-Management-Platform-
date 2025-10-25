<%@page import="java.sql.*,db.DB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String s=request.getParameter("project_id");

String query="Select * from addproject where id='"+s+"'";
Statement st=DB.statement();
ResultSet rs=st.executeQuery(query);
if(rs.next()){
%>

<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Disaster Awareness Mapping Project</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
    
.comment-card {
    display: flex;
    flex-direction: column;
    gap: 12px;
    background: linear-gradient(135deg, rgba(30, 30, 47, 0.9), rgba(10, 10, 25, 0.9)),
                  url('https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=1920&q=80');
      background-size: cover;
      background-position: center;
    border-radius: 8px;
    padding: 14px 16px;
    margin-bottom: 16px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.25);
    backdrop-filter: blur(5px);
}

.comment-icon {
    font-size: 22px;
    color: #00eaff;
    margin-right: 8px;
}

.comment-body {
    color: white;
    font-size: 14px;
}

.comment-body h4 {
    color: #00eaff;
    font-size: 15px;
    font-weight: 600;
    margin: 0 0 4px 0;
}

.comment-body p {
    color: #f2f2f2;
    margin: 0;
    font-size: 14px;
    line-height: 1.4;
    background: rgba(255, 255, 255, 0.06);
    padding: 8px 10px;
    border-radius: 6px;
}

.comments textarea {
    background: rgba(255, 255, 255, 0.12);
    border: 1px solid rgba(255, 255, 255, 0.2);
    color: white;
    outline: none;
}

.comments textarea::placeholder {
    color: rgba(255, 255, 255, 0.7);
}

.btn:hover {
    opacity: 0.9;
    transform: translateY(-1px);
    transition: all 0.2s ease;
}

::-webkit-scrollbar {
    width: 8px;
}
::-webkit-scrollbar-thumb {
    background: rgba(255, 255, 255, 0.3);
    border-radius: 6px;
}
::-webkit-scrollbar-thumb:hover {
    background: rgba(255, 255, 255, 0.5);
}

        
        
        :root {
            --blue-900: #1e5f85;
            --blue-700: #2b7aa3;
            --muted: #f3f7fa;
            --card: #f6fbff;
            --text: #2b3b45;
        }

        * {
            box-sizing: border-box
        }

        body {
            margin: 0;
            font-family: 'Poppins', system-ui, -apple-system, 'Segoe UI', Roboto, 'Helvetica Neue', Arial;
            color: var(--text);
            background: linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.4)), 
                  url('https://img.freepik.com/free-photo/still-life-books-versus-technology_23-2150062913.jpg?t=st=1760017330~exp=1760020930~hmac=204660f69fcd208d4227fb07fbe5a417fabef27386f32f927a101a878a126502&w=2000'); 
            min-height: 100vh;
            display: flex;
            align-items: flex-start;
            justify-content: center;
            padding: 40px 20px;
            background-attachment: fixed;
            background-size: cover;
            backdrop-filter: blur(5px);
        }

        .page {
            width: 770px;
            background: rgba(255, 255, 255, 0.06);
            border-radius: 6px;
            box-shadow: 0 6px 20px rgba(28, 46, 66, 0.12);
            overflow: hidden;
            
        }

        header {
            background: linear-gradient(117deg, rgba(63, 94, 251, 0.722) 0%, rgba(252, 70, 106, 0.695) 100%);
            color: white;
            padding: 18px 26px;
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .logo {
            width: 48px;
            height: 48px;
            border-radius: 6px;
            background: rgba(255, 255, 255, 0.12);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }

        header h1 {
            font-size: 20px;
            margin: 0;
            font-weight: 700
        }

        header p {
            margin: 0;
            font-size: 12px;
            opacity: 0.92
        }

        .content {
            padding: 26px
        }

        .section {
            display: flex;
            gap: 14px;
            align-items: flex-start;
            margin-bottom: 18px
        }

        .icon {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: var(--muted);
            display: flex;
            align-items: center;
            justify-content: center;
            color:rgb(255, 122, 144) ;
            font-size: 16px;
            flex: 0 0 36px;
            margin-top: 6px
        }

        .card {
            background: var(--card);
            padding: 14px 16px;
            border-radius: 6px;
            border: 1px solid rgba(60, 90, 120, 0.05);
            flex: 1;
            box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.6)
        }
      

        .card h3 {
            margin: 0 0 8px 0;
            font-size: 14px;
            color: var(--blue-900);
            display: flex;
            align-items: center;
            gap: 8px
        }

        .card p {
            margin: 0;
            font-size: 13px;
            color: #3e525f;
            line-height: 1.5
        }

        .muted-list {
            font-size: 13px;
            color: #0fb7ff
        }

        .divider {
            height: 1px;
            background: linear-gradient(90deg, transparent, rgba(0, 0, 0, 0.06), transparent);
            margin: 18px 0
        }

        .timeline {
            padding: 12px 14px;
            border-radius: 6px;
            background: var(--card);
            border: 1px solid rgba(60, 90, 120, 0.05)
        }

        .timeline ul {
            margin: 0;
            padding-left: 18px
        }

        .timeline li {
            margin-bottom: 6px
        }

        .comments {
            margin-top: 12px
        }

        textarea {
            width: 100%;
            min-height: 80px;
            padding: 12px;
            border-radius: 6px;
            border: 1px solid rgba(60, 90, 120, 0.08);
            resize: vertical;
            font-family: inherit
        }

        .btn {
            display: inline-block;
            padding: 9px 14px;
            border-radius: 6px;
              background: linear-gradient(117deg, rgba(63, 94, 251, 0.722) 0%, rgba(252, 70, 106, 0.695) 100%);;
            color: white;
            border: none;
            font-weight: 600;
            margin-top: 10px;
            cursor: pointer
        }

        @media (max-width:820px) {
            .page {
                width: 100%;
            }

            body {
                padding: 18px
            }
        }
    </style>
</head>

<body>
   

    <div class="page" role="main">
        <header>
            <div class="logo"><i class="fas fa-globe"></i></div>
            <div>
                <h1><%=rs.getString(1)%></h1>
                <p>Empowering communities through innovation and awareness</p>
            </div>
        </header>

        <div class="content">

            <div class="section">
                <div class="icon"><i class="fas fa-bullseye"></i></div>
                <div class="card">
                    <h3><i class="fas fa-circle" style="font-size:10px;opacity:0.6"></i> Problem Statement</h3>
                    <p><%=rs.getString(3)%></p>
                </div>
            </div>

            <div class="section">
                <div class="icon"><i class="fas fa-file-alt"></i></div>
                <div class="card">
                    <h3>Project Description</h3>
                    <p><%=rs.getString(2)%></p>
                </div>
            </div>

            <div class="section">
                <div class="icon"><i class="fas fa-users"></i></div>
                <div class="card">
                    <h3>Other Details</h3>
                    <p class="muted-list"><%=rs.getString(4)%></p>
                </div>
            </div>

            <div class="section">
                <div class="icon"><i class="fas fa-calendar-alt"></i></div>
                <div class="card timeline">
                    <h3>Project Timeline</h3>
                    <ul>
                        <li>Phase 1: Problem statement release &amp; registrations</li>
                        <li>Phase 2: Student submissions and review process</li>
                        <li>Phase 3: Result announcement and felicitation</li>
                    </ul>
                </div>
            </div>

            <div class="divider"></div>

            <div class="comments">
                
                
                
                <h3 style="font-size:14px;margin-bottom:8px;color:white"><i class="fas fa-comment"></i>
                    Comments</h3>
                <div class="comment-card">
  <div class="comment-icon"><i class="fas fa-user-circle" style="color:white;"></i></div>
  <div class="comment-body" style="color:white;">
                <%
                Statement st1 = DB.statement();
                String o = "Select * from comments where id='" + s + "'";
                ResultSet rs2 = st1.executeQuery(o);
                while(rs2.next())
                {
%>
  
    <div class="comment-header">
      <h4 style="color:#00eaff;"><%= rs2.getString(2) %></h4>
      <p ><%= rs2.getString(4) %></p>
    </div>
    
 

<%
                } 
                
%>
 </div>
</div>
                <form action="Comment_ser" method="post">
                <textarea placeholder="Share your thoughts or feedback..." name="statements"></textarea>
                <br>
                 <input name="project_id" value="<%=s%>"  hidden>
                <button class="btn">Post Comment</button>
                </form>
            </div>

        </div>
    </div>
</body>
<%}%>
</html>