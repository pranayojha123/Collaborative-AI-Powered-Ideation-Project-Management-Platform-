<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,db.DB"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Project Submission Portal</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Poppins", sans-serif;
        }

        body {
            background: linear-gradient(135deg, rgba(30, 30, 47, 0.9), rgba(10, 10, 25, 0.9)),
                  url('https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=1920&q=80');
      background-size: cover;
      background-position: center;
            background-size: cover;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            backdrop-filter: blur(5px);
        }

        .container {
            text-align: center;
            color: white;
            width: 500px;
        }

        h1 {
            font-size: 28px;
            margin-bottom: 5px;
        }

        .subtitle {
            font-size: 14px;
            opacity: 0.8;
            margin-bottom: 25px;
        }

        .form-card {
            background: rgba(255, 255, 255, 0.15);
            padding: 25px;
            border-radius: 15px;
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            font-size: 14px;
            margin: 10px 0 5px;
            text-align: left;
            color: white;
        }

        input,
        select,
        textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 12px;
            border-radius: 6px;
            border: none;
            outline: none;
            font-size: 14px;
        }

        textarea {
            height: 80px;
            resize: none;
        }
        
        button {
            width: 100%;
            padding: 12px;
            background-color: #ffffff;
            color: #5a00ff;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover {
            background: linear-gradient(117deg, rgba(63, 94, 251, 0.722) 0%, rgba(252, 70, 106, 0.695) 100%);
            color: white;
        }
    </style>
</head>

<body>
<%
    String s="Select name,id from addproject";
    Statement st=DB.statement();
    ResultSet rs=st.executeQuery(s);
%>
    <div class="container">
        <h1>Project Submission Portal</h1>
        <p class="subtitle">Submit your project details and collaborate efficiently.</p>

        <form class="form-card" action="Submission_ser" method="post">
            <label>Select Project</label>
        
            <select name="select" required="">
                <option>-- Select a Project --</option>
                <%while(rs.next()){%>
                <option><%=rs.getString(1)%></option>
                <%}%>
            </select>

           

            <label>GitHub Project Link</label>
            <input type="url" placeholder="https://github.com/username/project" name="link">

            <label>Other Deatils</label>
            <input class="file" name="other">

            <button type="submit">Submit Project </button>
        </form>
    </div>

</body>

</html>