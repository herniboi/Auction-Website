<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Remove Alert</title>
</head>
<body>
	<%
	try{
		String itemname = request.getParameter("itemName");
		String sql = "delete from lookingfor where itemName = '" + itemname + "';";
		
		ApplicationDB db = new ApplicationDB(); 
		Connection con = db.getConnection(); 
		
		//Create sql statement 
		Statement stmt = con.createStatement(); 
		stmt.executeUpdate(sql);
	}catch(Exception E){
		
	}
	
	
	
	%>
<form method="post" action="query.jsp">
<input type ="submit" value="back to search" >
</form>
		
</body>
</html>