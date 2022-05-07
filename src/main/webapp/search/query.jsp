<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Query Page</title>
</head>
<body>

	<form action="itemSearch.jsp">
		<table>
			<tr>
				<td>
					<select name="SortingMethod">
						<option value="unsorted">Unsorted</option>
						<option value="alphabetical">Alphabetical</option>
						<option value="ascendingPrice">Ascending Price</option>
						<option value="descendingPrice">Descending Price</option>
					</select>
				</td>
				<td>
					<select name="queryType">
						<option value="tops">Tops</option>
						<option value="bottoms">Bottoms</option>
						<option value="socks">Socks</option>
						<option value="onePieces">One Pieces</option>
					</select>
					</td>
				</tr>
			<tr>
				<td>
					<select name="MaxPrice">
						<option value="0">No Max</option>
						<option value="50">$50</option>
						<option value="100">$100</option>
						<option value="200">$200</option>
						<option value="400">$400</option>
						<option value="800">$800</option>
						<option value="1600">$1600</option>
						<option value="3200">$3200</option>
						<option value="6400">$6400</option>
						<option value="12800">$12800</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>
					<select name="gender">
						<option value="M">Male</option>
						<option value="F">Female</option>
						<option value="U">Unisex</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>Search</td><td><input type="text" name="query"></td>
			</tr>
			<tr>
				<td>Color</td><td><input type="text" name="color"></td>
			</tr>

		</table>
		<input type="submit" value="Search">
		</form>	 	
		
		<form action="userSearch.jsp">
			<table>
				<tr><td>Search User</td><td><input type="text" name="userName"></td></tr>
			</table>
			<input type="submit" value="Search User">
		</form>
		<form method="post" action="checkAlerts.jsp">
			<input type ="submit" value="Check Alerts" >
		</form>
		
</body>
</html>