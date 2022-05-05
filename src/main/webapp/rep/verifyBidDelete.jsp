<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
		try {
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			// getting the parameters to insert
			// to insert into items
			String itemId = request.getParameter("itemId");
			String name = request.getParameter("name");
			String bidValue = request.getParameter("bidValue");
			String maxBid = request.getParameter("maxBid");
			PreparedStatement ps1 = con.prepareStatement("delete from bids where itemId=? and username=? and bidValue=? and maxBid=?");
			ps1.setString(1, itemId);
			ps1.setString(2, name);
			ps1.setString(3, bidValue);
			ps1.setString(4, maxBid);
			ps1.executeUpdate();
		} catch (Exception e) {
			out.print(e.toString());
			out.println("An error has occurred.");%>
			<button type="button" name="back" onclick="history.back()">Try Again.</button>
		<%
		}
		
	%>
	<form method="post" action="repHome.jsp">
    			<input type ="submit" value="Back" >
  </form>
</body>
</html>