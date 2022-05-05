<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<div style ="overflow-y:auto" align='center'>
	<table border="2">
	<tr>
	<td>Item ID</td>
	<td>Size</td>
	<td>Gender</td>
	<td>Color</td>
	<td>Type</td>
	
	</tr>
	<%
	try{
		int itemid = Integer.parseInt(request.getParameter("itemid"));
		ApplicationDB db = new ApplicationDB(); 
		Connection con = db.getConnection();  
		
		Statement stmt = con.createStatement(); 
		String sql = "select clothing_type from items where items.item_id =" + itemid + " and items.end_date > now();";
		System.out.println(sql);
		ResultSet result = stmt.executeQuery(sql);
		result.next(); 
		String clothing_type = result.getString("clothing_type");
		sql = "select type from " + clothing_type + " where item_id = " + itemid + ";";
		System.out.println(sql);
		result = stmt.executeQuery(sql);
		result.next(); 
		String type = result.getString("type");
		sql = "select * from " + clothing_type + " where type = '" + type + "' and item_id != " + itemid + ";";
		
		result = stmt.executeQuery(sql);
		
	%>

	
	<% 
		while(result.next()){
			%>
			<tr>
			<td><%=result.getInt("item_id") %></td>
			<td><%=result.getString("size") %></td>
			<td><%=result.getString("gender") %></td>
			<td><%=result.getString("color") %></td>
			<td><%=result.getString("type") %></td>
			</tr>
		<% 	
		}
		%>
		</table>
		</div>
		<div align='center'> 
		<form method="post" action="../auction/requestItem.jsp">
		<table>
		<tr>    
		<td>Item ID</td><td><input type="text" name="item_id"> <input type="submit" value="Access Item Page"> </td> 
		</tr>
		<tr><td>
		</table>
		</form>
</div>
		<% 
	}catch(Exception E){
		
	}
	%>
</body>
</html>