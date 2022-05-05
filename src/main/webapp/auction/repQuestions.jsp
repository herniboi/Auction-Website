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
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			// getting the parameters to insert
			// to insert into items
			int itemId = 0;
			String question = request.getParameter("question");
			String user = (String) session.getAttribute("user");
	
			
			// clothing type
			// insert logic 
			if(question != null && question.length() != 0) { // minimum must be >= initial
				
				// find the item id
				ResultSet findItemId = stmt.executeQuery("select max(questionId) from questions");
				// means that we found a value item id
				if(findItemId.next() && findItemId.getInt("max(questionId)") != 0) {
					itemId = findItemId.getInt("max(questionId)") + 1;
				} else {
					itemId = 1;
				}
				
				// close the connection for findItemId
				findItemId.close();
						
				// insert into items ()
				String insert = "insert into questions(questionId, question, username)" + "VALUES (?, ?, ?)";
				PreparedStatement ps = con.prepareStatement(insert);
				ps.setInt(1, itemId);
				ps.setString(2, question);
				ps.setString(3, user);
				ps.executeUpdate();
				// redirects back to the market home
				response.sendRedirect("questionHome.jsp");
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