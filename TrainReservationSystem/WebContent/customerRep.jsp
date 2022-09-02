<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Customer Rep Tools</title>
	</head>
	<body>
		<h2>Welcome Customer Rep <% out.println(session.getAttribute("firstName")); %> <% out.println(session.getAttribute("lastName")); %>!</h2>								  
		
		<p1>Edit or Delete Train Schedules</p1>
		
		<br>
		<br>
		<form method="get" action="editTrainSched.jsp">
			<table>
					<tr>    
						<td>Train ID:</td><td><input type="text" name="trainID"></td>
					</tr>
			</table>
            <input type="submit" value="Edit">
        </form>
        <br>
        <form method="get" action="deleteTrainSched.jsp">
        	<table>
					<tr>    
						<td>Train ID:</td><td><input type="text" name="trainID"></td>
					</tr>
			</table>
            <input type="submit" value="Delete">
        </form>
		<br>


        
        <form method="get" action="stationTrainScheds.jsp">
			<table>
					<tr>    
						<td>Train Schedule for Station: </td><td><input type="text" name="stationScheds"></td>
					</tr>
			</table>
            <input type="submit" value="View">
        </form>
        
        <br>
        <p4>View Customers by Transit Line and Date</p4>
         <form method="get" action="transitDate.jsp">
			<table>
					<tr>    
						<td>Transit Line: </td><td><input type="text" name="transit"></td>
					</tr>
					<tr>    
						<td>Date: </td><td><input type="text" name="transitDate"></td>
					</tr>
			</table>
            <input type="submit" value="View">
        </form>
       
       <br>
       
       <% try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			String sql = "SELECT COUNT(q.Question) FROM question q WHERE q.Response IS NULL";
					
					out.println("Current Customer Questions: ");

					ResultSet rs = stmt.executeQuery(sql);
					while(rs.next()){
						String count = rs.getString("COUNT(q.Question)");
						%><br><%
						out.println(count);
		
					}
								
			db.closeConnection(con);		
			
		} catch (Exception e) {
			out.print(e);
		}%>
       
       <br>
       
       <form method="get" action="customerRepQuestions.jsp">
			<input type="submit" value="View Questions">
		</form>
		
		<br>
       
		<form method="get" action="index.jsp">
			<input type="submit" value="Log Out">
		</form>
		<br>
		
	</body>
</html>