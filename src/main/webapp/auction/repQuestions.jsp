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
			int item_id = 0;
			String question = request.getParameter("question");
			String user = (String) session.getAttribute("user");
	
			
			// clothing type
			// insert logic 
			if(question != null && question.length() != 0) { // minimum must be >= initial
				
				// find the item id
				ResultSet find_item_id = stmt.executeQuery("select max(question_id) from questions");
				// means that we found a value item id
				if(find_item_id.next() && find_item_id.getInt("max(question_id)") != 0) {
					item_id = find_item_id.getInt("max(question_id)") + 1;
				} else {
					item_id = 1;
				}
				
				// close the connection for find_item_id
				find_item_id.close();
						
				// insert into items ()
				String insert = "insert into questions(question_id, question, username)" + "VALUES (?, ?, ?)";
				PreparedStatement ps = con.prepareStatement(insert);
				ps.setInt(1, item_id);
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