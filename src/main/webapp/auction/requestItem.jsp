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
<body style="background-color:#CC0033;font-family:trebuchet">

<div align="center"> 
<form action="../auction/redirectAuction.jsp">
<input type="submit" value="Auction Page" style='font-family: DengXian Light, Fantasy;'>
</form>
</div>

	<%
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get parameters from the HTML form at the index.jsp
			String itemId = request.getParameter("itemId");
			session.setAttribute("itemId", itemId);
			
			
			// creates an empty to query
			String query = "";
			
			// used to generate the generic item info
			ResultSet itemRequest = stmt.executeQuery("select * from clothing where itemId='"+itemId+"'and endDate > now()");
			
			// used to generate the specific item info
			ResultSet specificItem;
			
			// used to generate the currentBid item info
			ResultSet itemBid;
			
			// user attribute used to allow whether they can bid or not
			String user = (String)session.getAttribute("user"); 
			String defaultBid = "defaultBid";
		
			if(itemRequest.next()) {	
				int initialprice = itemRequest.getInt("initialPrice");
				session.setAttribute("initialPrice",itemRequest.getInt("initialPrice"));
				session.setAttribute("increment",itemRequest.getInt("increment"));
				int itemid = itemRequest.getInt("itemId");
				int incrementamt = itemRequest.getInt("increment");
				String username = itemRequest.getString("username");
				String clothingtype = itemRequest.getString("clothingType");%>
				
				<% // table to show item descriptions %>
			
				<div align="center">
				<br>
				<b><br><h2 style='font-family:"Trebuchet", Trebuchet, monospace; color:white'>RU Clothing Item Page</h2></br></b>
				</h2>
				<table border="2" style='font-family:"Trebuchet", Trebuchet, monospace; font-size:80%; color:white'>
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
			
				<tr>
				<td><%=itemRequest.getInt("itemId") %></td>
				<td><%=itemRequest.getString("name") %></td>
				<td><%=itemRequest.getString("clothingType") %></td>
				<td><%=initialprice%></td>
				<td><%=itemRequest.getInt("increment") %></td>
				<td><%=itemRequest.getTimestamp("startDate") %></td>
				<td><%=itemRequest.getTimestamp("endDate") %></td>
				<td><%=itemRequest.getInt("rating") %></td>
				<td><%=itemRequest.getString("username") %></td>
				</tr>
				</table>
				
				<hr noshade size="16">
				</div>
			
			
			<% 
			specificItem = stmt.executeQuery("select * from "+clothingtype+" where itemId = "+itemid+" ");
			if(specificItem.next()) {%>
				<%// item specifications (desc) %>
				<div align="center">
					<h2 style='font-family:"Trebuchet", Trebuchet, monospace; color:white'>
				<b><br>Item Descriptions</br></b>
					</h2>
				<table border="2" style='font-family:"Trebuchet", Trebuchet, monospace; font-size:80%; color:white'>
				<tr>
				<td>Item Size</td>
				<td>Gender</td>
				<td>Color</td>
				<td>Type</td>
				<td>Clothing Type</td>
				</tr>
				</div>
				<tr>
				<td><%=specificItem.getString("size") %></td>
				<td><%=specificItem.getString("gender") %></td>
				<td><%=specificItem.getString("color") %></td>
				<td><%=specificItem.getString("type") %></td>
				<td><%=specificItem.getString("clothingType") %></td>
				</tr>
				</table>
				
				<div align="center">
				<form method="post" action="../buyer/watchlistInsert.jsp">
				<input type="submit" value="Add Item To Watch List" style='font-family: DengXian Light, Fantasy;'>
				</form>
				
				</div>
				<hr noshade size="16">
				<h2 style='font-family:"Trebuchet", Trebuchet, monospace; color:white'>
				<b><br>Auction Information</br></b>
				</h2>
				<%
				// bidding session. this should only occur if the user attribute in session != username
				// if the user is the seller, they cannot see the bid option.
				if(user.equals(username)) {
					%>
					<div align="center">
					<table border="1" style='font-family:"Trebuchet", Trebuchet, monospace; font-size:80%; color:white'>
					<tr>
						<th>Seller Status</th>
						<td>Yes</td>
					</tr>

					</table>
					
					</div><% 
				} else {
					// condition where user is not a seller but they are a buyer --> they have access to the bid
					%>
					<div align="center">
					<table border="1" style='font-family:"Trebuchet", Trebuchet, monospace; font-size:80%; color:white'>
					<tr>
						<th>Seller Status</th>
						<td>N/A</td>
					</tr>

					</table>
					
					</div>
					<% 
					
				
					
					itemBid =  stmt.executeQuery("select max(bidValue) from bids where itemId='"+itemid+"'"); 
					if(itemBid.next() && itemBid.getInt("max(bidValue)") != 0) {
						%>
						<div align="center">
						<table border="1" style='font-family:"Trebuchet", Trebuchet, monospace; font-size:80%; color:white'>
						<tr>
							<th>Current Bid</th>
							<td>$ <%=itemBid.getInt("max(bidValue)") %></td>
						</tr>
						</table>
						</div>
						<% 
					} else {
						%>
						<div align="center">
						<table border="1" style='font-family:"Trebuchet", Trebuchet, monospace; font-size:80%; color:white'>
						<tr>
							<th>Current Bid(Initial Price)</th>
							<td>$ <%=initialprice%></td>
						</tr>
						</table>	<hr noshade size="16">
						</div>
						<% 
					}
			
					//now check if user can make the first bid on the item rather than subsequent bids
					 itemBid =  stmt.executeQuery("select * from bids  where itemId = '"+itemId+"' and username != 'defaultBid' "); 
					if(itemBid.next()){
						// form to bid
						%>
						<br>
					
						<div align='center'> 
						<form method="post" action="../auction/bidAttempt.jsp">
						<table style='font-family:"Trebuchet", Trebuchet, monospace; font-size:130%; color:white'>
						<tr><td>Increase bid by</td><td><input type="number" value = 0 name="increaseBidModifier"> * $<% out.println(" "+ incrementamt ); %></td></tr>
						<tr><td>Set max bid(Optional)</td><td><input type="number" value = 0 name="maxBidModifier"> * $<% out.println(" "+ incrementamt); %></td></tr>
						</table>
						<input type="submit" value="Input Bid" style='font-family: DengXian Light, Fantasy;'>
						</form>
						
						</div>
						
						<hr noshade size="16">
						<h2 style='font-family:"Trebuchet", Trebuchet, monospace; color:white'>
						<b><br>Bid Status </br></b>
						</h2>
						<div align="center">
						<form method="post" action="../auction/bidCheck.jsp">
	  					<input type="radio" id="item" name="itemId" value="<%=itemid%>" style='font-family: DengXian Light, Fantasy;' required>
	  					<label for="item">Item ID: <%=itemid%></label><br>
	  					<input type="submit" value="Check Bid Status" style='font-family: DengXian Light, Fantasy;'><input type="reset" style='font-family: DengXian Light, Fantasy;'>
						</form>
						</div>
						
						
						<% 
					}else{
						%>
							<div align="center">
							<form method="post" action="../auction/firstBid.jsp">
								<h2 style='font-family:"Trebuchet", Trebuchet, monospace; color:white'>
		 					<label for="item">Make initial bid? </label><br>
							 	</h2>
		 					Yes<input type="radio" id="item" name="itemId" value="<%=itemid%>" style='font-family: DengXian Light, Fantasy;'required><br>
		 					<input type="submit" value="submit" style='font-family: DengXian Light, Fantasy;'>
							</form>
							</div>
						
						<% 
					}
					
					
					
				}
				%>
				<% 
				} else {
					out.println("The requested page for the item id does not exist.");
				%>
					<button type="button" name="back" onclick="history.back()">Try Again.</button>
				<%
				}
			} else {
				//check if the auction has ended first
		
				ResultSet dateRequest = stmt.executeQuery("select * from clothing where itemId='"+itemId+"'and endDate < now()");
				
				if(dateRequest.next()) {	
					
					//this item has ended - get the max bid for it and compare to current user, store minWin first
					int reserve = dateRequest.getInt("minWin");	
							
					//display item info here	
					int initialprice = dateRequest.getInt("initialPrice");
					String clothingtype = dateRequest.getString("clothingType");
					int itemid = dateRequest.getInt("itemId");
					 // table to show item descriptions %>
				
					<div align="center">
						<h2 style='font-family:"Trebuchet", Trebuchet, monospace; color:white'>
					<b><br>RU Clothing Item</br></b>
						</h2>
					<table border="2" style='font-family:"Trebuchet", Trebuchet, monospace; font-size:80%; color:white'>
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
				
					<tr>
					<td><%=dateRequest.getInt("itemId") %></td>
					<td><%=dateRequest.getString("name") %></td>
					<td><%=dateRequest.getString("clothingType") %></td>
					<td><%=initialprice%></td>
					<td><%=dateRequest.getInt("increment") %></td>
					<td><%=dateRequest.getTimestamp("startDate") %></td>
					<td><%=dateRequest.getTimestamp("endDate") %></td>
					<td><%=dateRequest.getInt("rating") %></td>
					<td><%=dateRequest.getString("username") %></td>
					</tr>
					</table>
					
					<hr noshade size="16">
					</div>
				<% 
				
				dateRequest = stmt.executeQuery("select * from "+clothingtype+" where itemId = "+itemid+" ");
				if(dateRequest.next()) {%>
					<%// item specifications (desc) %>
					<div align="center">
						<h2 style='font-family:"Trebuchet", Trebuchet, monospace; color:white'>
					<b><br>Item Descriptions</br></b>
						</h2>
					<table border="2" style='font-family:"Trebuchet", Trebuchet, monospace; font-size:80%; color:white'>
					<tr>
					<td>Item Size</td>
					<td>Gender</td>
					<td>Color</td>
					<td>Type</td>
					<td>Clothing Type</td>
					</tr>
					</div>
					<tr>
					<td><%=dateRequest.getString("size") %></td>
					<td><%=dateRequest.getString("gender") %></td>
					<td><%=dateRequest.getString("color") %></td>
					<td><%=dateRequest.getString("type") %></td>
					<td><%=dateRequest.getString("clothingType") %></td>
					</tr>
					</table>
					<hr noshade size="16">
					<h2 style='font-family:"Trebuchet", Trebuchet, monospace; color:white'>
					<b><br>Auction Information</br></b>
					</h2>
					
					<%
						
					// checkSeller is used to check if the seller is accessing the page of something that has already been sold/not sold.
					ResultSet checkSeller = stmt.executeQuery("select username from clothing where itemId="+itemId+"");
					if(checkSeller.next()) {
						String sellerNameCheck = checkSeller.getString("username");
						checkSeller.close();
						
						dateRequest = stmt.executeQuery("select bids.itemId, bids.bidValue, bids.username from bids, (select max(bidValue) as bidValue, itemId from bids group by itemId) t0 where bids.bidValue = t0.bidValue and bids.itemId = t0.itemId and bids.username!= '"+defaultBid+"' and bids.itemId='"+itemId+"'");
						//if we successfully query the max bid for the item check that the username = current user and that the current bid > reserve
								
						if(dateRequest.next()) {
							if ( (dateRequest.getString("username").equals(user)) && (dateRequest.getInt("bidValue") >= reserve) ){
								%>
								<font color='white'> You have won this item!
								<%
					
							} else if (sellerNameCheck.equals(user)) {
						 		%>
						 		<font color='white'>The allocated time for this auction has ended. You have sold this item.
						 		<%
							
							//else if maxBid > reserve - what do?	
							} else{
								%>
								<font color='white'>You did not win this item! Better luck next time sport!
								<%
							}
						}else{
						%> 
						The allocated time for this auction has ended. There were no bids placed for this item.
						<% 
						}
					} 
					
				//if query pulls nothing then the itemId is n/a
				}else{
					out.println("The requested page for the item id does not exist.");
				%>
					<button type="button" name="back" onclick="history.back()">Try Again.</button>
				<%
				}
				
			} else {
				// case where they request a non-existent itemId
				out.println("The requested page for the item id does not exist.");
				%>
				<button type="button" name="back" onclick="history.back()">Try Again.</button>
				<%
			}
		}
		} catch (Exception e) {
			out.print(e);
			out.println("error has occured.");%>
			<button type="button" name="back" onclick="history.back()">Try Again.</button>
		<%
		}
		
	%>
		<hr noshade size="16">
	<form action = "../search/itemHistory.jsp">

			<button type="submit" name="itemid" style='font-family: DengXian Light, Fantasy;' value = "<%=session.getAttribute("itemId")%>" > To Bid History</button>
	</form>
	<form action = "../search/relatedItems.jsp">
			<button type="submit" name="itemid" style='font-family: DengXian Light, Fantasy;' value = "<%=session.getAttribute("itemId")%>">To Similar Items</button>
	</form>
	

</body>
</html>