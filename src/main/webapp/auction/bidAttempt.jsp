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
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			// getting the parameters to insert
			
			//get values from buyer page bid attempt
			String user = (String)session.getAttribute("user"); 
			String userPrevHighestbid = "";
			int itemId = Integer.parseInt((String)session.getAttribute("itemId")); 
			int initialPrice = (Integer)session.getAttribute("initialPrice"); 
			int increment = (Integer)session.getAttribute("increment"); 
			int bidValueNew = Integer.parseInt((String)request.getParameter("increaseBidModifier"));
			int maxBidNew = Integer.parseInt((String)request.getParameter("maxBidModifier"));
			if (maxBidNew == 0)  maxBidNew = bidValueNew;
			int bidValue = 0;
			int maxBid = 0;
			int bidOn = 0;
			String setUser = "";
			int setBid = 0;
			int setMax = 0;
			
			//current bid must be less than current max
			if(bidValueNew <= maxBidNew) {
			
			//get information for current and max bid
			ResultSet itemBid =  stmt.executeQuery("select * from bids where bidValue = (select max(bidValue) from bids where itemId = '"+itemId+"')"); 
					if(itemBid.next() && itemBid.getInt("bidValue") != 0) { //case where there have already been bids made on item
						bidValue = itemBid.getInt("bidValue");
						maxBid = itemBid.getInt("maxBid");
						userPrevHighestbid = itemBid.getString("username");
						bidOn = 1;
						
					} else {// case where there are no bids on current item
						bidValue = initialPrice;
						maxBid = initialPrice;
					}
			
			//update actual new user bid/max values
			bidValueNew = bidValueNew* increment  + bidValue ;
			maxBidNew = maxBidNew  * increment  + bidValue;
			
			// close the connection for find item ID
			itemBid.close();
					
			//Testing
			//out.println(itemId +" ");
			//out.println("prev bidder: " + userPrevHighestbid +" ");
			//out.println("old current: " + bidValue +" ");
			//out.println("old max: " + maxBid +" ");
			//out.println("you: " + user +" ");
			//out.println("new current: " + bidValueNew +" ");
			//out.println("new max: " +maxBidNew);
			
		
				
				//auto auction logic
				if (bidValueNew <= bidValue) {
                    out.println("Please try again. You must bid at least more than the current amount \n");
                    %>
                    <button type="button" name="back" onclick="history.back()">Try Again</button>
                    <% 
					
				}else if (bidValueNew > bidValue) {
					
					if (bidValueNew > maxBid){
						//insert new bid with new current and new max\
						setUser = user;
						setBid = bidValueNew;
						setMax = maxBidNew;
						out.println("User has successively placed a bid.");
						%>
	                    <button type="button" name="back" onclick="history.back()">Item Page</button>
	                    <% 
						
						
					}else if (bidValueNew == maxBid){
		
						if (maxBidNew > maxBid){
							//insert new bid with current bid = old max bid
							setUser = user;
							setBid = maxBid;
							setMax = maxBidNew;
							out.println("User has successively placed a bid.");
							%>
		                    <button type="button" name="back" onclick="history.back()">Item Page</button>
		                    <% 
						}else if (maxBidNew <= maxBid){
							//'update' old bid with current bid = max
							setUser = userPrevHighestbid;
							setBid = maxBid;
							setMax = maxBid;
							out.println("you did not bid high enough, try again");
							%>
		                    <button type="button" name="back" onclick="history.back()">Item Page</button>
		                    <% 
							
						}
					}else if (bidValueNew < maxBid){
						
						if (maxBidNew > maxBid){
							//insert new bid with current bid = old max bid
							setUser = user;
							setBid = bidValue;
							setMax = maxBidNew;
							out.println("User has successively placed a bid.");
							%>
		                    <button type="button" name="back" onclick="history.back()">Item Page</button>
		                    <% 
						}else if (maxBidNew == maxBid){
							//'update' old bid with current bid = max
							setUser = userPrevHighestbid;
							setBid = maxBid;
							setMax = maxBid;
							out.println("you did not bid high enough, try again");
							%>
		                    <button type="button" name="back" onclick="history.back()">Item Page</button>
		                    <% 
							
						}else if (maxBidNew < maxBid){
							//'update' old bid with old bid = new max bid
							setUser = userPrevHighestbid;
							setBid = bidValueNew;
							setMax = maxBid;
							out.println("you did not bid high enough, try again");
							%>
		                    <button type="button" name="back" onclick="history.back()">Item Page</button>
		                    <% 
							
						}
					
				}
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
								
					//insert into watchlists automatically
					itemBid =  stmt.executeQuery("select * from watchlists where itemId = '"+itemId+"' and username = '"+user+"'"); 
					if(itemBid.next()){
					
					}else{
						insert = "INSERT INTO `watchlists` (itemId, username) " + "VALUES (?, ?)";
						ps = con.prepareStatement(insert);
						ps.setInt(1, itemId);
						ps.setString(2, user);
						ps.executeUpdate();
					}
					
							
				} else {
					out.println("Please try again. The end-date must be a time period beyond the current time. \n");
					//out.println("successful insert");
					%>
					<form method="post" action="../auction/auctionHome.jsp">
					<input type ="submit" value="return home" >
					</form>
					<% 
				}
				
				
			}
		
		} else {
			out.println("bid value cannot be higher than the max"); %>
			<button type="button" name="back" onclick="history.back()">Try Again.</button>
			<%
		}
		} catch (Exception e) {
			out.print(e);
			out.println("something went wrong");%>
			<button type="button" name="back" onclick="history.back()">Try Again.</button>
		<%
		}
		
	%>
	
	

</body>
</html>