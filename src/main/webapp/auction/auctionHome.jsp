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
<%String username = (String)session.getAttribute("user"); %>
RU Clothing Login Page (<%=username%>)
</h2>


<!-- logout form  -->			  
<br>
    <form method="post" action="../login/logoutCustomer.jsp">
    <input type="submit" value="Logout" style='font-family: DengXian Light, Fantasy;'>
    </form>
<br>

<table style='font-family:"Trebuchet", Trebuchet, monospace; font-size:130%; color:white'>
<thead>
<tr> 

<!-- Customer Login -->
<th> 
<div class="card" style="width: 18rem;" >
<div class="card-body">
<h5 class="card-title">Buyer Options</h5>
<form method="post" action="buyerHome.jsp">
<input type ="submit" value="Access Buyer Page"  style='font-family: DengXian Light, Fantasy;'>

</form>
</div>
</div>
</th>

<!-- Seller Page -->
<th> 
<div class="card" style="width: 18rem;" >
<div class="card-body">
<h5 class="card-title">Seller Options </h5>
<form method="post" action="../seller/sellerHome.jsp">
<input type ="submit" value="Access Seller Page"  style='font-family: DengXian Light, Fantasy;'>
</form>
</div>
</div>
</th>

<th> 
<div class="card" style="width: 18rem;" >
<div class="card-body">
<h5 class="card-title">Questions</h5>
<form method="post" action="questionHome.jsp">
<input type ="submit" value="Access Questions Page" style='font-family: DengXian Light, Fantasy;' >
</form>
</div>
</div>
</th>

</tr>
</thead>
</table>

<hr noshade size="16">
<h2 style='font-family:"Trebuchet", Trebuchet, monospace; color:white'>
<b><br>Auction House</br></b>
</h2>
<table border="2" style='font-family:"Trebuchet", Trebuchet, monospace; font-size:80%; color:white'>
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
        ResultSet itemsInfo = stmt.executeQuery("select * from clothing where endDate > now()");
        while(itemsInfo.next()) {
            %>
            <tr>
            <td><%=itemsInfo.getInt("itemId") %></td>
            <td><%=itemsInfo.getString("name") %></td>
            <td><%=itemsInfo.getString("clothingType") %></td>
            <td><%=itemsInfo.getInt("initialPrice") %></td>
            <td><%=itemsInfo.getInt("increment") %></td>
            <td><%=itemsInfo.getTimestamp("startDate") %></td>
            <td><%=itemsInfo.getTimestamp("endDate") %></td>
            <td><%=itemsInfo.getInt("rating") %></td>
            <td><%=itemsInfo.getString("username") %></td>
            </tr>
<%
        }
        
        itemsInfo.close();
        ResultSet getCurrentTime = stmt.executeQuery("SELECT CURRENT_TIMESTAMP");
        getCurrentTime.next();
        out.println("<font color='white'>" + "Current Time: " + getCurrentTime.getTimestamp("CURRENT_TIMESTAMP"));
        
    } catch (Exception e) {
        out.println("an error has occurred.");%>
        <button type="button" name="back" onclick="history.back()" style='font-family: DengXian Light, Fantasy;'>Try Again.</button>
    <%
    }
    
%>

</table>
</div>

<div align='center'> 

    <form method="post" action="../auction/requestItem.jsp">
    <table style='font-family:"Trebuchet", Trebuchet, monospace; font-size:80%; color:white'>
    <tr>    
    <td>Item ID</td><td><input type="text" name="itemId"> <input type="submit" value="Access Item Page" style='font-family: DengXian Light, Fantasy;'> </td> 
    </tr>
    <tr><td>
    </table>
    </form>
    
    <br>

<div class="card" style="width: 18rem;" >
<div class="card-body">
<h5 class="card-title"></h5>
<form method="post" action="../search/query.jsp">
<input type ="submit" value="go to search page" style='font-family: DengXian Light, Fantasy;' >
</form>
</div>
</div>


</div>


</body>
</html>