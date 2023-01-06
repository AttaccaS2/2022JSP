<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>


<%

String url= "jdbc:mysql://localhost:3306/bigdata?serverTimezone=Asia/Seoul";
String user= "root";
String password= "bigdata";

StringBuffer qry= new StringBuffer();
qry.append(" select * from big_member where mb_id=? and mb_pw=? ");
String sql = qry.toString();

Connection conn = null;
PreparedStatement stmt = null; 
ResultSet rs = null;

try{
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(url, user, password);
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, request.getParameter("mb_id"));
	stmt.setString(2, request.getParameter("mb_pw"));
	rs = stmt.executeQuery();
	if(rs.next()){
		String sess_id = rs.getString("mb_id");
		String sess_name = rs.getString("mb_name");
		
		session.setAttribute("sess_id", sess_id);
		session.setAttribute("sess_name", sess_name);
		
		response.sendRedirect("dashboard.jsp");
		
		
	} else{
		response.sendRedirect("login.jsp");
	}
} catch(Exception e){
		
}finally {
		try{
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
			if(conn!=null) conn.close();
		}catch(Exception e){
			
		}
	}
%>



