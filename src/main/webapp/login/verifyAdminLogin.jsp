<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get parameters from the HTML form at the index.jsp
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			
			ResultSet login_info = stmt.executeQuery("select * from admin where username='"+username+"' and password='"+password+"'");
			
			if(login_info.next()) {
				if(username.length() != 0 && username != null && password.length() != 0 && password != null) {
					session.setAttribute("admin", username);
					
					out.println("Login Success: " + username);
					response.sendRedirect("../adminHomePage.jsp");
				} else {
					out.println("Invaid username or password.");%>
					<button type="button" name="back" onclick="history.back()">Try Again.</button>
				<%
				}
			} else {
				out.println("Invaid username or password.");%>
				<button type="button" name="back" onclick="history.back()">Try Again.</button>
			<%
			}
		} catch (Exception e) {
			//out.print(e);
			out.println("Login Failed. Invalid login credentials");%>
			<button type="button" name="back" onclick="history.back()">Try Again.</button>
		<%
		}
		
	%>
	
	

</body>
</html>