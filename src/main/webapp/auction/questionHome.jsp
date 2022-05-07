<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>RU Clothing Question Home</title>
</head>
<body style="background-color:#CC0033;font-family:trebuchet">
<div align='center'> 
<h2 style='font-family:"Trebuchet", Trebuchet, monospace; color:white'>

RU Clothing Questions Page
</h2>
<!-- logout form  -->			  
	<br>
		<form method="post" action="auctionHome.jsp">
    			<input type ="submit" value="Back" style='font-family: DengXian Light, Fantasy;'>
  </form>
	<br>
	
	<div align='center'> 
		<form method="post" action="repQuestions.jsp">
		<table style='font-family:"Trebuchet", Trebuchet, monospace; font-size:130%; color:white'>
		<tr>    
		<td>Ask Question: </td>
		<td><input type="text" name="question" style='font-family: DengXian Light, Fantasy;'> <input type="submit" value="Submit" style='font-family: DengXian Light, Fantasy;'> </td> 
		</tr>
		<tr><td>
		</table>
		</form>
	</div>

<hr noshade size="16">

<h2 style='font-family:"Trebuchet", Trebuchet, monospace; color:white'>
<b><br>Questions</br></b>
</h2>
<table border="2" style='font-family:"Trebuchet", Trebuchet, monospace; font-size:80%; color:white'>
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
			out.println("An error has occurred.");%>
			<button type="button" name="back" onclick="history.back()">Reload.</button>
		<%
		}
		
	%>

</table>
	
</div>
</body>
</html>