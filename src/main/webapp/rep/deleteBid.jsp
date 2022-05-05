<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>RU Clothing Delete Bids</title>
</head>
<body>
<div align='center'>
		RU Clothing Delete Bid Page <br>
		<form method="post" action="../login/logoutCustomer.jsp">
			<input type="submit" value="Logout">
			<button type="button" name="back" onclick="history.back()">Go
				Back</button>
		</form>
		<form action="verifyBidDelete.jsp" id="deleteBid">
		<table border="2">
			<tr>
			<td><label for="itemId">Item ID:</label>
			<input type="text" id="itemId" name="itemId"></td>
			<td><label for="name">Name:</label>
			<input type="text" id="name" name="name"></td>
			<td><label for="bidValue">Bid Value:</label>
			<input type="text" id="bidValue" name="bidValue"></td>
			<td><label for="maxBid">Max Bid:</label>
			<input type="text" id="maBid" name="maxBid"></td>
			<td><input type="submit" value="Delete"></td>
			</tr>
			</table>
		</form>
<br> <b><br>Bids</br></b>
		<table border="2">
			<tr>
				<td>Item ID</td>
				<td>Name</td>
				<td>Bid Value</td>
				<td>Max Bid</td>
				<td>Date Time</td>

				<%
				try {
					//Get the database connection
					ApplicationDB db = new ApplicationDB();
					Connection con = db.getConnection();
					//Create a SQL statement
					Statement stmt = con.createStatement();
					String itemId = request.getParameter("itemId");
					ResultSet itemsInfo = stmt.executeQuery("select * from bids where itemId="+itemId);
					while (itemsInfo.next()) {
				%>
			
			<tr>
				<td><%=itemsInfo.getInt("itemId")%></td>
				<td><%=itemsInfo.getString("username")%></td>
				<td><%=itemsInfo.getInt("bidValue")%></td>
				<td><%=itemsInfo.getInt("maxBid")%></td>
				<td><%=itemsInfo.getTimestamp("dateTime")%></td>
			</tr>
			<%
			}
			itemsInfo.close();
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