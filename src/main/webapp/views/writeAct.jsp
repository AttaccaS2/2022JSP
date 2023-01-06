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
qry.append(" insert into big_board (bo_num, bo_category, bo_title, bo_content, bo_mb_id, bo_mb_name, bo_hit, bo_inputdate, bo_ip)  ");
qry.append(" VALUES (null,?,?,?,?,?,0,now(),?)   ");
String sql = qry.toString();

Connection conn = null;
PreparedStatement stmt = null; 

try{
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(url, user, password);
	
	stmt = conn.prepareStatement(sql);	
	stmt.setString(1,request.getParameter("bo_category"));
	stmt.setString(2,request.getParameter("bo_title"));
	stmt.setString(3,request.getParameter("bo_content"));
	stmt.setString(4,(String)session.getAttribute("sess_id"));
	stmt.setString(5,(String)session.getAttribute("sess_name"));
	stmt.setString(6, request.getRemoteAddr()); //ip주소 가져오는 코드
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