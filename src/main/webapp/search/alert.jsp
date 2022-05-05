<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create Alert</title>
</head>
<body>
		<form action = "createAlert.jsp">
			<table>
				<tr>
					<td>Clothing Name</td><td><input type="text" name="clothingName"></td>
				</tr>
			</table>
			<input type="submit" value = "createAlert">
		</form>
			

</body>
</html>