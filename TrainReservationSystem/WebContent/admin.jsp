<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Admin Tools</title>
	</head>
	<body>
		<h2>Welcome Admin <% out.println(session.getAttribute("firstName")); %> <% out.println(session.getAttribute("lastName")); %>!</h2>								  
		
		<p1>Add, Edit, Delete Customer Rep Info</p1>
		<form method="get" action="addRep.jsp">
            <input type="submit" value="Add">
        </form>
        <br>
		<form method="get" action="editRep.jsp">
			<table>
					<tr>    
						<td>Customer Rep Username:</td><td><input type="text" name="username"></td>
					</tr>
			</table>
            <input type="submit" value="Edit">
        </form>
        <br>
        <form method="get" action="deleteRep.jsp">
        	<table>
					<tr>    
						<td>Customer Rep Username:</td><td><input type="text" name="username"></td>
					</tr>
			</table>
            <input type="submit" value="Delete">
        </form>
		<br>
		
		<p2>Sales Report by Month</p2>
		<form method="get" action="monthlySales.jsp">
            <input type="submit" value="View">
        </form>
		<br>
		
		<p3>Reservations List</p3>
		<form method="get" action="reservationsTransitLine.jsp">
            <table>
					<tr>    
						<td>Transit Line: </td><td><input type="text" name="rTransit"></td>
					</tr>
			</table>
			<input type="submit" value="View">
        </form>
        <form method="get" action="reservationsCustomer.jsp">
            <table>
					<tr>    
						<td>Customer (Username): </td><td><input type="text" name="rCustomer"></td>
					</tr>
			</table>
			<input type="submit" value="View">
        </form>
		<br>
		
		<p4>Revenue Listing</p4>
		<form method="get" action="revenueTransitLine.jsp">
            <table>
					<tr>    
						<td>Transit Line: </td><td><input type="text" name="rTransit"></td>
					</tr>
			</table>
			<input type="submit" value="View">
        </form>
        <form method="get" action="revenueCustomers.jsp">
            <table>
					<tr>    
						<td>Customer (Username): </td><td><input type="text" name="rCustomer"></td>
					</tr>
			</table>
			<input type="submit" value="View">
        </form>
		<br>
		
		<p5>Best Customer</p5>
		<form method="get" action="bestCustomer.jsp">
            <input type="submit" value="View">
        </form>
		<br>
		
		<p6>Best 5 Active Transit Lines</p6>
		<form method="get" action="top5Transit.jsp">
            <input type="submit" value="View">
        </form>
		<br>
		<form method="get" action="index.jsp">
			<input type="submit" value="Log Out">
		</form>
		
	</body>
</html>