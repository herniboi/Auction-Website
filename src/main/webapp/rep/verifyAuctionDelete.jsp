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
			String clothingType = request.getParameter("clothingType");
			PreparedStatement ps1 = con.prepareStatement("delete from "+clothingType+" where itemId=?");
			ps1.setString(1, itemId);
			PreparedStatement ps2 = con.prepareStatement("delete from clothing where itemId=?");
			ps2.setString(1, itemId);
			PreparedStatement pre = con.prepareStatement("SET FOREIGN_KEY_CHECKS=0");
			PreparedStatement post = con.prepareStatement("SET FOREIGN_KEY_CHECKS=1");
			pre.executeUpdate();
			ps1.executeUpdate();
			ps2.executeUpdate();
			post.executeUpdate();
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