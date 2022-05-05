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
<b><br>Alert: The items shown below are the auctions where the user has won.</br></b>
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
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			String user = (String)session.getAttribute("user"); 
			String defaultBid = "defaultBid";
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			
			ResultSet itemsInfo = stmt.executeQuery("select * from items where itemId in (select t2.itemId from (select bids.itemId, bids.bidValue, bids.username from bids, (select max(bidValue) as bidValue, itemId from bids group by itemId) t0 where bids.bidValue = t0.bidValue and bids.itemId = t0.itemId and bids.username!= '"+defaultBid+"') as t1, (select *  from bids where bidValue in (select max(bidValue) from bids where username = '"+user+"' group by itemId) and username = '"+user+"' ) as t2 where t1.itemId = t2.itemId and t2.username = t1.username ) and endDate <= now()");
			
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
		<table>
		<tr>    
		<td>Item ID</td><td><input type="text" name="itemId"> <input type="submit" value="Access Item Page"> </td> 
		</tr>
		<tr><td>
		</table>
		</form>


</div>





</html>