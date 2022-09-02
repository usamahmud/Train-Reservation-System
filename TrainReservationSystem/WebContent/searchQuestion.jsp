<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Search Question</title>
	</head>
	<body>
		<% 
			try {
				String keyword = request.getParameter("keyword");
				
				%><h2>Questions that contain "<%out.print(keyword);%>":</h2><%
				
				//Get the database connection
				ApplicationDB database = new ApplicationDB();	
				Connection connection = database.getConnection();		

				//Create a SQL statement
				PreparedStatement searchKeyword = connection.prepareStatement("SELECT * FROM question WHERE Question LIKE ?");
				searchKeyword.setString(1, "%" + keyword + "%");

				//Run the query against the database.
				ResultSet result = searchKeyword.executeQuery();
				while (result.next()) {
					out.println("Date Asked: " + result.getString("DateAsked"));
					%><br><%
					out.println("Question: " + result.getString("Question"));
					%><br><%
					if (result.getString("Response") == null) {
						out.println("No Response Yet.");
					} else {
						out.println("Response: " + result.getString("Response"));
					}
					%><br><%%><br><%
				}

				//close the connection.
				database.closeConnection(connection);
				
			} catch (Exception e) {
				out.print(e);
			}
		%>
		<form method="get" action="customerQuestions.jsp">
            <input type="submit" value="Go Back">
        </form>
	</body>
</html>