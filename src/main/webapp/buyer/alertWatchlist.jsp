<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>RU Clothing Site</title>
	</head>
	<body style="background-color:#CC0033;font-family:trebuchet">
	

<div align='center'> 
<h2 style='font-family:"Trebuchet", Trebuchet, monospace; color:white'>
RU Clothing WatchLists


<!-- logout form  -->			  
	<br>
		<form method="post" action="../login/logoutCustomer.jsp">
		<input type="submit" value="Logout" style='font-family: DengXian Light, Fantasy;'>
		</form>
	<br>
	
<!-- go back to auction form  -->			  
	<br>
		<form method="post" action="../auction/redirectAuction.jsp">
		<input type="submit" value="Login Page" style='font-family: DengXian Light, Fantasy;'>
		<button type="button" name="back" style='font-family: DengXian Light, Fantasy;' onclick="history.back()">Go Back</button>
		</form>
	<br>	

<hr noshade size="16">
<b><br>Watch Lists: These are the items that the user wants to keep an eye on.</br></b>
<table style='font-family:"Trebuchet", Trebuchet, monospace; font-size:80%; color:white' border = "2">
	<tr>
	<td>Item ID</td>
	<td>Name</td>
	<td>Type</td>
	<td>Initial Price</td>
	<td>Increment</td>
	<td>Start Date</td>
	<td>End Date</td>
	<td>Rating</td>
	<td>Seller</td>

<%
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			String user = (String)session.getAttribute("user"); 
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			
			
			
			
			ResultSet itemsInfo = stmt.executeQuery("select * from clothing where itemId in (select itemId from watchlists where username='"+user+"') and current_timestamp < endDate;");
			while(itemsInfo.next()) {
				%>
				<tr>
				<td><%=itemsInfo.getInt("itemId") %></td>
				<td><%=itemsInfo.getString("name") %></td>
				<td><%=itemsInfo.getString("clothingType") %></td>
				<td><%=itemsInfo.getInt("initialPrice") %></td>
				<td><%=itemsInfo.getInt("increment") %></td>
				<td><%=itemsInfo.getTimestamp("startDate") %></td>
				<td><%=itemsInfo.getTimestamp("endDate") %></td>
				<td><%=itemsInfo.getInt("rating") %></td>
				<td><%=itemsInfo.getString("username") %></td>
				</tr>
<%
			}
		} catch (Exception e) {
			//out.print(e);
			out.println("an error has occurred.");%>
			<button type="button" name="back" onclick="history.back()">Try Again.</button>
		<%
		}
		
	%>

</table>
</div>

<div align='center'> 
		<form method="post" action="../auction/requestItem.jsp">
		<table style='font-family:"Trebuchet", Trebuchet, monospace; color:white'>
		<tr>    
		<td>Item ID</td><td><input type="text" name="itemId" > 
			<input type="submit" value="Access Item Page" style='font-family: DengXian Light, Fantasy;'> </td> 
		</tr>
		</table>
		</form>


</div>




</html>