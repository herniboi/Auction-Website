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
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			Statement stmt = con.createStatement();
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String email = request.getParameter("email");
			
			ResultSet loginInfo = stmt.executeQuery("select * from users where username='"+username+"'");
			
			if(loginInfo.next()) {
				if (username != null || username.length() != 0) {
					if(password != null || password.length() != 0) {
						String update = "update users set password=? where username=?";
						PreparedStatement ps = con.prepareStatement(update);
						ps.setString(1, password); ps.setString(2, username);;
						ps.executeUpdate();
						
						out.println("User account password has been successfully updated.");
					}
					if(email != null || email.length() != 0) {
						String update = "update users set email=? where username=?";
						PreparedStatement ps = con.prepareStatement(update);
						ps.setString(1, email); ps.setString(2, username);;
						ps.executeUpdate();
						
						out.println("User account email has been successfully updated.");
					}
				}
				%>
					<form method="post" action="repHome.jsp">
    			<input type ="submit" value="Back" >
    			</form>
    		<%
			} else {
				out.println("Invaid username");%>
				<button type="button" name="back" onclick="history.back()">Try Again.</button>
			<%
			}
		} catch (Exception e) {
			out.println("Login Failed. Invalid login credentials");%>
			<button type="button" name="back" onclick="history.back()">Try Again.</button>
		<%
		}
	%>
</body>
</html>