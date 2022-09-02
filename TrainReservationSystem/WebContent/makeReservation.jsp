<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.text.*,java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Make Reservations</title>
	</head>
	<body>	
		<% 
			try {
				String transitLineName = request.getParameter("transitLineName");
				String originStation = request.getParameter("originStation");
				String destinationStation = request.getParameter("destinationStation");
				
				if (transitLineName == "" || originStation == "" || destinationStation == "") {
					out.println("Please enter values for all the necessary fields.");
				} else {
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
						PreparedStatement checkOrigin = 
								connection.prepareStatement("SELECT * " +
															"FROM station s " +
															"INNER JOIN hasStops h ON s.StationID = h.StationID " +
															"WHERE h.TransitLineName=? " +
															"AND s.Name=?");
						checkOrigin.setString(1, transitLineName);
						checkOrigin.setString(2, originStation);
						ResultSet resultOrigin = checkOrigin.executeQuery();
						
						PreparedStatement checkDestination = 
								connection.prepareStatement("SELECT * " +
															"FROM station s " +
															"INNER JOIN hasStops h ON s.StationID = h.StationID " +
															"WHERE h.TransitLineName=? " +
															"AND s.Name=?");
						checkDestination.setString(1, transitLineName);
						checkDestination.setString(2, destinationStation);
						ResultSet resultDestination = checkDestination.executeQuery();
						if (!resultOrigin.next() || !resultDestination.next()) {
							out.println("The origin station or destination station does not exist in this transit line. " +
								"Please look at the train schedule and try again.");
						} else if (resultOrigin.getString("ArrivalTime").compareTo(resultDestination.getString("ArrivalTime")) >= 0) {
							out.println("The transit line does not travel to the two stations in the correct order.");
						} else {
							//10000 to 99999
							int randomInt = (int)(Math.random() * (90000) + 10000);
							PreparedStatement random = connection.prepareStatement("SELECT * FROM reservation WHERE ReservationNumber=?");
							random.setInt(1, randomInt);
							ResultSet resultRandom = random.executeQuery();
							while (resultRandom.next()) {
								resultRandom.close();
								randomInt = (int)(Math.random() * (90000) + 10000);
								random = connection.prepareStatement("SELECT * FROM reservation WHERE ReservationNumber=?");
								random.setInt(1, randomInt);
								resultRandom = random.executeQuery();
							}

							java.sql.Date date = new java.sql.Date(System.currentTimeMillis());
							
							PreparedStatement total = connection.prepareStatement("SELECT count(*) FROM hasStops WHERE TransitLineName=?");
							total.setString(1, transitLineName);
							ResultSet ts = total.executeQuery();
							ts.next();
							int totalStops = ts.getInt("count(*)") - 1;
							
							PreparedStatement passed = connection.prepareStatement("SELECT count(*) FROM hasStops " +
								"WHERE TransitLineName=? AND ArrivalTime BETWEEN ? AND ?");
							passed.setString(1, transitLineName);
							passed.setString(2, resultOrigin.getString("ArrivalTime"));
							passed.setString(3, resultDestination.getString("ArrivalTime"));
							ResultSet tp = passed.executeQuery();
							tp.next();
							int passedStops = tp.getInt("count(*)") - 1;

							float totalFare = resultName.getFloat("Fare") * (((float)passedStops)/totalStops);
							if (request.getParameter("tripOption").equals("Round Trip")) {
								totalFare *= 2;
							}
							if (request.getParameter("discount").equals("Child")) {
								totalFare *= 0.75;
							} else if (request.getParameter("discount").equals("Senior")) {
								totalFare *= 0.65;
							} else if (request.getParameter("discount").equals("Disabled")) {
								totalFare *= 0.5;
							}
							
							DecimalFormat df = new DecimalFormat("0.00");
							totalFare = Float.parseFloat(df.format(totalFare));
							
							PreparedStatement insertReservation = 
									connection.prepareStatement("INSERT INTO reservation VALUES " +
									"(?,?,?,?)");
							insertReservation.setInt(1, randomInt);
							insertReservation.setDate(2, date);
							insertReservation.setFloat(3, totalFare);
							insertReservation.setString(4, session.getAttribute("username").toString());
							insertReservation.executeUpdate();
							
							PreparedStatement insertReservationFor = 
									connection.prepareStatement("INSERT INTO reservationFor VALUES " +
									"(?,?,?,?,?)");
							insertReservationFor.setString(1, transitLineName);
							insertReservationFor.setInt(2, randomInt);
							insertReservationFor.setInt(3, resultOrigin.getInt("StationID"));
							insertReservationFor.setInt(4, resultDestination.getInt("StationID"));
							insertReservationFor.setString(5, resultName.getString("TrainID"));
							insertReservationFor.executeUpdate();
							
							%><h4>Success! Reservation Details:</h4><%
							out.println("Reservation Number: " + randomInt);
							%><br><%
							out.println("Username: " + session.getAttribute("username"));
							%><br><%
							out.println("Transit Line Name: " + transitLineName);
							%><br><%
							out.println("Train ID: " + resultName.getString("TrainID"));
							%><br><%
							out.println("Origin Station Name: " + originStation);
							%><br><%
							out.println("Destination Station Name: " + destinationStation);
							%><br><%
							out.println("Total Fare: $" + totalFare);
							%><br><%
							out.println("Date Made: " + date);
						}
					}
					
					//close the connection.
					database.closeConnection(connection);
				}
			} catch (Exception e) {
				out.print(e);
			}
		%>
		<br><br>
		<form method="get" action="customer.jsp">
            <input type="submit" value="Go Back">
        </form>
	</body>
</html>