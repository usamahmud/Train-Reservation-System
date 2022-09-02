<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Add Customer Rep</title>
	</head>
	<body>
		<h2>Create a Customer Rep Account</h2>
		<h4>Enter the account information here:</h4>

		<form name = "userForm" action="repUserPassCheck.jsp">
		  <label for="username">Username:</label>
		  <input type="text" id="username" name="username"><br><br>
		  <label for="pass">Password:</label>
		  <input type="password" id="pass" name="pass"><br><br>
		  <label for="conf">Confirm Password:</label>
		  <input type="password" id="conf" name="conf"><br><br>
		  <label for="firstN">First Name:</label>
		  <input type="text" id="firstN" name="firstN"><br><br>
		  <label for="lastN">Last Name:</label>
		  <input type="text" id="lastN" name="lastN"><br><br>
		  <label for="SSN">SSN:</label>
		  <input type="text" id="ssn" name="ssn"><br><br>
		  <input type="submit" value="Create">
		</form>
		<br>
		<form method="get" action="admin.jsp">
            <input type="submit" value="Return to Admin Tools">
        </form>
		
	</body>
</html>