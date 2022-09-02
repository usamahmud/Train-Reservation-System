<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Customer Page</title>
	</head>
	<body>
		<h2>Welcome Customer <% out.println(session.getAttribute("firstName")); %> <% out.println(session.getAttribute("lastName")); %>!</h2>
		<h4>Search for Train Schedules:</h4>	
		<form method="post" action="browseTrainSched.jsp">
			<select name="searchBy">
				<option>Origin</option>
				<option>Destination</option>
				<option>Date of Travel</option>
			</select>
			<input type="text" name="searchInput">
			<br>
			<input type="submit" value="Search">
		</form>							 
		<br>*For origin and destination, please enter the name of a city.<br>
		*For date of travel, please enter a date in the format: YYYY-MM-DD.<br>
		
		<h4>Make a Reservation Here:</h4>	
		<form method="post" action="makeReservation.jsp">
			<table>
				<tr>    
					<td>Transit Line Name:</td><td><input type="text" name="transitLineName"></td>
				</tr>
				<tr>    
					<td>Origin Station Name:</td><td><input type="text" name="originStation"></td>
				</tr>
				<tr>
					<td>Destination Station Name:</td><td><input type="text" name="destinationStation"></td>
				</tr>
			</table>
			<select name="tripOption">
				<option>One Way</option>
				<option>Round Trip</option>
			</select>
			<select name="discount">
				<option>None</option>
				<option>Child</option>
				<option>Senior</option>
				<option>Disabled</option>
			</select>
			<br><br>
			<input type="submit" value="Make Reservation">
		</form>	
		
		<h4>Current Reservations:</h4>
		<form method="get" action="currentReservations.jsp">
			<input type="submit" value="View or Cancel">
		</form>
		
		<h4>Past Reservations:</h4>
		<form method="get" action="pastReservations.jsp">
			<input type="submit" value="View">
		</form>
		
		<h4>Ask Questions or View Questions and Answers:</h4>
		<form method="get" action="customerQuestions.jsp">
			<input type="submit" value="Ask or View">
		</form>
		
		<br>
		<form method="get" action="index.jsp">
			<input type="submit" value="Logout">
		</form>
	</body>
</html>