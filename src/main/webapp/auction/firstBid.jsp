<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Bid attempt</title>
</head>
<body>
	<%
	
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		//get values from buyer page bid attempt
		String setUser = (String)session.getAttribute("user"); 
		String itemIds = request.getParameter("itemId");
		int itemId = Integer.valueOf(itemIds);
		ResultSet getInitPrice = stmt.executeQuery("select * from clothing where itemId = '"+itemId+"'");
		int setBid = 0;
		int setMax = 0;
		if (getInitPrice.next()){
			setBid = getInitPrice.getInt("initialPrice");
			setMax = getInitPrice.getInt("initialPrice");
			
			String insert = "INSERT INTO `bids` (itemId, username, bidValue, maxBid, dateTime) " + "VALUES (?, ?, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setInt(1, itemId);
			ps.setString(2, setUser);
			ps.setInt(3, setBid);
			ps.setInt(4, setMax);
			ResultSet getCurrentTime = stmt.executeQuery("SELECT CURRENT_TIMESTAMP");
			if(getCurrentTime.next()){
						ps.setTimestamp(5, getCurrentTime.getTimestamp("CURRENT_TIMESTAMP"));
						// run the update.
						ps.executeUpdate();
			}
			
			insert = "INSERT INTO `watchlists` (itemId, username) " + "VALUES (?, ?)";
			ps = con.prepareStatement(insert);
			ps.setInt(1, itemId);
			ps.setString(2, setUser);
			
			ps.executeUpdate();
			out.println("You have successfully placed an initial bid on the item.");
			%> 
			<br>
			<form method="post" action="../auction/redirectAuction.jsp">
			<input type="submit" value="Return to Auction">
			</form>
		<br>	
			<% 
		}else{
			out.println("An error has occured.");
			%>
			<button type="button" name="back" onclick="history.back()">Try Again.</button>
		<%
		}
		
		
	%>
	
	

</body>
</html>