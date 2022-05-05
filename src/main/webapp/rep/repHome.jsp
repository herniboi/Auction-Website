<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Service Representative Home</title>
</head>
<body>
	<br>
		<form method="post" action="../login/logoutCustomer.jsp">
		<input type="submit" value="Logout">
		</form>
	<br>
	<table>
		<thead>
			<tr>
				<th>
					<h2>Edit Customer Information</h2>
					<form method="post" action="modifyCustomer.jsp">
						<table>
							<tr>
								<td>Username</td>
								<td><input type="text" name="username"></td>
							</tr>
							<tr>
								<td>Change password</td>
								<td><input type="text" name="password"></td>
							</tr>
							<tr>
								<td>Change email</td>
								<td><input type="text" name="email"></td>
							</tr>
							<tr>
								<td><br>
						</table>
						<input type="submit" value="Edit">
						<input type ="submit" value="Delete Account" formaction = "../login/deleteCustomer.jsp">
					</form>
				</th>
				<th>
					<div class="card" style="width: 18rem;">
						<div class="card-body">
							<h5 class="card-title">Delete Auction</h5>
							<form method="post" action="delete_auction.jsp">
								<input type="submit" value="Delete Auction Page">
							</form>
						</div>
					</div>
				</th>
				<th>
					<div class="card" style="width: 18rem;">
						<div class="card-body">
							<h5 class="card-title">Answer Questions</h5>
							<form method="post" action="answerHomePage.jsp">
								<input type="submit" value="Answer Questions Page">
							</form>
						</div>
					</div>
				</th>
			</tr>
		</thead>
	</table>
</body>
</html>