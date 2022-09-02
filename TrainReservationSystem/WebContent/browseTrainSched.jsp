<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Browse Train Schedules</title>
	</head>
	<body>
		<h2>Resulting Schedules:</h2>	
		<% 
			try {
				String searchBy;
				if (request.getParameter("searchBy") != null) {
					searchBy = request.getParameter("searchBy");
					session.setAttribute("searchBy", searchBy);
				} else {
					searchBy = session.getAttribute("searchBy").toString();
				}
			
				String searchInput;
				if (request.getParameter("searchInput") != null) {
					searchInput = request.getParameter("searchInput");
					session.setAttribute("searchInput", searchInput);
				} else {
					searchInput = session.getAttribute("searchInput").toString();
				}
		
				String sort = "";
				if (request.getParameter("sortBy") != null) {
					if (request.getParameter("sortBy").equals("Arrival Time")) {
						sort = "ORDER BY ts.ArrivalTime ASC";
					} else if (request.getParameter("sortBy").equals("Departure Time")) {
						sort = "ORDER BY ts.DepartureTime ASC";
					} else if (request.getParameter("sortBy").equals("Fare")) {
						sort = "ORDER BY ts.Fare ASC";
					}
				}
				
				%><h4><%out.println(searchBy + " = " + searchInput);%></h4><%
				
				//Get the database connection
				ApplicationDB database = new ApplicationDB();	
				Connection connection = database.getConnection();		
	
				out.print("<table border=\"1 px solid black\">");
				out.print("<tr>");
				
				out.print("<td>");
				out.print("Transit Line Name");
				out.print("</td>");
				
				out.print("<td>");
				out.print("Origin Station");
				out.print("</td>");
				
				out.print("<td>");
				out.print("Origin City");
				out.print("</td>");
				
				out.print("<td>");
				out.print("Destination Station");
				out.print("</td>");
				
				out.print("<td>");
				out.print("Destination City");
				out.print("</td>");
				
				out.print("<td>");
				out.print("Fare");
				out.print("</td>");
				
				out.print("<td>");
				out.print("Departure Time");
				out.print("</td>");
				
				out.print("<td>");
				out.print("Arrival Time");
				out.print("</td>");
				
				out.print("</tr>");
				
				String template = "SELECT * " +
								  "FROM (" + 
								  	"SELECT * " +
									"FROM travelsTo t, " +
										"(SELECT StationID oid, City ocity, Name oname FROM station) o, " +
										"(SELECT StationID did, City dcity, Name dname FROM station) d " +
									"WHERE t.OriginStation = o.oid " +		
									"AND t.DestinationStation = d.did " +
								  ") c " +
								  "INNER JOIN trainSchedule ts ON c.TransitLineName = ts.TransitLineName ";
				PreparedStatement list;
				
				if (searchBy.equals("Origin")) {
					list = connection.prepareStatement(template + "WHERE c.ocity=? " + sort);
				} else if (searchBy.equals("Destination")) {
					list = connection.prepareStatement(template + "WHERE c.dcity=? " + sort);
				} else {
					list = connection.prepareStatement(template + "WHERE CAST(ts.DepartureTime AS DATE)=? " + sort);
				}
				
				list.setString(1, searchInput);
				
				//Run the query against the database.
				ResultSet result = list.executeQuery();
				while (result.next()) {
					out.print("<tr>");
					
					out.print("<td>");
					out.print(result.getString("TransitLineName"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(result.getString("oname"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(result.getString("ocity"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(result.getString("dname"));
					out.print("</td>");
					
					out.print("<td>");
					out.print(result.getString("dcity"));
					out.print("</td>");
					
					out.print("<td>");
					out.print("$" + result.getString("Fare"));
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
		<h4>Sort by a different criteria:</h4>
		<form method="post" action="browseTrainSched.jsp">
			<select name="sortBy">
				<option>Arrival Time</option>
				<option>Departure Time</option>
				<option>Fare</option>
			</select>
			<input type="submit" value="Sort">
		</form>
		<h4>Check out all the stops for a specific transit line name:</h4>
		<form method="post" action="stops.jsp">
			<input type="text" name="transitLineName">
			<input type="submit" value="Search">
		</form>	
		<br><br>
		<form method="get" action="customer.jsp">
            <input type="submit" value="Return to Customer Page">
        </form>
	</body>
</html>