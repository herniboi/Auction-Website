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
		String set_user = (String)session.getAttribute("user"); 
		String item_ids = request.getParameter("item_id");
		int item_id = Integer.valueOf(item_ids);
		ResultSet get_init_price = stmt.executeQuery("select * from items where item_id = '"+item_id+"'");
		int set_bid = 0;
		int set_max = 0;
		if (get_init_price.next()){
			set_bid = get_init_price.getInt("initial_price");
			set_max = get_init_price.getInt("initial_price");
			
			String insert = "INSERT INTO `bids` (item_id, username, bid_value, max_bid, date_time) " + "VALUES (?, ?, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setInt(1, item_id);
			ps.setString(2, set_user);
			ps.setInt(3, set_bid);
			ps.setInt(4, set_max);
			ResultSet get_current_time = stmt.executeQuery("SELECT CURRENT_TIMESTAMP");
			if(get_current_time.next()){
						ps.setTimestamp(5, get_current_time.getTimestamp("CURRENT_TIMESTAMP"));
						// run the update.
						ps.executeUpdate();
			}
			
			insert = "INSERT INTO `watchlists` (item_id, username) " + "VALUES (?, ?)";
			ps = con.prepareStatement(insert);
			ps.setInt(1, item_id);
			ps.setString(2, set_user);
			
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