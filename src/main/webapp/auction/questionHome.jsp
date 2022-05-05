<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>BuyMe Question Home</title>
</head>
<body>
<div align='center'> 

RU Clothing Questions Page

<!-- logout form  -->			  
	<br>
		<form method="post" action="auctionHome.jsp">
    			<input type ="submit" value="Back" >
  </form>
	<br>
	
	<div align='center'> 
		<form method="post" action="repQuestions.jsp">
		<table>
		<tr>    
		<td>Ask Question: </td>
		<td><input type="text" name="question"> <input type="submit" value="Submit"> </td> 
		</tr>
		<tr><td>
		</table>
		</form>
	</div>

<hr noshade size="16">

<b><br>Questions</br></b>
<table border="2">
	<tr>
	<td>Question ID</td>
	<td>Name</td>
	<td>Question</td>
	<td>Answer</td>

<%
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			ResultSet itemsInfo = stmt.executeQuery("select * from questions");
			while(itemsInfo.next()) {
				%>
				<tr>
				<td><%=itemsInfo.getInt("questionId") %></td>
				<td><%=itemsInfo.getString("username") %></td>
				<td><%=itemsInfo.getString("question") %></td>
				<td><%=itemsInfo.getString("answer") %></td>
				</tr>
<%
			}
			
			itemsInfo.close();
			
		} catch (Exception e) {
			//out.print(e);
			out.println("An error has occurred.");%>
			<button type="button" name="back" onclick="history.back()">Reload.</button>
		<%
		}
		
	%>

</table>
	
</div>
</body>
</html>