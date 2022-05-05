<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	try{
		int itemId = Integer.parseInt(request.getParameter("itemId"));
		ApplicationDB db = new ApplicationDB(); 
		Connection con = db.getConnection(); 
		
		Statement stmt = con.createStatement(); 
		String sql = "select * from bids where bids.itemId = " + itemId + " and username != 'defaultBid';";
		ResultSet result = stmt.executeQuery(sql);
		%>
		
		<div align='center'>
		<p>Bids</p>
		<table border="2">
		<tr>
		<td>Item ID </td>
		<td>UserName</td>
		<td>Bid Value</td>
		<td>Max Bid </td>
		<td>Date Time</td>
		</tr>
		<% 
		while(result.next()){
			%>
			<tr>
			<td><%= result.getInt("itemId") %></td>
			<td><%= result.getString("username") %></td>
			<td><%= result.getInt("bidValue") %></td>
			<td><%= result.getInt("maxBid") %></td>
			<td><%= result.getDate("dateTime") %></td>
			</tr>
			<% 
		}
		
		
	} catch(Exception E){
		
	}
	%>
</table>
</div>
<form method="post" action="query.jsp">
<input type ="submit" value="back to search" >
</form>
</body>
</html>