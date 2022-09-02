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
	<h1> Best Customer </h1>

		<% try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//SELECT MAX(customerSum), sumCustomer.Username
//FROM (SELECT SUM(r.TotalFare) as customerSum, r.Username 
//FROM reservation r, customer c 
//WHERE c.Username = r.Username
//GROUP BY r.Username) sumCustomer

			
			//Create a SQL statement
			Statement stmt = con.createStatement();		
			
			String sql = "SELECT SUM(r.TotalFare) as customerSum, r.Username as userN " +
					 		"FROM reservation r, customer c  " +
						 	"WHERE c.Username = r.Username " +
					 		"GROUP BY r.Username ORDER BY SUM(r.TotalFare) DESC LIMIT 1";
			
					double total = 0;
					ResultSet rs = stmt.executeQuery(sql);
					while(rs.next()){
						String sum = rs.getString("customerSum");
						String userN = rs.getString("userN");

						out.println(userN);
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