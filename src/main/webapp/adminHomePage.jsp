<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Home</title>
</head>
<body style="background-color:#CC0033;font-family:trebuchet">
	<br>
		<form method="post" action="login/logoutCustomer.jsp">
		<input type="submit" value="Logout" style='font-family: DengXian Light, Fantasy;''>
		</form>
	<br>
<table style='font-family:"Trebuchet", Trebuchet, monospace; color:white'> 
<thead>
<tr> 
 <th>
    <h5 class="card-title">Customer Service Representatives</h5>
    <form method="post" action="login/registerRep.jsp"> 
    <input type ="submit" value="Register" style='font-family: DengXian Light, Fantasy;'>
    <input type ="submit" value="Delete Account" style='font-family: DengXian Light, Fantasy;' formaction = "login/deleteRep.jsp">
 	</form>
 </th>
 <th>
    <h5 class="card-title">Generate Sales Report</h5>
    <form method="post" action="salesReport.jsp"> 
    <input type ="submit" value="Generate" style='font-family: DengXian Light, Fantasy;'>
 	</form>
 </th>
</thead>
</table>
</body>
</html>