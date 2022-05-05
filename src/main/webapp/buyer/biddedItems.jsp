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
	

<div align='center'> 

<b>RU Clothing Auction House</b>



<!-- logout form  -->			  
	<br>
		<form method="post" action="../login/logoutCustomer.jsp">
		<input type="submit" value="Logout">
		</form>
	<br>
	
<!-- go back to auction form  -->			  
	<br>
		<form method="post" action="../auction/redirectAuction.jsp">
		<input type="submit" value="User Options">
		<button type="button" name="back" onclick="history.back()">Go Back</button>
		</form>
	<br>	

<hr noshade size="16">
<b><br>Auction: This table contains the list of all the items the user has bid on.</br></b>
<table border="2">
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
			// Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			String user = (String)session.getAttribute("user"); 
			
			// Create a SQL statement
			Statement stmt = con.createStatement();
			
			
			ResultSet items_info = stmt.executeQuery("select * from items where item_id in (select item_id from bids where bid_value in (select max(bid_value) from bids where username = '"+user+"'group by item_id) and username = '"+user+"') ");
			while(items_info.next()) {
				%>
				<tr>
				<td><%=items_info.getInt("item_id") %></td>
				<td><%=items_info.getString("name") %></td>
				<td><%=items_info.getString("clothing_type") %></td>
				<td><%=items_info.getInt("initial_price") %></td>
				<td><%=items_info.getInt("increment") %></td>
				<td><%=items_info.getTimestamp("start_date") %></td>
				<td><%=items_info.getTimestamp("end_date") %></td>
				<td><%=items_info.getInt("rating") %></td>
				<td><%=items_info.getString("username") %></td>
				</tr>
<%
			}
				
		} catch (Exception e) {
			// out.print(e);
			out.println("an error has occurred.");%>
			<button type="button" name="back" onclick="history.back()">Try Again.</button>
		<%
		}
		
	%>

</table>
</div>

<div align='center'> 

		<form method="post" action="../auction/requestItem.jsp">
		<table>
		<tr>    
		<td>Item ID</td><td><input type="text" name="item_id"> <input type="submit" value="Access Item Page"> </td> 
		</tr>
		<tr><td>
		</table>
		</form>


</div>




</html>