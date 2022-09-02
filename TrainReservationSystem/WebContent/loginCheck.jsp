<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Login Check</title>
	</head>
	<body>
		<% 
			try {
				String username = request.getParameter("username");
				session.setAttribute("username", username);
				String password = request.getParameter("password");
		
				//Get the database connection
				ApplicationDB database = new ApplicationDB();	
				Connection connection = database.getConnection();		
	
				//Create a SQL statement
				PreparedStatement checkUsername = connection.prepareStatement("SELECT c.Username FROM customer c WHERE c.Username=?");
				checkUsername.setString(1, username);
				
				//Run the query against the database.
				ResultSet resultUsername = checkUsername.executeQuery();
				boolean customerExists = resultUsername.next();
	
				PreparedStatement checkEmployee = connection.prepareStatement("SELECT e.Username FROM employee e WHERE e.Username=?");
				checkEmployee.setString(1, username);
				
				ResultSet resultEmployee = checkEmployee.executeQuery();
				
				if (!customerExists && !resultEmployee.next()) {
					session.setAttribute("error", "Invalid username. Try again.");
					response.sendRedirect("index.jsp");
				} else if(customerExists){		
					//Password Check
					PreparedStatement checkPassword = connection.prepareStatement("SELECT * FROM customer c WHERE c.Username=? AND c.Password=?");
					
					checkPassword.setString(1, username);
					checkPassword.setString(2, password);
	
					ResultSet resultPassword = checkPassword.executeQuery();

					if (!resultPassword.next()) {
						session.setAttribute("error", "Wrong password. Try again.");
						response.sendRedirect("index.jsp");
					} else {
						session.setAttribute("firstName", resultPassword.getString("FirstName"));
						session.setAttribute("lastName", resultPassword.getString("LastName"));
						response.sendRedirect("customer.jsp");	
					}
				}
				else{
					PreparedStatement checkEmployeePass = connection.prepareStatement("SELECT * FROM employee e WHERE e.Username=? AND e.Password=?");
					
					checkEmployeePass.setString(1, username);
					checkEmployeePass.setString(2, password);
	
					ResultSet resultEmployeePass = checkEmployeePass.executeQuery();
					
					PreparedStatement checkAdmin = connection.prepareStatement("SELECT * FROM employee e WHERE e.Username=? AND e.Password=? AND e.isAdmin=1");
					
					checkAdmin.setString(1, username);
					checkAdmin.setString(2, password);
	
					ResultSet resultAdmin = checkAdmin.executeQuery();
					boolean adminExists = resultAdmin.next();
					
					if (!resultEmployeePass.next() && !adminExists) {
						session.setAttribute("error", "Wrong password. Try again.");
						response.sendRedirect("index.jsp");
					} else if(adminExists) {
						session.setAttribute("firstName", resultEmployeePass.getString("FirstName"));
						session.setAttribute("lastName", resultEmployeePass.getString("LastName"));

						response.sendRedirect("admin.jsp");	
					}
					else{
						session.setAttribute("firstName", resultEmployeePass.getString("FirstName"));
						session.setAttribute("lastName", resultEmployeePass.getString("LastName"));
						
						response.sendRedirect("customerRep.jsp");
					}
				}
				
				//close the connection.
				database.closeConnection(connection);
			} catch (Exception e) {
				out.print(e);
			}
		%>
	</body>
</html>