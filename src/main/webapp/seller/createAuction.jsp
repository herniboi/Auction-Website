<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>RU Clothing</title>
	</head>
	

<div align='center'> 

RU Clothing Seller Page


<!-- logout form  -->			  
	<br>
		<form method="post" action="../login/logoutCustomer.jsp">
		<input type="submit" value="Logout"><button type="button" name="back" onclick="history.back()">Go Back</button>
		</form>
	<br>

<hr noshade size="16">

Item Information

<%// create the form in which the seller enters in the options to create an item %>
<div align="center">
	<form action="../seller/verifyCreateAuction.jsp" id="create_auction">
		<table>
		<tr><td><label for="item_name">Name:</label><input type="text" id="item_name" name="name"></td></tr>
		<tr><td><label for="item_initial_price">Initial Amount:</label><input type="text" id="item_initial_price" name="initial_price"></td></tr>
		<tr><td><label for="item_increment_price">Increment Amount:</label><input type="text" id="item_increment_price" name="increment"></td></tr>
		<tr><td><label for="item_size">Size: </label><input type="text" id="item_size" name="size"></td></tr>
		<tr><td><label for="item_color">Color: </label><input type="text" id="item_color" name="color"></td></tr>
		<tr><td><label for="item_type">Type: </label><input type="text" id="item_type" name="type"></td></tr>
		<tr><td><br></br></td></tr>
		<tr><td>(case sensitive: Male, Female)</td></tr>
		<tr><td><label for="item_gender">Gender: </label><input type="text" id="item_gender" name="gender"></td></tr>
		<tr><td><br></br></td></tr>
		<tr><td>(minimum win must >= initial price)</td></tr>
		<tr><td>(set minimum to 0 if no reserve)</td></tr>
		<tr><td><label for="item_min">Minimum Win: </label><input type="text" id="item_min" name="minimum"></td></tr>
		<tr><td><br></br></td></tr>
		<tr><td>(time format: YYYY-MM-DD HH:MM:SS)</td></tr>
		<tr><td><label for="item_end_date">End-Date: </label><input type="text" id="item_end_date" name="end_date"></td></tr>
		
		<tr><td><select id="clothing_type" name="clothing_type" form="create_auction">
  			<option value="shirts">Shirts</option>
  			<option value="shoes">Shoes</option>
  			<option value="hats">Hats</option>
		</select></td></tr>
		</table>
		<input type="submit" value="Submit">
		
		
		
	</form>
</div>
</div>
</html>