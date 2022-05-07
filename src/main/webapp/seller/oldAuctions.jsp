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

RU CLothing Seller Old Auction Page


<!-- logout form  -->			  
<br>
    <form method="post" action="../login/logoutCustomer.jsp">
    <input type="submit" value="Logout">
    </form>
<br>

<!-- go back to auction form  -->			  
<br>
    <form method="post" action="../auction/redirectAuction.jsp">
    <input type="submit" value="Login Page">
    </form>
<br>	

<hr noshade size="16">
<b><br>User Old Auction Items</br></b>
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
        
        String user = (String)session.getAttribute("user"); 
        
        //Create a SQL statement
        Statement stmt = con.createStatement();
        ResultSet clothingInfo = stmt.executeQuery("select * from clothing where username='"+user+"' and now() > endDate");
        while(clothingInfo.next()) {
            %>
            <tr>
            <td><%=clothingInfo.getInt("itemId") %></td>
            <td><%=clothingInfo.getString("name") %></td>
            <td><%=clothingInfo.getString("clothingType") %></td>
            <td><%=clothingInfo.getInt("initialPrice") %></td>
            <td><%=clothingInfo.getInt("increment") %></td>
            <td><%=clothingInfo.getTimestamp("startDate") %></td>
            <td><%=clothingInfo.getTimestamp("endDate") %></td>
            <td><%=clothingInfo.getInt("rating") %></td>
            <td><%=clothingInfo.getString("username") %></td>
            </tr>
<%
        }
    } catch (Exception e) {
        //out.print(e);
        out.println("an error has occurred.");%>
        <button type="button" name="back" onclick="history.back()">Try Again.</button>
    <%
    }
    
%>

</table>
</div>

<div align='center'> 

    <form method="post" action="../auction/requestItem.jsp">
    <table>
    <tr>    
    <td>Item ID</td><td><input type="text" name="itemId"> <input type="submit" value="Access Item Page"> </td> 
    </tr>
    <tr><td>
    </table>
    </form>


</div>





</html>