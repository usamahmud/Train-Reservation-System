<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Customer Rep</title>
</head>
<body>


<% try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();

			String user = request.getParameter("username");
			String pass = request.getParameter("pass");
			String confirm = request.getParameter("conf");
			String firstN = request.getParameter("firstN");
			String lastN = request.getParameter("lastN");	
			String ssn = request.getParameter("ssn");
			
			if(user.isEmpty() || pass.isEmpty() || confirm.isEmpty() || firstN.isEmpty() || lastN.isEmpty() || ssn.isEmpty()){
				out.println("Empty value found. Please try again.");
						%>
						<form method="get" action="addRep.jsp">
	            		<input type="submit" value="Click to Try Again">
		        		</form>
		        		<%
			}
			else{
				PreparedStatement checkUsername = con.prepareStatement("SELECT Username from TrainSystem.employee where employee.Username=?");
				checkUsername.setString(1, user);
				
				ResultSet rs = checkUsername.executeQuery();
				boolean userExists = rs.next();
				if(!userExists && pass.equals(confirm)){
					
					String insert = "INSERT INTO TrainSystem.employee" + " VALUES " + "('" + user + "','" + firstN + "','" + lastN + "','" + pass + "','" + ssn + "','" + "0" + "')";
					stmt.executeUpdate(insert);
					
					out.println("Rep Account created!"); %>
					<form method="get" action="admin.jsp">
	            		<input type="submit" value="Return to Admin Tools">
	        		</form>
	        		<%
				}
				else if(userExists){
					out.println("Employee Username already exists. Please try with a different one."); %>
					<form method="get" action="addRep.jsp">
	            		<input type="submit" value="Click to Try Again">
	        		</form>
	        		<%
				}
				else if(!(pass.equals(confirm))){
					out.println("Passwords did not match. Please try again."); %>
					<form method="get" action="addRep.jsp">
	            		<input type="submit" value="Click to Try Again">
	        		</form>
	        	<%
				}			
				db.closeConnection(con);
			
			}%>
		<%} catch (Exception e) {
			out.print(e);
		}%>
<br>



</body>
</html>
