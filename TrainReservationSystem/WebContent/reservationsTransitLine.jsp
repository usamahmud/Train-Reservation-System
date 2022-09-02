<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Reservations By Transit Line</title>
	</head>
	<body>


		<% try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();

			String transit = request.getParameter("rTransit");
			
			
			String sql = "SELECT DISTINCT r.ReservationNumber, r.Username " +
						 "FROM reservation r, reservationFor rf " +
						 "WHERE rf.TransitLineName=" + "'" + transit + "'";
			
			
			if(transit.isEmpty()){
				%>Please enter the name of the Station.<%
			}
			else{
					out.println("Reservations for "+transit+":");
					ResultSet rs = stmt.executeQuery(sql);
					while(rs.next()){
						String reservation = rs.getString("ReservationNumber");
						String user = rs.getString("Username");

						%><br><%
						out.println("Reservation Number: " + reservation);
						%><br><%
						out.println("Customer: " + user);
						%><br><%
				
					}
			}			
			
			db.closeConnection(con);
			
			
		} catch (Exception e) {
			out.print(e);
		}%>
		
		<br>
		<form method="get" action="admin.jsp">
            <input type="submit" value="Return to Admin Tools">
        </form>
				
	</body>
</html>