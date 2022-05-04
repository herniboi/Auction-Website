<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>RU Clothing</title>
	</head>
	
	<body>

		Customer Service Representative Registration 
							  
	<br>
		<form method="post" action="verifyRepReg.jsp">
		<table>
		<tr>    
		<td>Username</td><td><input type="text" name="username"></td>
		</tr>
		<tr>
		<td>Password</td><td><input type="text" name="password"></td>
		</tr>
		<tr>    
		<td>Email</td><td><input type="text" name="email"></td>
		</tr>
		<tr><td>
		<br>
		</table>
		<input type="submit" value="Register"><button type="button" name="back" onclick="history.back()">Go Back</button>
		</form>
	<br>
	
	

</body>
</html>