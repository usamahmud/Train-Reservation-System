<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Cancel Reservation</title>
	</head>
	<body>
		<% 
			try {
				String reservationNumber = request.getParameter("reservationNumber");
		
				//Get the database connection
				ApplicationDB database = new ApplicationDB();	
				Connection connection = database.getConnection();		
	
				//Create a SQL statement
				PreparedStatement checkReservation = connection.prepareStatement("SELECT * FROM reservation r WHERE r.ReservationNumber=?");
				checkReservation.setString(1, reservationNumber);
				
				//Run the query against the database.
				ResultSet result = checkReservation.executeQuery();
				boolean exists = result.next();
				
				if (!exists) {
					out.println("That reservation number does not exist.");
				} else {		
					PreparedStatement cancel = connection.prepareStatement("DELETE FROM reservation r WHERE r.ReservationNumber=?");
					cancel.setString(1, reservationNumber);
					cancel.executeUpdate();
					
					response.sendRedirect("currentReservations.jsp");
				}
				
				//close the connection.
				database.closeConnection(connection);
				
			} catch (Exception e) {
				out.print(e);
			}
		%>
		<form method="get" action="currentReservations.jsp">
            <input type="submit" value="Go Back">
        </form>
	</body>
</html>