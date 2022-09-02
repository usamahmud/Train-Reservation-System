<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.text.*,java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Current Reservations</title>
	</head>
	<body>	
		<h2>Current Reservations:</h2>
		<% 
			try {			
				out.print("<table border=\"1 px solid black\">");
				out.print("<tr>");
				
				out.print("<td>");
				out.print("Reservation Number");
				out.print("</td>");
				
				out.print("<td>");
				out.print("Date Made");
				out.print("</td>");
				
				out.print("<td>");
				out.print("Total Fare");
				out.print("</td>");
				
				out.print("<td>");
				out.print("Transit Line Name");
				out.print("</td>");
				
				out.print("<td>");
				out.print("Departure Time");
				out.print("</td>");
				
				out.print("<td>");
				out.print("Arrival Time");
				out.print("</td>");
				
				out.print("</tr>");
				
				//Get the database connection
				ApplicationDB database = new ApplicationDB();	
				Connection connection = database.getConnection();
				
				//Create a SQL statement
				PreparedStatement getPast = connection.prepareStatement(
						"SELECT * FROM reservation " +
						"INNER JOIN reservationFor ON reservation.ReservationNumber = reservationFor.ReservationNumber " +
						"INNER JOIN trainSchedule ON trainSchedule.TransitLineName = reservationFor.TransitLineName " +
						" WHERE Username=? " +
						"AND DepartureTime >= NOW()");
				getPast.setString(1, session.getAttribute("username").toString());
				
				//Run the query against the database.
				ResultSet result = getPast.executeQuery();
				while (result.next()) {
					out.print("<tr>");
					
					out.print("<td>");
					out.print(result.getString("ReservationNumber"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(result.getString("DateMade"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(result.getString("TotalFare"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(result.getString("TransitLineName"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(result.getString("DepartureTime"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(result.getString("ArrivalTime"));
					out.print("</td>");
					
					out.print("</tr>");
				}
				
				out.print("</table>");
					
				//close the connection.
				database.closeConnection(connection);
				
			} catch (Exception e) {
				out.print(e);
			}
		%>
		
		<h4>Cancel Existing Reservation Here:</h4>
		<form method="post" action="cancelReservation.jsp">
			<table>
				<tr>
					<td>Reservation Number:</td><td><input type="text" name="reservationNumber"></td>
				</tr>
			</table>
            <input type="submit" value="Cancel Reservation">
		</form>
		
		<br>
		<form method="get" action="customer.jsp">
            <input type="submit" value="Go Back">
        </form>
	</body>
</html>