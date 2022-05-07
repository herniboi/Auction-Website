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
		String sql = "select clothingType from clothing where clothing.itemId =" + itemid + " and clothing.endDate > now();";
		System.out.println(sql);
		ResultSet result = stmt.executeQuery(sql);
		result.next(); 
		String clothingType = result.getString("clothingType");
		sql = "select type from " + clothingType + " where itemId = " + itemid + ";";
		System.out.println(sql);
		result = stmt.executeQuery(sql);
		result.next(); 
		String type = result.getString("type");
		sql = "select * from " + clothingType + " where type = '" + type + "' and itemId != " + itemid + ";";
		
		result = stmt.executeQuery(sql);
		
	%>

	
	<% 
		while(result.next()){
			%>
			<tr>
			<td><%=result.getInt("itemId") %></td>
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
		<td>Item ID</td><td><input type="text" name="itemId"> <input type="submit" value="Access Item Page"> </td> 
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