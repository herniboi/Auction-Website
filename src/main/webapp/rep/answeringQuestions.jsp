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
<%
		try {
			
			// Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			// Create a SQL statement
			Statement stmt = con.createStatement();
			String itemId = request.getParameter("questionId");
			String answer = request.getParameter("answer");
			if(answer != null && answer.length() != 0) { // minimum must be >= initial
				String insert = "update questions set answer=? where questionId=?";
				PreparedStatement ps = con.prepareStatement(insert);
				ps.setString(1, answer);
				ps.setString(2, itemId);
				ps.executeUpdate();
				// redirects back to the market home
				response.sendRedirect("answerHomePage.jsp");
			} else {
				out.println("Invalid input. All fields require an input and or proper inputs. \n"); %>
				<button type="button" name="back" onclick="history.back()">Try Again.</button>
				<%
			}
				
		} catch (Exception e) {
			//out.print(e);
			out.println("An error has occurred.");%>
			<button type="button" name="back" onclick="history.back()">Try Again.</button>
		<%
		}
		
	%>
</body>
</html>