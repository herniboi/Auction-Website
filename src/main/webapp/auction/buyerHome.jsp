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
	<body style="background-color:#CC0033;font-family:trebuchet">

<div align='center'> 
  <h2 style='font-family:"Trebuchet", Trebuchet, monospace; color:white'>
RU Clothing Buyer Functions

</h2>
<!-- logout form  -->			  
	<br>
		<form method="post" action="../login/logoutCustomer.jsp">
		<input type="submit" value="Logout"style='font-family: DengXian Light, Fantasy;'>
    <input type="submit" value="User Options" style='font-family: DengXian Light, Fantasy;' formaction="../auction/auctionHome.jsp">
		</form>
	<br>

<table style='font-family:"Trebuchet", Trebuchet, monospace; font-size:130%; color:white'>
<thead>
<tr> 

<th> 
<div class="card" style="width: 18rem;" >
  <div class="card-body">
    <h5 class="card-title">Items That User Is Interested In</h5>
    <form method="post" action="../buyer/alertWatchlist.jsp">
    <input type ="submit" value="Watched List Items" style='font-family: DengXian Light, Fantasy;'>
   
    </form>
  </div>
</div>
</th>

<th> 
<div class="card" style="width: 18rem;" >
  <div class="card-body">
    <h5 class="card-title">All Items User Placed Bid On </h5>
    <form method="post" action="../buyer/biddedItems.jsp">
    <input type ="submit" value="Access Item Bids" style='font-family: DengXian Light, Fantasy;'>
    </form>
  </div>
</div>
</th>

</tr>
</thead>
</table>



<hr noshade size="16">

<table style='font-family:"Trebuchet", Trebuchet, monospace; font-size:130%; color:white'>
<th> 
<div class="card" style="width: 18rem;" >
  <div class="card-body">
    <h5 class="card-title">Alert: Check Which Auction User Bid Is Winning</h5>
    <form method="post" action="../buyer/alertWinningAuction.jsp">
    <input type ="submit" value="Access Winning Auctions" style='font-family: DengXian Light, Fantasy;'>
    </form>
  </div>
</div>
</th>

<th> 
<div class="card" style="width: 18rem;" >
  <div class="card-body">
    <h5 class="card-title">Alert: Higher Bid Placed </h5>
    <form method="post" action="../buyer/alertLosingAuction.jsp">
    <input type ="submit" value="Access Out-bidded Items" style='font-family: DengXian Light, Fantasy;'>
    </form>
  </div>
</div>
</th>

<th> 
<div class="card" style="width: 18rem;" >
  <div class="card-body">
    <h5 class="card-title">Alert: Auctions Won</h5>
    <form method="post" action="../buyer/alertAuctionWon.jsp">
    <input type ="submit" value="Access Items Won" style='font-family: DengXian Light, Fantasy;'>
    </form>
  </div>
</div>
</th>


</table>






</body>
</html>