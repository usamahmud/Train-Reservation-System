<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Customers by Transit Line Name and Date</title>
	</head>
	<body>


		<% try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();

			String transitL = request.getParameter("transit");
			String date = request.getParameter("transitDate");
			
			
			String sql = "SELECT r.Username " +
			"FROM reservation r, reservationFor rf, trainSchedule t " +
			"WHERE ( CAST(t.ArrivalTime AS DATE)=" + "'" + date + "' " + " OR CAST(t.DepartureTime AS DATE)="+ "'" + date + "' " + ") " +
			"AND rf.TransitLineName=" + "'" + transitL + "'" +
			"AND r.ReservationNumber = rf.ReservationNumber";
			
			
			if(transitL.isEmpty() && date.isEmpty()){
				%>Please enter the name of a Transit Line and Date.<%
			}
			else{
					%>
					<h1>Customer Reservations</h1> <%
					out.println("Transit Line: " + transitL);
					%><br><%
					out.println("Date: " + date);
					%><br><%
					ResultSet rs = stmt.executeQuery(sql);
					while(rs.next()){
						String username = rs.getString("Username");
						%><br><%
						out.println("Customer: " + username);
						%><br><%
		
					}
			}			
			
			db.closeConnection(con);
			
			
		} catch (Exception e) {
			out.print(e);
		}%>
		
		<br>
		<form method="get" action="customerRep.jsp">
            <input type="submit" value="Return to Customer Rep Tools">
        </form>
				
	</body>
</html>