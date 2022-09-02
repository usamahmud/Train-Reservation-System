<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Delete Train Schedule</title>
	</head>
	<body>
		
		<% try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();

			String train = request.getParameter("trainID");

			
			String sql = "SELECT * FROM trainSchedule t WHERE t.TrainID = "+"'"+ train+"'";
			String delete ="DELETE FROM trainSchedule t WHERE t.TrainID = "+"'"+ train+"'";
			
			if(train.isEmpty()){
				out.println("Please enter a train ID.");
			}
			else{
					ResultSet rs = stmt.executeQuery(sql);
					if(rs.next()){
						stmt.executeUpdate(delete);
						out.println("Train Schedule removed.");
					}
					else{
						out.println("The Train ID does not exist.");
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