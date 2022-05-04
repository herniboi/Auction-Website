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

		Request Customer Account Deletion
							  
	<br>
		<form method="post" action="verifyCustomerDelete.jsp">
		<table>
		<tr>    
		<td>Username</td><td><input type="text" name="username"></td>
		</table>
		<input type="submit" value="Delete Account"><input type="submit" value="Go Back" formaction = "../frontPage.jsp">
		</form>
	<br>
	
	

</body>
</html>