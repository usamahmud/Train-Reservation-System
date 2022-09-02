<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Delete Customer Rep</title>
	</head>
	<body>
		
		<% try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();

			String user = request.getParameter("username");
			session.setAttribute("repUser", user);
			
			String sql = "SELECT * FROM employee e WHERE e.Username = "+"'"+ user+"'";
			String delete ="DELETE FROM employee e WHERE e.Username = "+"'"+ user+"'";
			
			if(user.isEmpty()){
				out.println("Please enter the name of the customer representative that you want to delete.");
			}
			else{
					ResultSet rs = stmt.executeQuery(sql);
					if(rs.next()){
						stmt.executeUpdate(delete);
						out.println("Customer representative removed!");
					}
					else{
						out.println("The given customer representative does not exist.");
					}
			}			
			
			db.closeConnection(con);
			
			
		} catch (Exception e) {
			out.print(e);
		}%>
		
		<form method="get" action="admin.jsp">
            <input type="submit" value="Return to Admin Tools">
        </form>
		
	</body>
</html>