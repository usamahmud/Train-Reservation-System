<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Best Customer</title>
	</head>
	<body>
	<h1> Revenue by Month </h1>
 	<p1> Note: Any months not listed had a revenue of 0.00 </p1>
 	<br>
		<% try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
		

			//Create a SQL statement
			Statement stmt = con.createStatement();		
			
			String sql = "SELECT SUM(r.TotalFare), MONTHNAME(r.DateMade) FROM reservation r " +
					"GROUP BY MONTH(r.DateMade) "+
					"ORDER BY MONTH(r.DateMade)";
			

					ResultSet rs = stmt.executeQuery(sql);
					while(rs.next()){
						String sum = rs.getString("SUM(r.TotalFare)");
						String date = rs.getString("MONTHNAME(r.DateMade)");
						%><br><%
						out.println(date);
						%><br><%
						out.println("Revenue: " + sum);
						%><br><%

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