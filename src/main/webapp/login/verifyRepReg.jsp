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
			String email = request.getParameter("email");
			
			
			ResultSet loginInfo = stmt.executeQuery("select * from customerservicerep where username='"+username+"'");
			if(loginInfo.next() && username != null && username.length() != 0) {
				out.println("The username " + username + " already exists within the database. Please try again."); %>
				<button type="button" name="back" onclick="history.back()">Try Again.</button>
				<% 
			} else if (username == null || username.length() == 0 || password == null || password.length() == 0) {
				out.println("Invalid username or password. Please try again."); %>
				<button type="button" name="back" onclick="history.back()">Try Again.</button>
				<%
						
			} else {
				String insert = "insert into customerservicerep(username, password, email)" + "VALUES (?, ?, ?)";
				PreparedStatement ps = con.prepareStatement(insert);
				ps.setString(1, username); ps.setString(2, password); ps.setString(3, email);
				//Run the query against the DB
				ps.executeUpdate();
				
				out.println("Customer representative account has been successfully created."); %>
				
				<form method="post" action="../adminHomePage.jsp">
    			<input type ="submit" value="Back" >

    			</form>
				<%
			}
		} catch (Exception e) {
			//out.print(e);
			out.println("Failed to make new representative");%>
			<button type="button" name="back" onclick="history.back()">Try Again.</button>
		<%
		}
		
	%>
	
	

</body>
</html>