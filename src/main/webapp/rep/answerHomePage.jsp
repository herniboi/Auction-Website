<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>RU Clothing Answering Service</title>
</head>
<body>
<div align='center'> 

RU Clothing Q&A Service Page

<!-- logout form  -->			  
	<br>
		<form method="post" action="repHome.jsp">
    			<input type ="submit" value="Back" >
  </form>
	<br>
	
	<div align='center'> 
		<form method="post" action="answeringQuestions.jsp">
		<table>
		<tr>    
		<td><label for="answer">Answer: </label><input type="text" id="answer" name="answer"></td> 
		</tr>
		<tr><td><label for="questionId">Question ID: </label><input type="text" id="questionId" name="questionId"></td></tr>
		<tr><td><input type="submit" value="Submit"></td></tr> 
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
			// Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			// Create a SQL statement
			Statement stmt = con.createStatement();
			ResultSet clothingInfo = stmt.executeQuery("select * from questions");
			while(clothingInfo.next()) {
				%>
				<tr>
				<td><%=clothingInfo.getInt("questionId") %></td>
				<td><%=clothingInfo.getString("username") %></td>
				<td><%=clothingInfo.getString("question") %></td>
				<td><%=clothingInfo.getString("answer") %></td>
				</tr>
<%
			}
			
			clothingInfo.close();
			
		} catch (Exception e) {
			//out.print(e);
			out.println("an error has occurred.");%>
			<button type="button" name="back" onclick="history.back()">Try Again.</button>
		<%
		}
		
	%>

</table>
	
</div>
</body>
</html>