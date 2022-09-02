<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Rep Account Creation</title>
</head>
<body>


<% try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();

			String trainid = (String) session.getAttribute("trainTrainID");
			String fare = request.getParameter("fare");
			String stops = request.getParameter("stops");
			String arrival = request.getParameter("arrivalTime");
			String departure = request.getParameter("departureTime");	
			String travel = request.getParameter("travelTime");
			
			if(trainid.isEmpty() && fare.isEmpty() && stops.isEmpty() && arrival.isEmpty() && departure.isEmpty() && travel.isEmpty()){
				out.println("Empty values found. Please try again.");
						%>
						<form method="get" action="editRep.jsp">
	            		<input type="submit" value="Click to Try Again">
		        		</form>
		        		<%
			}
			else{
				char ch = '"';
				
				ResultSet rs = stmt.executeQuery("SELECT TrainID from TrainSystem.trainSchedule where trainSchedule.TrainID=" + ch + trainid + ch); 
				if(rs.next()){
					
					if(!fare.isEmpty()){
						String update = "UPDATE TrainSystem.trainSchedule"+" SET "+"Fare="+"'"+fare+"'" + " WHERE trainSchedule.TrainID="+ ch + trainid + ch;
						stmt.executeUpdate(update);
					}
					
					if(!stops.isEmpty()){
						String update = "UPDATE TrainSystem.trainSchedule"+" SET "+"Stops="+"'"+stops+"'" + " WHERE trainSchedule.TrainID="+ ch + trainid + ch;
						stmt.executeUpdate(update);
					}
					
					if(!arrival.isEmpty()){
						String update = "UPDATE TrainSystem.trainSchedule"+" SET "+"ArrivalTime="+"'"+arrival+"'" + " WHERE trainSchedule.TrainID="+ ch + trainid + ch;
						stmt.executeUpdate(update);
					}
					
					if(!departure.isEmpty()){
						String update = "UPDATE TrainSystem.trainSchedule"+" SET "+"DepartureTime="+"'"+departure+"'" + " WHERE trainSchedule.TrainID="+ ch + trainid + ch;
						stmt.executeUpdate(update);
					}
					
					if(!travel.isEmpty()){
						String update = "UPDATE TrainSystem.trainSchedule"+" SET "+"TravelTime="+"'"+travel+"'" + " WHERE trainSchedule.TrainID="+ ch + trainid + ch;
						stmt.executeUpdate(update);
					}
			
					out.println("Train Schedule updated!"); %>
					<form method="get" action="customerRep.jsp">
	            		<input type="submit" value="Return to Customer Rep Tools">
	        		</form>
	        		<%
				}

				}			
				db.closeConnection(con);
			
			
		} catch (Exception e) {
			out.print(e);
		}%>
<br>



</body>
</html>
