<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Item</title>
</head>
<body>

	<%
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get parameters from the HTML form at the index.jsp
			String item_id = request.getParameter("item_id");
			
			//name of user
			String username = (String)session.getAttribute("user");
			
			%>
			<div align="center">
			<b>Auction Bid Information</b>
			<!-- logout form  -->			  
			<br>
			<form method="post" action="../auction/redirectAuction.jsp">
				<input type="submit" value="Auction Page">
			</form>
			<br>
			
			
			
			<b>Item ID: <%=item_id%></b>
			</div>
			
			<hr noshade size="16">
			
			<% 
			
			// query for current max bid
			ResultSet current_bid = stmt.executeQuery("select max(bid_value) from bids where item_id='"+item_id+"'");
			boolean bid_exists = false;
			int current_bid_num = -1;
			int current_user_max = -1;
			if(current_bid.next() && current_bid.getInt("max(bid_value)") != 0) {
				%>
				<div align="center">
				<table border="1">
				<tr>
					<th>Current Bid</th>
					<td>$ <%=current_bid.getInt("max(bid_value)") %></td>
				</tr>
				</table>
				</div>
				<% 
				bid_exists = true;
				current_bid_num = current_bid.getInt("max(bid_value)");
			} else {
				%>
				<div align="center">
				<table border="1">
				<tr>
					<th>Current Bid</th>
					<td>N/A</td>
				</tr>
				</table>
				</div>
				<% 
				bid_exists = false;
			}
			current_bid.close();			
			
			// query for user bid
			
			ResultSet user_bid = stmt.executeQuery("select * from bids where bid_value in (	select max(bid_value) from bids where item_id = '"+item_id+"' and username='"+username+"' group by item_id)and item_id = '"+item_id+"' and username='"+username+"'");
			int current_user_bid = -1;
			boolean has_bid = false;
			if(user_bid.next() && user_bid.getInt("bid_value") != 0) {
				%>
				<div align="center">
				<table border="1">
				<tr>
					<th>User Bid</th>
					<td>$ <%=user_bid.getInt("bid_value") %></td>
				</tr>
				</table>
				</div>
				<% 
				has_bid = true;
				current_user_bid = user_bid.getInt("bid_value");
				current_user_max = user_bid.getInt("max_bid");
			} else {
				%>
				<div align="center">
				<table border="1">
				<tr>
					<th>User Bid</th>
					<td>N/A</td>
				</tr>
				</table>
				</div>
				<% 
				has_bid = false;
			}
			if(bid_exists) {
				if(has_bid) {
					// condition #1 - the user is the highest bid
					// condition #2 - the user got outbidded
					if(current_user_bid >= current_bid_num) {
						%> 
						<div align="center">
						<b><br>You currently have the highest bid on this item.</b>
						<b><br>Your maximum auto-bid is: $<%=current_user_max  %> </b>
						</div>
						<% 
						
					} else {
						%> 
						<div align="center">
						<b>Another user has placed a higher bid on this item.</b>
						</div>
						<% 
					}
				} else {
					// condition #3 - the bid exists but the user has not bidded
					%> 
					<div align="center">
					<b><br>You have not yet placed a bid on this item.</b>
					</div>
					<% 
				}
			} else {
				%> 
				<div align="center">
				<b><br>No-one has placed a bid on this item.</br></b>
				</div>
				<% 
			}
			user_bid.close();
			
			%>
			<div align="center">
			<button type="button" name="back" onclick="history.back()">Item Page</button>
			</div>
			<% 
			
			
			
			
			
	
			
		} catch (Exception e) {
			out.print(e);
			out.println("error has occured.");%>
			<button type="button" name="back" onclick="history.back()">Try Again.</button>
		<%
		}
		
	%>
	
	

</body>
</html>