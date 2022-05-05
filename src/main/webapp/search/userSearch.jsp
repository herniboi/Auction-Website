<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Search User</title>
</head>
<body>
<div style ="overflow-y:auto" align='center'>
<table border="2">
	<tr>
	<td>UserName</td>
	<td>UserID</td>
	<td>Rating</td>
	</tr>
	<% 
	try{ 
		
		ApplicationDB db = new ApplicationDB(); 
		Connection con = db.getConnection(); 
		
		Statement stmt = con.createStatement(); 
		
		String username = request.getParameter("userName");
		String sqlQuery = "select * from users where username != 'default_bid'";
		if(username != ""){
			sqlQuery += " and username = '" + username + "' or username like '" + username + "%'";
		}
		sqlQuery+=";";
		System.out.println(sqlQuery);
		ResultSet result = stmt.executeQuery(sqlQuery);
		
		while(result.next()){
			System.out.println(result.getString("username"));
			System.out.println(result.getInt("user_id"));
			System.out.println(result.getInt("rating"));
			%>
			<tr>
			<td><%= result.getString("username") %></td>
			<td><%= result.getInt("user_id") %></td>
			<td><%= result.getInt("rating") %></td>
			</tr>
			<% 
		}		
	} catch (Exception E){
		
	}
	%>
	
</table>
</div>
<div align='center'> 

		<form method="post" action="userHistory.jsp">
		<table>
		<tr>    
		<td>UserName</td><td><input type="text" name="username"> <input type="submit" value="Access User Page"> </td> 
		</tr>
		<tr><td>
		</table>
		</form>
</div>
</body>
</html>