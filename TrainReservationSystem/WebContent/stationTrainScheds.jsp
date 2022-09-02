<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Station Train Schedules</title>
	</head>
	<body>


		<% try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();

			String scheds = request.getParameter("stationScheds");
			
			
			String sql = "SELECT DISTINCT t.TransitLineName, tr.OriginStation, tr.DestinationStation " +
						 "FROM trainSchedule t, travelsTo tr, station s, hasStops h " +
						 "WHERE t.TrainID = tr.TrainID AND " + "(" + "tr.OriginStation=" + "'" + scheds + "'" + " OR tr.DestinationStation=" + "'" + scheds + "')";
			
			
			if(scheds.isEmpty()){
				%>Please enter the name of the Station.<%
			}
			else{
					out.println("Station Schedules: ");
					ResultSet rs = stmt.executeQuery(sql);
					while(rs.next()){
						String transitL = rs.getString("TransitLineName");
						String origin = rs.getString("OriginStation");
						String destination = rs.getString("DestinationStation");

						%><br><%
						out.println("Transit Line Name: " + transitL);
						%><br><%
						out.println("Origin Station: " + origin);
						%><br><%
						out.println("Destination Station: " + destination);
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