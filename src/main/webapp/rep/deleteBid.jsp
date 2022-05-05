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
		<form action="verifyBidDelete.jsp" id="delete_bid">
		<table border="2">
			<tr>
			<td><label for="item_id">Item ID:</label>
			<input type="text" id="item_id" name="item_id"></td>
			<td><label for="name">Name:</label>
			<input type="text" id="name" name="name"></td>
			<td><label for="bid_value">Bid Value:</label>
			<input type="text" id="bid_value" name="bid_value"></td>
			<td><label for="max_bid">Max Bid:</label>
			<input type="text" id="max_bid" name="max_bid"></td>
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
					String item_id = request.getParameter("item_id");
					ResultSet items_info = stmt.executeQuery("select * from bids where item_id="+item_id);
					while (items_info.next()) {
				%>
			
			<tr>
				<td><%=items_info.getInt("item_id")%></td>
				<td><%=items_info.getString("username")%></td>
				<td><%=items_info.getInt("bid_value")%></td>
				<td><%=items_info.getInt("max_bid")%></td>
				<td><%=items_info.getTimestamp("date_time")%></td>
			</tr>
			<%
			}
			items_info.close();
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