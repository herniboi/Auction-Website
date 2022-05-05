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
			String itemId = request.getParameter("itemId");
			
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
			
			
			
			<b>Item ID: <%=itemId%></b>
			</div>
			
			<hr noshade size="16">
			
			<% 
			
			// query for current max bid
			ResultSet currentBid = stmt.executeQuery("select max(bidValue) from bids where itemId='"+itemId+"'");
			boolean bidExists = false;
			int currentBidNum = -1;
			int currentUserMax = -1;
			if(currentBid.next() && currentBid.getInt("max(bidValue)") != 0) {
				%>
				<div align="center">
				<table border="1">
				<tr>
					<th>Current Bid</th>
					<td>$ <%=currentBid.getInt("max(bidValue)") %></td>
				</tr>
				</table>
				</div>
				<% 
				bidExists = true;
				currentBidNum = currentBid.getInt("max(bidValue)");
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
				bidExists = false;
			}
			currentBid.close();			
			
			// query for user bid
			
			ResultSet userBid = stmt.executeQuery("select * from bids where bidValue in (	select max(bidValue) from bids where itemId = '"+itemId+"' and username='"+username+"' group by itemId)and itemId = '"+itemId+"' and username='"+username+"'");
			int currentUserBid = -1;
			boolean hasBid = false;
			if(userBid.next() && userBid.getInt("bidValue") != 0) {
				%>
				<div align="center">
				<table border="1">
				<tr>
					<th>User Bid</th>
					<td>$ <%=userBid.getInt("bidValue") %></td>
				</tr>
				</table>
				</div>
				<% 
				hasBid = true;
				currentUserBid = userBid.getInt("bidValue");
				currentUserMax = userBid.getInt("maxBid");
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
				hasBid = false;
			}
			if(bidExists) {
				if(hasBid) {
					// condition #1 - the user is the highest bid
					// condition #2 - the user got outbidded
					if(currentUserBid >= currentBidNum) {
						%> 
						<div align="center">
						<b><br>You currently have the highest bid on this item.</b>
						<b><br>Your maximum auto-bid is: $<%=currentUserMax  %> </b>
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
			userBid.close();
			
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