<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Edit Train Schedule</title>
	</head>
	<body>

		<% try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();

			String trainID = request.getParameter("trainID");
			session.setAttribute("trainTrainID", trainID);
			
			String sql = "SELECT * FROM trainSchedule t WHERE t.TrainID = "+"'"+ trainID+"'";
			
			if(trainID.isEmpty()){
				out.println("Please enter a Train ID.");
			}
			else{
				ResultSet rs = stmt.executeQuery(sql);
				if(rs.next()){
					%><h2>Current Train Schedule Information</h2><%
					out.println("TrainID: " + trainID);
					%><br><%
					String transitLine = rs.getString("TransitLineName");
					out.println("Transit Line Name: " + transitLine);
					%><br><%
					String fare = rs.getString("Fare");
					out.println("Fare: " + fare);
					%><br><%
					String stops = rs.getString("Stops");
					out.println("Stops: " + stops);
					%><br><%
					String arrivalTime = rs.getString("ArrivalTime");
					out.println("Arrival Time: " + arrivalTime);
					%><br><%
					String departureTime = rs.getString("DepartureTime");
					out.println("Departure Time: " + departureTime);
					%><br><%
					String travelTime = rs.getString("TravelTime");
					out.println("Travel Time: " + travelTime);
					%><br>
					<h2>Update Field: </h2>
					<form name = "newTrainForm" action="editedTrainSched.jsp">
					  <label for="fare">Fare:</label>
					  <input type="text" id="fare" name="fare"><br><br>
					  <label for="stops">Stops:</label>
					  <input type="text" id="stops" name="stops"><br><br>
					  <label for="arrivalTime">Arrival Time (Format: YYYY-MM-DD HH:MM:SS.S):</label>
					  <input type="text" id="arrivalTime" name="arrivalTime"><br><br>
					  <label for="departureTime">Departure Time (Format: YYYY-MM-DD HH:MM:SS.S):</label>
					  <input type="text" id="departureTime" name="departureTime"><br><br>
					  <label for="travelTime">Travel Time (Format: HH:MM:SS.S):</label>
					  <input type="text" id="travelTime" name="travelTime"><br><br>
					  <input type="submit" value="Update">
					</form><%
				}
				else{
					out.println("Train ID does not exist.");
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