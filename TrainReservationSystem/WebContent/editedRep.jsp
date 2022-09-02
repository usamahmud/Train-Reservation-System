<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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

			
			String usern = (String) session.getAttribute("repUser");
			String pass = request.getParameter("pass");
			String confirm = request.getParameter("conf");
			String firstN = request.getParameter("firstN");
			String lastN = request.getParameter("lastN");	
			String ssn = request.getParameter("ssn");
			
			if (pass.isEmpty() && confirm.isEmpty() && firstN.isEmpty() && lastN.isEmpty() && ssn.isEmpty()){
				out.println("All fields are empty. Please try again.");
						%>
						<form method="get" action="admin.jsp">
	            		<input type="submit" value="Click to Try Again">
		        		</form>
		        		<%
			} else {
				if (!pass.isEmpty()) {
					if (pass.equals(confirm)) {
						PreparedStatement changePass = con.prepareStatement("UPDATE employee SET Password=? WHERE Username=?");
						changePass.setString(1, pass);
						changePass.setString(2, usern);
						changePass.executeUpdate();
						
					} else {
						out.println("Passwords do not match. Please try again."); %>
						<form method="get" action="admin.jsp">
		            		<input type="submit" value="Click to Try Again">
		        		</form>
		        		<%
		        		
		        		return;
					}
				}
				
				if (!firstN.isEmpty()) {
						PreparedStatement changeFirstN = con.prepareStatement("UPDATE employee SET FirstName=? WHERE Username=?");
						changeFirstN.setString(1, firstN);
						changeFirstN.setString(2, usern);
						changeFirstN.executeUpdate();
				}
				
				if (!lastN.isEmpty()) {
					PreparedStatement changeLastN = con.prepareStatement("UPDATE employee SET LastName=? WHERE Username=?");
					changeLastN.setString(1, lastN);
					changeLastN.setString(2, usern);
					changeLastN.executeUpdate();
				}
				
				if (!ssn.isEmpty()) {
					PreparedStatement changeSSN = con.prepareStatement("UPDATE employee SET SSN=? WHERE Username=?");
					changeSSN.setString(1, ssn);
					changeSSN.setString(2, usern);
					changeSSN.executeUpdate();
				}
				
				out.println("Customer rep account updated!"); %>
				<form method="get" action="admin.jsp">
            		<input type="submit" value="Return to Admin Tools">
        		</form>
        		<%
			}
				
			db.closeConnection(con);
			
		} catch (Exception e) {
			out.print(e);
		}%>
<br>



</body>
</html>
