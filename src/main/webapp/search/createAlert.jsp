<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Making Alert</title>
</head>
<body>
	<%
	try{
		String clothingName = request.getParameter("clothingName");
		
		ApplicationDB db = new ApplicationDB(); 
		Connection con = db.getConnection(); 
		
		//Create sql statement 
		Statement stmt = con.createStatement(); 
		String user = (String)session.getAttribute("user"); 
		String sqlInsert = "insert into lookingFor(clothingName, username) values('" + clothingName + "','" + user + "');";
		System.out.println(sqlInsert);
		stmt.executeUpdate(sqlInsert);
	}catch(Exception E ){
		
	}
	%>
			
<form method="post" action="query.jsp">
<input type ="submit" value="back to search" >
</form>
		
</body>
</html>