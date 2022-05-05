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
			<form action="verifyAuctionDelete.jsp" id="deleteAuction">
				<table>
					<tr>
						<td><label for="itemId">Item ID:</label><input type="text"
							id="itemId" name="itemId"></td>
					</tr>
					<tr>
						<td><select id="clothingType" name="clothingType"
							form="deleteAuction">
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
			<form action="deleteBid.jsp" id="deleteBid">
				<table>
					<tr>
						<td><label for="itemId">Item ID:</label><input type="text"
							id="itemId" name="itemId"></td>
					</tr>
					<tr>
						<td><select id="clothingType" name="clothingType"
							form="deleteBid">
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
					ResultSet clothingInfo = stmt.executeQuery("select * from items");
					while (clothingInfo.next()) {
				%>
			
			<tr>
				<td><%=clothingInfo.getInt("itemId")%></td>
				<td><%=clothingInfo.getString("name")%></td>
				<td><%=clothingInfo.getString("clothingType")%></td>
				<td><%=clothingInfo.getInt("initialPrice")%></td>
				<td><%=clothingInfo.getInt("increment")%></td>
				<td><%=clothingInfo.getTimestamp("startDate")%></td>
				<td><%=clothingInfo.getTimestamp("endDate")%></td>
				<td><%=clothingInfo.getInt("rating")%></td>
				<td><%=clothingInfo.getString("username")%></td>
			</tr>
			<%
			}
			clothingInfo.close();
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