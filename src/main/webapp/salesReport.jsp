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
<body style="background-color:#CC0033;font-family:trebuchet">
	<br>
		<form method="post" action="login/logoutCustomer.jsp">
		<input type="submit" value="Logout" style='font-family: DengXian Light, Fantasy;'>
		</form>
	<br>
<hr noshade size="16">
<h2 style='font-family:"Trebuchet", Trebuchet, monospace; font-size:130%; color:white'>Sales Report</h2>
<table style='font-family:"Trebuchet", Trebuchet, monospace; color:white' border="2">
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
			ResultSet clothingInfo = 
					stmt.executeQuery(
"select t1.itemId, t1.username, sum(t1.bidValue) as total, clothing.endDate, clothing.name, clothing.clothingType from(select * from bids where bidValue in (select max(bidValue) from bids group by itemId) group by itemId) as t1 join clothing on t1.itemId = clothing.itemId where endDate < current_timestamp group by clothing.clothingType");
			while(clothingInfo.next()) {
				%>
				<tr>
				<td><%=clothingInfo.getString("clothingType") %></td>
				<td><%=clothingInfo.getString("total") %></td>
				</tr>
				<%
			}
			%>
			</table>
			<table style='font-family:"Trebuchet", Trebuchet, monospace;  color:white' border="2">
			<tr>
			<td>Username</td>
			<td>Earnings</td>
			<%
			clothingInfo.close();
			
			ResultSet userInfo = 
					stmt.executeQuery(
"select t1.itemId, clothing.username, sum(t1.bidValue) as total, clothing.clothingType from(select * from bids where bidValue in (select max(bidValue) from bids group by itemId)) as t1 join clothing on t1.itemId = clothing.itemId where endDate < current_timestamp");	
			while(userInfo.next()) {
				%>
				<tr>
				<td><%=userInfo.getString("username") %></td>
				<td><%=userInfo.getString("total") %></td>
				</tr>
				<%
			}
			userInfo.close();
			%>
			</table>
			<h3 style='font-family:"Trebuchet", Trebuchet, monospace; color:white'>Tops</h3>
			<table style='font-family:"Trebuchet", Trebuchet, monospace;  color:white' border="2">
			<tr>
			<td>Clothing Type</td>
			<td>Earnings</td>
			<%
			ResultSet topsTypeInfo = 
					stmt.executeQuery(
					"select sum(price) as total, tops.type from (select max(bidValue) price, bids.itemId from bids, clothing where bids.itemId=clothing.itemId and endDate < current_timestamp() group by bids.itemId) as t1, tops where t1.itemId = tops.itemId group by tops.type");	
			while(topsTypeInfo.next()) {
				%>
				<tr>
				<td><%=topsTypeInfo.getString("type") %></td>
				<td><%=topsTypeInfo.getString("total") %></td>
				</tr>
				<%
			}
			topsTypeInfo.close();
			%>
			</table>
			<h3 style='font-family:"Trebuchet", Trebuchet, monospace; color:white'>Bottoms</h3>
			<table style='font-family:"Trebuchet", Trebuchet, monospace; color:white' border="2">
			<tr>
			<td>Clothing Type</td>
			<td>Earnings</td>
			<%
			ResultSet bottomsTypeInfo = 
					stmt.executeQuery(
					"select sum(price) as total, bottoms.type from (select max(bidValue) price, bids.itemId from bids, clothing where bids.itemId=clothing.itemId and endDate < current_timestamp() group by bids.itemId) as t1, bottoms where t1.itemId = bottoms.itemId group by bottoms.type");	
			while(bottomsTypeInfo.next()) {
				%>
				<tr>
				<td><%=bottomsTypeInfo.getString("type") %></td>
				<td><%=bottomsTypeInfo.getString("total") %></td>
				</tr>
				<%
			}
			bottomsTypeInfo.close();
			%>

			</table>
			<h3 style='font-family:"Trebuchet", Trebuchet, monospace; color:white'>Socks</h3>
			<table style='font-family:"Trebuchet", Trebuchet, monospace; color:white' border="2">
			<tr>
			<td>Clothing Type</td>
			<td>Earnings</td>
			<%
			ResultSet socksTypeInfo = 
					stmt.executeQuery(
					"select sum(price) as total, socks.type from (select max(bidValue) price, bids.itemId from bids, clothing where bids.itemId=clothing.itemId and endDate < current_timestamp() group by bids.itemId) as t1, socks where t1.itemId = socks.itemId group by socks.type");	
			while(socksTypeInfo.next()) {
				%>
				<tr>
				<td><%=socksTypeInfo.getString("type") %></td>
				<td><%=socksTypeInfo.getString("total") %></td>
				</tr>
				<%
			}
			socksTypeInfo.close();
			%>
			</table>
			<h3 style='font-family:"Trebuchet", Trebuchet, monospace; color:white'>OnePieces</h3>
			<table style='font-family:"Trebuchet", Trebuchet, monospace; color:white' border="2">
			<tr>
			<td>Clothing Type</td>
			<td>Earnings</td>
			<%
			ResultSet onePiecesTypeInfo = 
					stmt.executeQuery(
					"select sum(price) as total, onePieces.type from (select max(bidValue) price, bids.itemId from bids, clothing where bids.itemId=clothing.itemId and endDate < current_timestamp() group by bids.itemId) as t1, onePieces where t1.itemId = onePieces.itemId group by onePieces.type");	
			while(onePiecesTypeInfo.next()) {
				%>
				<tr>
				<td><%=onePiecesTypeInfo.getString("type") %></td>
				<td><%=onePiecesTypeInfo.getString("total") %></td>
				</tr>
				<%
			}
			onePiecesTypeInfo.close();
			%>

			</table>
			<h3 style='font-family:"Trebuchet", Trebuchet, monospace; font-size:130%; color:white'>Best Selling Items</h3>
			<h4 style='font-family:"Trebuchet", Trebuchet, monospace; color:white'>Tops</h4>
			<table style='font-family:"Trebuchet", Trebuchet, monospace; color:white' border="2">
			<tr>
			<td>Clothing Type</td>
			<td>Units Sold</td>
			<%
			ResultSet tops2TypeInfo = 
					stmt.executeQuery(
					"select count(price) as units, tops.type from (select max(bidValue) price, itemId from bids) as t1, tops group by tops.type limit 5");	
			while(tops2TypeInfo.next()) {
				%>
				<tr>
				<td><%=tops2TypeInfo.getString("type") %></td>
				<td><%=tops2TypeInfo.getString("units") %></td>
				</tr>
				<%
			}
			tops2TypeInfo.close();
			%></table>
			<h4 style='font-family:"Trebuchet", Trebuchet, monospace;  color:white'>Bottoms</h4>
			<table style='font-family:"Trebuchet", Trebuchet, monospace;  color:white' border="2">
			<tr>
			<td>Clothing Type</td>
			<td>Units Sold</td>
			<%
			ResultSet bottoms2TypeInfo = 
					stmt.executeQuery(
					"select count(price) as units, bottoms.type from (select max(bidValue) price, itemId from bids) as t1, bottoms group by bottoms.type limit 5");	
			while(bottoms2TypeInfo.next()) {
				%>
				<tr>
				<td><%=bottoms2TypeInfo.getString("type") %></td>
				<td><%=bottoms2TypeInfo.getString("units") %></td>
				</tr>
				<%
			}
			bottoms2TypeInfo.close();
			%></table>
			<h4 style='font-family:"Trebuchet", Trebuchet, monospace;  color:white'>Socks</h4>
			<table style='font-family:"Trebuchet", Trebuchet, monospace;  color:white' border="2">
			<tr>
			<td>Clothing Type</td>
			<td>Units Sold</td>
			<%
			ResultSet socks2TypeInfo = 
					stmt.executeQuery(
					"select count(price) as units, socks.type from (select max(bidValue) price, itemId from bids) as t1, socks group by socks.type limit 5");	
			while(socks2TypeInfo.next()) {
				%>
				<tr>
				<td><%=socks2TypeInfo.getString("type") %></td>
				<td><%=socks2TypeInfo.getString("units") %></td>
				</tr>
				<%
			}
			socks2TypeInfo.close();
			%></table>
			<h4 style='font-family:"Trebuchet", Trebuchet, monospace;  color:white'>OnePieces</h4>
			<table style='font-family:"Trebuchet", Trebuchet, monospace;  color:white' border="2">
			<tr>
			<td>Clothing Type</td>
			<td>Units Sold</td>
			<%
			ResultSet onePieces2TypeInfo = 
					stmt.executeQuery(
					"select count(price) as units, onePieces.type from (select max(bidValue) price, itemId from bids) as t1, onePieces group by onePieces.type limit 5");	
			while(onePieces2TypeInfo.next()) {
				%>
				<tr>
				<td><%=onePieces2TypeInfo.getString("type") %></td>
				<td><%=onePieces2TypeInfo.getString("units") %></td>
				</tr>
				<%
			}
			onePieces2TypeInfo.close();
			%>
			</table>
			<h3 style='font-family:"Trebuchet", Trebuchet, monospace; font-size:130%; color:white'>Best Buyers</h3>
			<table style='font-family:"Trebuchet", Trebuchet, monospace;  color:white' border="2">
			<tr>
			<td>Username</td>
			<td>Bids Won</td>
			<%
			ResultSet buyer_type_info = 
					stmt.executeQuery(
					"select bids.username, count(bids.username) as won_bids from bids, clothing, (select max(bidValue) as bidValue, itemId from bids group by itemId) t0 where bids.bidValue = t0.bidValue and bids.itemId = t0.itemId and bids.itemId = clothing.itemId and endDate <= now() group by username order by won_bids desc limit 5");
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
			//out.println("An error has occurred.");%>
			<button type="button" name="back" onclick="history.back()">Try again.</button>
		<%
		}
		
	%>
</body>
</html>