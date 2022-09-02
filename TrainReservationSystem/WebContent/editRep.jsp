<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Edit Customer Rep</title>
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
			
			String sql = "SELECT * FROM employee e WHERE e.Username = "+"'"+ user+"'"+" AND "+"isAdmin = 0";
			
			if(user.isEmpty()){
				%>Please enter the username of the customer rep.<%
			}
			else{
					ResultSet rs = stmt.executeQuery(sql);
					if(rs.next()){
						%><h2>Current Customer Representative Information:</h2><%
						String usern = rs.getString("Username");
						out.println("Username: " + user);
						%><br><%
						String pass = rs.getString("Password");
						out.println("Password: " + pass);
						%><br><%
						String first = rs.getString("FirstName");
						out.println("First Name: " + first);
						%><br><%
						String last = rs.getString("LastName");
						out.println("Last Name: " + last);
						%><br><%
						String ssn = rs.getString("SSN");
						out.println("SSN: " + ssn);
						%><br>
						<h2>Update Field: </h2>


						<form name = "newUserForm" action="editedRep.jsp">
						  <label for="pass">Password:</label>
						  <input type="password" id="pass" name="pass"><br><br>
						  <label for="conf">Confirm Password:</label>
						  <input type="password" id="conf" name="conf"><br><br>
						  <label for="firstN">First Name:</label>
						  <input type="text" id="firstN" name="firstN"><br><br>
						  <label for="lastN">Last Name:</label>
						  <input type="text" id="lastN" name="lastN"><br><br>
						  <label for="SSN">SSN:</label>
						  <input type="text" id="ssn" name="ssn"><br><br>
						  <input type="submit" value="Update">
						</form><%
					}
					else{
						%>The customer representative you specified does not exist.<%
					}
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