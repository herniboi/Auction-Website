<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sales Report</title>
</head>
<body>
	<br>
		<form method="post" action="login/logoutCustomer.jsp">
		<input type="submit" value="Logout">
		</form>
	<br>
<hr noshade size="16">
<h2>Sales Report</h2>
<table border="2">
	<tr>
	<td>Clothing Type</td>
	<td>Earnings</td>

<%
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			ResultSet clothing_info = 
					stmt.executeQuery(
"select t1.item_id, t1.username, sum(t1.bid_value) as total, items.end_date, items.name, items.clothing_type from(select * from bids where bid_value in (select max(bid_value) from bids group by item_id) group by item_id) as t1 join items on t1.item_id = items.item_id where end_date < current_timestamp group by items.clothing_type");
			while(clothing_info.next()) {
				%>
				<tr>
				<td><%=clothing_info.getString("clothing_type") %></td>
				<td><%=clothing_info.getString("total") %></td>
				</tr>
				<%
			}
			%>
			</table>
			<table border="2">
			<tr>
			<td>Username</td>
			<td>Earnings</td>
			<%
			clothing_info.close();
			
			ResultSet user_info = 
					stmt.executeQuery(
"select t1.item_id, items.username, sum(t1.bid_value) as total, items.clothing_type from(select * from bids where bid_value in (select max(bid_value) from bids group by item_id)) as t1 join items on t1.item_id = items.item_id where end_date < current_timestamp");	
			while(user_info.next()) {
				%>
				<tr>
				<td><%=user_info.getString("username") %></td>
				<td><%=user_info.getString("total") %></td>
				</tr>
				<%
			}
			user_info.close();
			%>
			</table>
			<h3>Hats</h3>
			<table border="2">
			<tr>
			<td>Item Type</td>
			<td>Earnings</td>
			<%
			ResultSet hat_type_info = 
					stmt.executeQuery(
					"select sum(price) as total, hats.type from (select max(bid_value) price, bids.item_id from bids, items where bids.item_id=items.item_id and end_date < current_timestamp() group by bids.item_id) as t1, hats where t1.item_id = hats.item_id group by hats.type");	
			while(hat_type_info.next()) {
				%>
				<tr>
				<td><%=hat_type_info.getString("type") %></td>
				<td><%=hat_type_info.getString("total") %></td>
				</tr>
				<%
			}
			hat_type_info.close();
			%>
			</table>
			<h3>Shirts</h3>
			<table border="2">
			<tr>
			<td>Item Type</td>
			<td>Earnings</td>
			<%
			ResultSet shirt_type_info = 
					stmt.executeQuery(
					"select sum(price) as total, shirts.type from (select max(bid_value) price, bids.item_id from bids, items where bids.item_id=items.item_id and end_date < current_timestamp() group by bids.item_id) as t1, shirts where t1.item_id = shirts.item_id group by shirts.type");	
			while(shirt_type_info.next()) {
				%>
				<tr>
				<td><%=shirt_type_info.getString("type") %></td>
				<td><%=shirt_type_info.getString("total") %></td>
				</tr>
				<%
			}
			shirt_type_info.close();
			%>
			</table>
			<h3>Shoes</h3>
			<table border="2">
			<tr>
			<td>Item Type</td>
			<td>Earnings</td>
			<%
			ResultSet shoe_type_info = 
					stmt.executeQuery(
					"select sum(price) as total, shoes.type from (select max(bid_value) price, bids.item_id from bids, items where bids.item_id=items.item_id and end_date < current_timestamp() group by bids.item_id) as t1, shoes where t1.item_id = shoes.item_id group by shoes.type");	
			while(shoe_type_info.next()) {
				%>
				<tr>
				<td><%=shoe_type_info.getString("type") %></td>
				<td><%=shoe_type_info.getString("total") %></td>
				</tr>
				<%
			}
			shoe_type_info.close();
			%>
			</table>
			<h3>Best Selling Items</h3>
			<h4>Shirts</h4>
			<table border="2">
			<tr>
			<td>Item Type</td>
			<td>Units Sold</td>
			<%
			ResultSet shirtb_type_info = 
					stmt.executeQuery(
					"select count(price) as units, shirts.type from (select max(bid_value) price, item_id from bids) as t1, shirts group by shirts.type limit 5");	
			while(shirtb_type_info.next()) {
				%>
				<tr>
				<td><%=shirtb_type_info.getString("type") %></td>
				<td><%=shirtb_type_info.getString("units") %></td>
				</tr>
				<%
			}
			shirtb_type_info.close();
			%></table>
			<h4>Shoes</h4>
			<table border="2">
			<tr>
			<td>Item Type</td>
			<td>Units Sold</td>
			<%
			ResultSet shoesb_type_info = 
					stmt.executeQuery(
					"select count(price) as units, shoes.type from (select max(bid_value) price, item_id from bids) as t1, shoes group by shoes.type limit 5");	
			while(shoesb_type_info.next()) {
				%>
				<tr>
				<td><%=shoesb_type_info.getString("type") %></td>
				<td><%=shoesb_type_info.getString("units") %></td>
				</tr>
				<%
			}
			shoesb_type_info.close();
			%></table>
			<h4>Hats</h4>
			<table border="2">
			<tr>
			<td>Item Type</td>
			<td>Units Sold</td>
			<%
			ResultSet hatsb_type_info = 
					stmt.executeQuery(
					"select count(price) as units, hats.type from (select max(bid_value) price, item_id from bids) as t1, hats group by hats.type limit 5");	
			while(hatsb_type_info.next()) {
				%>
				<tr>
				<td><%=hatsb_type_info.getString("type") %></td>
				<td><%=hatsb_type_info.getString("units") %></td>
				</tr>
				<%
			}
			hatsb_type_info.close();
			%></table>
			<h3>Best Buyers</h3>
			<table border="2">
			<tr>
			<td>Username</td>
			<td>Bids Won</td>
			<%
			ResultSet buyer_type_info = 
					stmt.executeQuery(
					"select bids.username, count(bids.username) as won_bids from bids, items, (select max(bid_value) as bid_value, item_id from bids group by item_id) t0 where bids.bid_value = t0.bid_value and bids.item_id = t0.item_id and bids.item_id = items.item_id and end_date <= now() group by username order by won_bids desc limit 5");
					while(buyer_type_info.next()) {
				%>
				<tr>
				<td><%=buyer_type_info.getString("username") %></td>
				<td><%=buyer_type_info.getString("won_bids") %></td>
				</tr>
				<%
			}
			%></table><%
		} catch (Exception e) {
			out.print(e);
			//out.println("an error has occurred.");%>
			<button type="button" name="back" onclick="history.back()">Try Again.</button>
		<%
		}
		
	%>
</body>
</html>