# Collaborative Project Management and Submission Portal

A Java-based collaborative platform designed for efficient academic or team-based project management. This system enables users to create, update, and manage projects, communicate with teammates, upload submissions, and maintain progress visibility through a unified dashboard.

---

## ✅ Features

- **User Authentication**
  Secure login and signup for team members.

- **Project Lifecycle Management**
  Create projects, update descriptions, assign tasks, and track status.

- **Project Submission Module**
  Upload deliverables and maintain submission records.

- **Team Communication**
  Commenting and chat pages for collaboration.

- **Dashboard Analytics**
  Centralized summary of projects and activities.

- **Task Management Tools**
  Pending tasks, completed tasks, and to-do lists.

- **Green Room / Whiteboard**
  Shared brainstorming workspace within the platform.

---

## 🧩 Tech Stack

| Component | Technology |
|----------|------------|
| Frontend | HTML, JSP |
| Backend | Java Servlets, JSP |
| Database | MySQL |
| Deployment | Apache Tomcat |
| Build Tool | Apache Ant |
| JDBC Driver | `mysql-connector-java-5.0.7-bin.jar` |

---

## 📂 Project Structure

```
Project/
│
├── src/                        # Java source logic and controllers
├── web/                        # JSP views and static content
├── dist/                       # Build artifacts
├── WEB-INF/                    # Config and deployment descriptors
├── mysql-connector-java-5.0.7-bin.jar
└── build.xml                   # Ant build script
```

Primary UI pages include:
`Dashboard.jsp`, `AllProject.jsp`, `AddProject.jsp`, `Submission.jsp`, `Comments.jsp`, `Login.html`, `Sign.html` and more.

---

## 🔧 Installation and Setup

1️⃣ Clone or extract the repository  
```bash
git clone <repository-url>
```

2️⃣ Open in NetBeans or any Java EE IDE

3️⃣ Configure MySQL database  
- Create a database (name must match configuration in code)
- Import SQL schema if provided

4️⃣ Verify JDBC driver included in classpath

5️⃣ Deploy to Apache Tomcat 8+  
Use IDE deployment or Ant script

```bash
ant build
ant run
```

6️⃣ Launch the application in browser  
```
http://localhost:8080/<project-context>/
```

---

## 📌 Future Improvements

- Role-based access control
- UI modernization and better responsiveness
- WebSocket-based live chat
- Enhanced notifications and reminders
- Improved file storage and versioning

---

## Team / Contributors
This is a 4-person group project:

- **Anubhab Das** — GitHub: [@anubhab7105](https://github.com/anubhab7105)
- **Pranay Ojha** — GitHub: [@pranayojha123](https://github.com/pranayojha123)
- **Charita Gopivarthnam** — GitHub: [@gcharita25](https://github.com/gcharita25)
- **Likith Kumar** — GitHub:[@Likithhub](https://github.com/Likithhub)|

---

## 📝 License

This project is developed for academic and learning purposes. Licensing details can be updated as necessary.

---

Thank you for exploring our project. Contributions and suggestions are welcome.
