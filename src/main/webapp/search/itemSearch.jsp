<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Search Results</title>
</head>
<body>
<div style ="overflow-y:auto" align='center'>
<table border="2">
	<tr>
	<td>Item ID</td>
	<td>Name</td>
	<td>Type</td>
	<td>Bid Value</td>
	<td>Start Date</td>
	<td>End Date</td>
	<td>Seller</td>
	<td>Size</td>
	<td>Gender</td>
	<td>Color</td>
	<td>Type</td>
	</tr>
	<%
		try{
			//Get DB connection
			ApplicationDB db = new ApplicationDB(); 
			Connection con = db.getConnection(); 
			
			//Create sql statement 
			Statement stmt = con.createStatement(); 
			
			String qType = request.getParameter("queryType");
			String gender = request.getParameter("gender");
			String name = request.getParameter("query");
			String color = request.getParameter("color");
			int maxPrice = Integer.parseInt(request.getParameter("MaxPrice"));
			String sortingMethod = request.getParameter("SortingMethod");
			System.out.println(sortingMethod);
			String sqlQuery = "select * from(select t1.item_id, items.username, items.start_date, items.end_Date, items.name, items.clothing_type, t1.bid_value ";
			sqlQuery+= "from (select * from bids where bid_value in (select max(bid_value) from bids group by item_id) group by item_id) as t1, items ";
			sqlQuery+= "where t1.item_id = items.item_id) as t2 ";
			sqlQuery+= "join " + qType + " on t2.item_id = " + qType + ".item_id";
			sqlQuery += " where ";
			sqlQuery+= qType + ".gender = '";
			sqlQuery += gender; 
			sqlQuery+= "' and t2. end_date > now()";
			if(name != ""){
				sqlQuery += " and (";
				sqlQuery+= "t2.name = '";
				sqlQuery+= name; 
				sqlQuery+= "' or t2.name like '";
				sqlQuery+= name + "%' or t2.name like '%"+name+"%')";
			
			}
			
			if(color != ""){
				sqlQuery+= " and ";
				sqlQuery+= qType + ".color = '";
				sqlQuery+= color;
				sqlQuery+= "'";
			}
			if(maxPrice != 0.0){
				sqlQuery+= " and t2.bid_value < " + maxPrice; 
			}
			
			if(sortingMethod.equals("alphabetical")){
				sqlQuery+= " order by type";
			} else if(sortingMethod.equals("ascendingPrice")){
				sqlQuery+= " order by bid_value ";
			} else if(sortingMethod.equals("descendingPrice")){
				
				sqlQuery+= " order by bid_value desc";
			}
			System.out.println("hello");
			sqlQuery+= ";";
			System.out.println(sqlQuery);
			ResultSet result = stmt.executeQuery(sqlQuery);
			result.next(); 
			do{
				
				%>
				
				<tr>
				<td><%=result.getInt("item_id") %></td>
				<td><%=result.getString("name") %></td>
				<td><%=result.getString("clothing_type") %></td>
				<td><%=result.getInt("bid_value") %></td>
				<td><%=result.getDate("start_date") %></td>
				<td><%=result.getDate("end_date") %></td>
				<td><%=result.getString("username") %></td>
				<td><%=result.getString("size") %></td>
				<td><%=result.getString("gender") %></td>
				<td><%=result.getString("color") %></td>
				<td><%=result.getString("type") %></td>
				</tr>
			<% 	
			}while(result.next());
			%>
			
		<%
			
		%>
		<% 	
		} catch (Exception E){
		
		}%>
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

</body>
</html>