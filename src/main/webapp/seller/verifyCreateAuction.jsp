<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
			String initial_price = request.getParameter("initial_price");
			int initialprice = Integer.valueOf(initial_price);
			String increment_price = request.getParameter("increment");
			int incrementprice = Integer.valueOf(increment_price);
			// start date
			String end_date = request.getParameter("end_date");
			String name = request.getParameter("name");
			String item_minimum = request.getParameter("minimum");
			String clothing_type = request.getParameter("clothing_type");
			int rating = 0;
			String user = (String) session.getAttribute("user");
			
			// to insert into individual db based on clothing_type
			// item id
			String item_size = request.getParameter("size");
			String item_gender = request.getParameter("gender");
			String item_color = request.getParameter("color");
			String item_type = request.getParameter("type");
	
			
			// clothing type
			// insert logic 
			if(name != null && name.length() != 0
			 && initial_price != null && initial_price.length() != 0
			 && increment_price != null && increment_price.length() != 0
			 && item_size != null && item_size.length() != 0
			 && item_gender != null && item_gender.length() != 0
			 && item_color != null && item_color.length() != 0
			 && item_type != null && item_type.length() != 0
			 && !(item_gender.matches("[0-9]+")) // checks if gender is all letters
			 && !(item_color.matches("[0-9]+")) // checks if colors is all leters
			 && !(item_type.matches("[0-9]+")) // checks if the item is all letters
			 && !(initial_price.matches("[a-zA-Z]+")) // checks if initial price is all numbers
			 && !(increment_price.matches("[a-zA-Z]+"))  // checks if increment priec is all numbers
			 && !(item_minimum.matches("[a-zA-Z]+"))// checks if minimum price is all numbers
			 && (initialprice > 0 )
			 && (incrementprice > 0 )
			 && (item_gender.equals("Male") || item_gender.equals("Female"))) { 
				
				// find the item id
				ResultSet find_item_id = stmt.executeQuery("select max(item_id) from items");
				// means that we found a value item id
				if(find_item_id.next() && find_item_id.getInt("max(item_id)") != 0) {
					item_id = find_item_id.getInt("max(item_id)") + 1;
				} else {
					item_id = 1;
				}
				
				// close the connection for find_item_id
				find_item_id.close();
						
				// insert into items ()
				String insert = "insert into items(item_id, initial_price, increment, start_date, end_date, name, min_win, clothing_type, rating, username)" + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
				PreparedStatement ps = con.prepareStatement(insert);
				
				// used for the start date of when this auction was created
				
				ResultSet get_current_time = stmt.executeQuery("SELECT CURRENT_TIMESTAMP");
				
				if(get_current_time.next()
				&& get_current_time.getTimestamp("CURRENT_TIMESTAMP").compareTo(Timestamp.valueOf(end_date)) < 0){
					
					ps.setInt(1, item_id);
					ps.setInt(2, Integer.parseInt(initial_price));
					ps.setInt(3, Integer.parseInt(increment_price));
					ps.setTimestamp(4, get_current_time.getTimestamp("CURRENT_TIMESTAMP"));
					ps.setTimestamp(5, Timestamp.valueOf(end_date));
					ps.setString(6, name);
					ps.setInt(7, Integer.parseInt(item_minimum));
					ps.setString(8, clothing_type);
					ps.setInt(9, rating);
					ps.setString(10, user);
				
					
					// run the update.
					ps.executeUpdate();
				} else {
					out.println("Please try again. The end-date must be a time period beyond the current time. \n");
				}
				
				// reset the parameters
				ps.clearParameters();
				
				// insert into the respect database (shirts, shoes, hats)
				insert = "insert into "+ clothing_type + "(item_id, size, gender, color, type, clothing_type)" + "VALUES (?, ?, ?, ?, ?, ?)";
				ps = con.prepareStatement(insert);
				
				ps.setInt(1, item_id);
				ps.setString(2, item_size);
				ps.setString(3, item_gender);
				ps.setString(4, item_color);
				ps.setString(5, item_type);
				ps.setString(6, clothing_type);
				
				// run the update for the respective db
				ps.executeUpdate();
						
				// reset the parameters
				ps.clearParameters();
						
				
				// dummy bidder
				String dummy_insert = "insert into bids(item_id, username, bid_value, max_bid, date_time)" +  "values (?, ?, ?, ?, ?)";
				PreparedStatement ps2 = con.prepareStatement(dummy_insert);
							
				ps2.setInt(1, item_id);
				ps2.setString(2, "default_bid");
				ps2.setInt(3, initialprice);
				ps2.setInt(4, 0);
				ps2.setTimestamp(5, null);
							
							
				ps2.executeUpdate();
				
						
				// redirects back to the market home
				response.sendRedirect("../auction/auction_home.jsp");
			} else {
				out.println("Invalid input. All fields require an input and or proper inputs. \n"); %>
				<button type="button" name="back" onclick="history.back()">Try Again.</button>
				<%
			}
				
		} catch (Exception e) {
			//out.print(e);
			out.println("An error has occurred.");%>
			<button type="button" name="back" onclick="history.back()">Please try again.</button>
		<%
		}
		
	%>
	
	

</body>
</html>