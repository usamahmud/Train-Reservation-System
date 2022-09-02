<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Browse Stops</title>
	</head>
	<body>	
		<% 
			try {
				String transitLineName = request.getParameter("transitLineName");
				
				//Get the database connection
				ApplicationDB database = new ApplicationDB();	
				Connection connection = database.getConnection();
				
				//Create a SQL statement
				PreparedStatement checkName = connection.prepareStatement("SELECT * FROM trainSchedule t WHERE t.TransitLineName=?");
				checkName.setString(1, transitLineName);
				
				//Run the query against the database.
				ResultSet resultName = checkName.executeQuery();
				if (!resultName.next()) {
					out.println("The transit line name does not exist. Please try again.");
				} else {
					%><h4><%out.println("Stops for " + transitLineName + ":");%></h4><%
					
					out.print("<table border=\"1 px solid black\">");
					out.print("<tr>");
					
					out.print("<td>");
					out.print("Station Name");
					out.print("</td>");
					
					out.print("<td>");
					out.print("Station City");
					out.print("</td>");
					
					out.print("<td>");
					out.print("Arrival Time");
					out.print("</td>");
					
					out.print("<td>");
					out.print("Departure Time");
					out.print("</td>");
					
					out.print("</tr>");

					PreparedStatement list = 
							connection.prepareStatement("SELECT * " +
														"FROM station s, hasStops h " +
														"WHERE h.StationID=s.StationID " +
														"AND h.TransitLineName=? " +
														"ORDER BY ArrivalTime ASC");
					list.setString(1, transitLineName);
					
					//Run the query against the database.
					ResultSet result = list.executeQuery();
					while (result.next()) {
						out.print("<tr>");
						
						out.print("<td>");
						out.print(result.getString("Name"));
						out.print("</td>");
						
						out.print("<td>");
						out.print(result.getString("City"));
						out.print("</td>");
						
						out.print("<td>");
						out.print(result.getString("ArrivalTime"));
						out.print("</td>");
						
						out.print("<td>");
						out.print(result.getString("DepartureTime"));
						out.print("</td>");
						
						out.print("</tr>");
					}
					
					out.print("</table>");
				}
				
				//close the connection.
				database.closeConnection(connection);
			} catch (Exception e) {
				out.print(e);
			}
		%>
		<br>
		<form method="get" action="browseTrainSched.jsp">
            <input type="submit" value="Go Back">
        </form>
	</body>
</html>