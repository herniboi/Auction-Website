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
	<form action="../seller/verifyCreateAuction.jsp" id="createAuction">
		<table>
		<tr><td><label for="clothingName">Name:</label><input type="text" id="clothingName" name="name"></td></tr>
		<tr><td><label for="clothingInitialPrice">Initial Amount:</label><input type="text" id="clothingInitialPrice" name="initialPrice"></td></tr>
		<tr><td><label for="clothingIncrementPrice">Increment Amount:</label><input type="text" id="clothingIncrementPrice" name="increment"></td></tr>
		<tr><td><label for="clothingSize">Size: </label><input type="text" id="clothingSize" name="size"></td></tr>
		<tr><td><label for="clothingColor">Color: </label><input type="text" id="clothingColor" name="color"></td></tr>
		<tr><td><label for="clothingType">Type: </label><input type="text" id="clothingType" name="type"></td></tr>
		<tr><td><br></br></td></tr>
		<tr><td>(case sensitive: M, F, U)</td></tr>
		<tr><td><label for="clothingGender">Gender: </label><input type="text" id="clothingGender" name="gender"></td></tr>
		<tr><td><br></br></td></tr>
		<tr><td>(minimum win must >= initial price)</td></tr>
		<tr><td>(set minimum to 0 if no reserve)</td></tr>
		<tr><td><label for="clothingMin">Minimum Win: </label><input type="text" id="clothingMin" name="minimum"></td></tr>
		<tr><td><br></br></td></tr>
		<tr><td>(time format: YYYY-MM-DD HH:MM:SS)</td></tr>
		<tr><td><label for="clothingEndDate">End-Date: </label><input type="text" id="clothingEndDate" name="endDate"></td></tr>
		
		<tr><td><select id="clothingType" name="clothingType" form="createAuction">
  			<option value="tops">Tops</option>
  			<option value="bottoms">Bottoms</option>
  			<option value="socks">Socks</option>
			<option value="onePieces">OnePieces</option>
		</select></td></tr>
		</table>
		<input type="submit" value="Submit">
		
		
		
	</form>
</div>
</div>
</html>