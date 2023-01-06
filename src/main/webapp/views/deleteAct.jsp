<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");

String url= "jdbc:mysql://localhost:3306/bigdata?serverTimezone=Asia/Seoul";
String user= "root";
String password= "bigdata";

StringBuffer qry= new StringBuffer();
qry.append(" DELETE FROM big_board  ");
qry.append(" WHERE bo_num = ? ");
String sql = qry.toString();

Connection conn = null;
PreparedStatement stmt = null; 

try{
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(url, user, password);
	
	stmt = conn.prepareStatement(sql);	
	stmt.setInt(1,Integer.parseInt(request.getParameter("bo_num")) );

	stmt.executeUpdate(); //실행
}	catch(Exception e){
	
	}finally{
		try{
			if(stmt!=null) stmt.close();
			if(conn!=null) conn.close();
		}catch(Exception e){
			
		}

	}
%>

<%
response.sendRedirect("list.jsp");
%>