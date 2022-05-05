<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>RU Clothing Delete Auction</title>
</head>
<body>
	<div align='center'>
		RU Clothing Delete Auction Page <br>
		<form method="post" action="../login/logoutCustomer.jsp">
			<input type="submit" value="Logout">
			<button type="button" name="back" onclick="history.back()">Go
				Back</button>
		</form>
		<div align='center'>
			<hr noshade size="16">
			Delete Auction
			<form action="verifyAuctionDelete.jsp" id="delete_auction">
				<table>
					<tr>
						<td><label for="item_id">Item ID:</label><input type="text"
							id="item_id" name="item_id"></td>
					</tr>
					<tr>
						<td><select id="clothing_type" name="clothing_type"
							form="delete_auction">
								<option value="shirts">Shirts</option>
								<option value="shoes">Shoes</option>
								<option value="hats">Hats</option>
						</select></td>
					</tr>
				</table>
				<input type="submit" value="Submit">
			</form>
		</div>
		<div align='center'>
			<hr noshade size="16">
			View Bids
			<form action="deleteBid.jsp" id="delete_bid">
				<table>
					<tr>
						<td><label for="item_id">Item ID:</label><input type="text"
							id="item_id" name="item_id"></td>
					</tr>
					<tr>
						<td><select id="clothing_type" name="clothing_type"
							form="delete_bid">
								<option value="shirts">Shirts</option>
								<option value="shoes">Shoes</option>
								<option value="hats">Hats</option>
						</select></td>
					</tr>
				</table>
				<input type="submit" value="Submit">
			</form>
		</div>
		<hr noshade size="16">
				<br> <b><br>Auction House</br></b>
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
					//Create a SQL statement
					Statement stmt = con.createStatement();
					ResultSet items_info = stmt.executeQuery("select * from items");
					while (items_info.next()) {
				%>
			
			<tr>
				<td><%=items_info.getInt("item_id")%></td>
				<td><%=items_info.getString("name")%></td>
				<td><%=items_info.getString("clothing_type")%></td>
				<td><%=items_info.getInt("initial_price")%></td>
				<td><%=items_info.getInt("increment")%></td>
				<td><%=items_info.getTimestamp("start_date")%></td>
				<td><%=items_info.getTimestamp("end_date")%></td>
				<td><%=items_info.getInt("rating")%></td>
				<td><%=items_info.getString("username")%></td>
			</tr>
			<%
			}
			items_info.close();
			ResultSet get_current_time = stmt.executeQuery("SELECT CURRENT_TIMESTAMP");
			get_current_time.next();
			out.println(get_current_time.getTimestamp("CURRENT_TIMESTAMP"));
			} catch (Exception e) {
			//out.print(e);
			out.println("an error has occurred.");
			%>
			<button type="button" name="back" onclick="history.back()">Try
				Again.</button>
			<%
			}
			%>
		</table>
	</div>
</body>
</html>