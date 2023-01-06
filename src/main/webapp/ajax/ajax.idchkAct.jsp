<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
String url= "jdbc:mysql://localhost:3306/bigdata?serverTimezone=Asia/Seoul";
String user= "root";
String password= "bigdata";

StringBuffer qry= new StringBuffer();
qry.append(" SELECT count(*) FROM big_member where mb_id=?  ");
String sql = qry.toString();

Connection conn = null;
PreparedStatement stmt = null; 
ResultSet rs = null;

String ajaxMessage = "Fail";

try{
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(url, user, password);
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, request.getParameter("mb_id"));
	rs = stmt.executeQuery();
	if(rs.next()){
		int idChkNum = rs.getInt("count(*)");
		if(idChkNum == 0){
			ajaxMessage = "Success";
		}else{
			ajaxMessage = "Fail";
		}
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
out.print(ajaxMessage);
%>