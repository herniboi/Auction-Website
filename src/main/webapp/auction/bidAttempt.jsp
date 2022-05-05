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
			String user_prev_highestbid = "";
			int item_id = Integer.parseInt((String)session.getAttribute("itemID")); 
			int initial_price = (Integer)session.getAttribute("initialPrice"); 
			int increment = (Integer)session.getAttribute("increment"); 
			int bid_value_new = Integer.parseInt((String)request.getParameter("increase_bid_modifier"));
			int max_bid_new = Integer.parseInt((String)request.getParameter("max_bid_modifier"));
			if (max_bid_new == 0)  max_bid_new = bid_value_new;
			int bid_value = 0;
			int max_bid = 0;
			int bid_on = 0;
			String set_user = "";
			int set_bid = 0;
			int set_max = 0;
			
			//current bid must be less than current max
			if(bid_value_new <= max_bid_new) {
			
			//get information for current and max bid
			ResultSet item_bid =  stmt.executeQuery("select * from bids where bid_value = (select max(bid_value) from bids where item_id = '"+item_id+"')"); 
					if(item_bid.next() && item_bid.getInt("bid_value") != 0) { //case where there have already been bids made on item
						bid_value = item_bid.getInt("bid_value");
						max_bid = item_bid.getInt("max_bid");
						user_prev_highestbid = item_bid.getString("username");
						bid_on = 1;
						
					} else {// case where there are no bids on current item
						bid_value = initial_price;
						max_bid = initial_price;
					}
			
			//update actual new user bid/max values
			bid_value_new = bid_value_new* increment  + bid_value ;
			max_bid_new = max_bid_new  * increment  + bid_value;
			
			// close the connection for find_item_id
			item_bid.close();
					
			//out.println(item_id +" ");
			//out.println("prev bidder: " + user_prev_highestbid +" ");
			//out.println("old current: " + bid_value +" ");
			//out.println("old max: " + max_bid +" ");
			//out.println("you: " + user +" ");
			//out.println("new current: " + bid_value_new +" ");
			//out.println("new max: " +max_bid_new);
			
		
				
				//auto auction logic
				if (bid_value_new <= bid_value) {
                    out.println("Please try again. You must bid at least more than the current amount \n");
                    %>
                    <button type="button" name="back" onclick="history.back()">Try Again</button>
                    <% 
					
				}else if (bid_value_new > bid_value) {
					
					if (bid_value_new > max_bid){
						//insert new bid with new current and new max\
						set_user = user;
						set_bid = bid_value_new;
						set_max = max_bid_new;
						out.println("User has successively placed a bid.");
						%>
	                    <button type="button" name="back" onclick="history.back()">Item Page</button>
	                    <% 
						
						
					}else if (bid_value_new == max_bid){
		
						if (max_bid_new > max_bid){
							//insert new bid with current bid = old max bid
							set_user = user;
							set_bid = max_bid;
							set_max = max_bid_new;
							out.println("User has successively placed a bid.");
							%>
		                    <button type="button" name="back" onclick="history.back()">Item Page</button>
		                    <% 
						}else if (max_bid_new <= max_bid){
							//'update' old bid with current bid = max
							set_user = user_prev_highestbid;
							set_bid = max_bid;
							set_max = max_bid;
							out.println("you did not bid high enough, try again");
							%>
		                    <button type="button" name="back" onclick="history.back()">Item Page</button>
		                    <% 
							
						}
					}else if (bid_value_new < max_bid){
						
						if (max_bid_new > max_bid){
							//insert new bid with current bid = old max bid
							set_user = user;
							set_bid = bid_value;
							set_max = max_bid_new;
							out.println("User has successively placed a bid.");
							%>
		                    <button type="button" name="back" onclick="history.back()">Item Page</button>
		                    <% 
						}else if (max_bid_new == max_bid){
							//'update' old bid with current bid = max
							set_user = user_prev_highestbid;
							set_bid = max_bid;
							set_max = max_bid;
							out.println("you did not bid high enough, try again");
							%>
		                    <button type="button" name="back" onclick="history.back()">Item Page</button>
		                    <% 
							
						}else if (max_bid_new < max_bid){
							//'update' old bid with old bid = new max bid
							set_user = user_prev_highestbid;
							set_bid = bid_value_new;
							set_max = max_bid;
							out.println("you did not bid high enough, try again");
							%>
		                    <button type="button" name="back" onclick="history.back()">Item Page</button>
		                    <% 
							
						}
					
				}
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
								
					//insert into watchlists automatically
					item_bid =  stmt.executeQuery("select * from watchlists where item_id = '"+item_id+"' and username = '"+user+"'"); 
					if(item_bid.next()){
					
					}else{
						insert = "INSERT INTO `watchlists` (item_id, username) " + "VALUES (?, ?)";
						ps = con.prepareStatement(insert);
						ps.setInt(1, item_id);
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