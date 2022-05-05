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
			int itemId = 0;
			String initialPrice = request.getParameter("initialPrice");
			int initialprice = Integer.valueOf(initialPrice);
			String incrementPrice = request.getParameter("increment");
			int incrementprice = Integer.valueOf(incrementPrice);
			// start date
			String endDate = request.getParameter("endDate");
			String name = request.getParameter("name");
			String clothingMinimum = request.getParameter("minimum");
			String clothingType = request.getParameter("clothingType");
			int rating = 0;
			String user = (String) session.getAttribute("user");
			
			// to insert into individual db based on clothingType
			// item id
			String clothingSize = request.getParameter("size");
			String clothingGender = request.getParameter("gender");
			String clothingColor = request.getParameter("color");
			String itemType = request.getParameter("type");
	
			
			// clothing type
			// insert logic 
			if(name != null && name.length() != 0
			 && initialPrice != null && initialPrice.length() != 0
			 && incrementPrice != null && incrementPrice.length() != 0
			 && clothingSize != null && clothingDize.length() != 0
			 && clothingGender != null && clothingGender.length() != 0
			 && clothingColor != null && clothingColor.length() != 0
			 && itemType != null && itemType.length() != 0
			 && !(clothingGender.matches("[0-9]+")) // checks if gender is all letters
			 && !(clothingColor.matches("[0-9]+")) // checks if colors is all leters
			 && !(itemType.matches("[0-9]+")) // checks if the item is all letters
			 && !(initialPrice.matches("[a-zA-Z]+")) // checks if initial price is all numbers
			 && !(incrementPrice.matches("[a-zA-Z]+"))  // checks if increment price is all numbers
			 && !(clothingMinimum.matches("[a-zA-Z]+"))// checks if minimum price is all numbers
			 && (initialprice > 0 )
			 && (incrementprice > 0 )
			 && (clothingGender.equals("Male") || clothingGender.equals("Female"))) { 
				
				// find the item id
				ResultSet findItemId = stmt.executeQuery("select max(itemId) from clothing");
				// means that we found a value item id
				if(findItemId.next() && findItemId.getInt("max(itemId)") != 0) {
					itemId = findItemId.getInt("max(itemId)") + 1;
				} else {
					itemId = 1;
				}
				
				// close the connection for findItemId
				findItemId.close();
						
				// insert into items ()
				String insert = "insert into items(itemId, initialPrice, increment, startDate, endDate, name, minWin, clothingType, rating, username)" + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
				PreparedStatement ps = con.prepareStatement(insert);
				
				// used for the start date of when this auction was created
				
				ResultSet getCurrentTime = stmt.executeQuery("SELECT CURRENT_TIMESTAMP");
				
				if(getCurrentTime.next()
				&& getCurrentTime.getTimestamp("CURRENT_TIMESTAMP").compareTo(Timestamp.valueOf(endDate)) < 0){
					
					ps.setInt(1, itemId);
					ps.setInt(2, Integer.parseInt(initialPrice));
					ps.setInt(3, Integer.parseInt(incrementPrice));
					ps.setTimestamp(4, getCurrentTime.getTimestamp("CURRENT_TIMESTAMP"));
					ps.setTimestamp(5, Timestamp.valueOf(endDate));
					ps.setString(6, name);
					ps.setInt(7, Integer.parseInt(clothingMinimum));
					ps.setString(8, clothingType);
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
				insert = "insert into "+ clothingType + "(itemDd, size, gender, color, type, clothingType)" + "VALUES (?, ?, ?, ?, ?, ?)";
				ps = con.prepareStatement(insert);
				
				ps.setInt(1, itemId);
				ps.setString(2, clothingSize);
				ps.setString(3, clothingGender);
				ps.setString(4, clothingColor);
				ps.setString(5, clothingType);
				//ps.setString(6, clothingType);
				
				// run the update for the respective db
				ps.executeUpdate();
						
				// reset the parameters
				ps.clearParameters();
						
				
				// dummy bidder
				String dummyInsert = "insert into bids(itemId, username, bidvalue, maxBid, dateTime)" +  "values (?, ?, ?, ?, ?)";
				PreparedStatement ps2 = con.prepareStatement(dummyInsert);
							
				ps2.setInt(1, itemId);
				ps2.setString(2, "defaultBid");
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