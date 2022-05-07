<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Bid attempt</title>
</head>
<body>
	<%
	
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		//get values from buyer page bid attempt
		int itemId = Integer.parseInt((String)session.getAttribute("itemId"));
		String user = (String)session.getAttribute("user"); 
		
		ResultSet itemBid = stmt.executeQuery("select * from clothing where itemId = '"+itemId+"'");
		
		if(itemBid.next()) {	
			String seller = itemBid.getString("username");
			
			//allow insert into watchlists if user not already watching and user is not seller
			
			itemBid =  stmt.executeQuery("select * from watchlists where itemId = '"+itemId+"' and username = '"+user+"'"); 
			if(itemBid.next() || seller.equals(user)){
				   out.println("You have either already bid on this item, or are the one selling it");
	               %>
	               <form method="post" action="../auction/auctionHome.jsp">
	               <input type ="submit" value="return home" >
	               </form>
	               <% 
			}else{
				String insert = "INSERT INTO `watchlists` (itemId, username) " + "VALUES (?, ?)";
				PreparedStatement ps = con.prepareStatement(insert);
				ps.setInt(1, itemId);
				ps.setString(2, user);
				ps.executeUpdate();
				out.println("success");
			}
		}else{
			   out.println("You have either already bid on this item, or are the one selling it");
               %>
               <form method="post" action="../auction/auctionHome.jsp">
               <input type ="submit" value="return home" >
               </form>
               <% 
		}
		
		
		
	%>
	
	

</body>
</html>