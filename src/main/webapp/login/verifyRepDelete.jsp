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
			
			ResultSet loginInfo = stmt.executeQuery("select * from customerservicerep where username='"+username+"'");
			if(loginInfo.next() && username != null && username.length() != 0) {
				PreparedStatement ps = con.prepareStatement("delete from customerservicerep where username=?");
				ps.setString(1, username);
				//Run the query against the DB
				ps.executeUpdate();
				
				out.println("User account has been successfully deleted."); %>
				
				<form method="post" action="../adminHomePage.jsp">
    			<input type ="submit" value="Back" >

    			</form>
				<%
			} else {
				out.println("Invalid username or password. Please try again."); %>
				<button type="button" name="back" onclick="history.back()">Try Again.</button>
				<%
						
			}
		} catch (Exception e) {
			//out.print(e);
			out.println("Login Failed. Invalid login credentials.!");%>
			<button type="button" name="back" onclick="history.back()">Try Again.</button>
		<%
		}
		
	%>
	
	

</body>
</html>