<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Home</title>
</head>
<body>
	<br>
		<form method="post" action="login/logoutCustomer.jsp">
		<input type="submit" value="Logout">
		</form>
	<br>
<table> 
<thead>
<tr> 
 <th>
    <h5 class="card-title">Customer Service Representatives</h5>
    <form method="post" action="login/register_representative_form.jsp"> 
    <input type ="submit" value="Register">
    <input type ="submit" value="Delete Account" formaction = "login/delete_representative_form.jsp">
 	</form>
 </th>
 <th>
    <h5 class="card-title">Generate Sales Report</h5>
    <form method="post" action="generate_sales_report.jsp"> 
    <input type ="submit" value="Generate">
 	</form>
 </th>
</thead>
</table>
</body>
</html>