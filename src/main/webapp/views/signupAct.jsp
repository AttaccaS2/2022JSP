<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");

//회원가입 후 로그인 페이지로 이동 & 넘어온 값을 받아서 출력
String mb_id = request.getParameter("mb_id"); 
String mb_pw = request.getParameter("mb_pw");
String mb_name = request.getParameter("mb_name");
String mb_email = request.getParameter("mb_email");
String mb_zipcode = request.getParameter("mb_zipcode");
String mb_addr = request.getParameter("mb_addr");
String mb_detailAddr = request.getParameter("mb_detailAddr");
String mb_phone= request.getParameter("mb_phone");
String mb_birth= request.getParameter("mb_birth");
String mb_gender= request.getParameter("mb_gender");

//jdbc 프로그래밍
String url= "jdbc:mysql://localhost:3306/bigdata?serverTimezone=Asia/Seoul";
String user= "root";
String password= "bigdata";

StringBuffer qry = new StringBuffer();
qry.append(" insert into big_member (mb_id, mb_pw, mb_name, mb_email, mb_zipcode, mb_addr, mb_detailAddr, mb_phone, mb_birth, mb_gender, mb_joindate)  ");
qry.append(" values ( ?, ?, ? ,? ,? ,? ,? ,?, ? ,? , now()) "); //?하는 이유는 보안때문

String sql = qry.toString();

int idx=1;
Connection conn = null;
PreparedStatement stmt=null;

try{
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(url, user, password); //Connection을 앞에서 선언해서 Connection conn = ~ 하면 에러남
	stmt= conn.prepareStatement(sql);
	//?에 값넣기
	stmt.setString(idx++, mb_id); //1 int idx=1;이니까 1이 먼저 나오고 1씩 더해짐
	stmt.setString(idx++, mb_pw); //2
	stmt.setString(idx++, mb_name);
	stmt.setString(idx++, mb_email);
	stmt.setString(idx++, mb_zipcode);
	stmt.setString(idx++, mb_addr);
	stmt.setString(idx++, mb_detailAddr);
	stmt.setString(idx++, mb_phone);
	stmt.setString(idx++, mb_birth);
	stmt.setString(idx++, mb_gender);
	
	//실행
	stmt.executeUpdate();
} catch(Exception e){
	e.getLocalizedMessage();
} finally{
	try{
		if(stmt !=null) stmt.close(); //닫는 태그 / 닫는 태그 없어도 상관없지만 너무 많은 사람이 한꺼번에 접속하면 서버 죽음
		if(conn !=null) stmt.close(); 	
	} catch(Exception e){
		e.getLocalizedMessage();
	}
}

%>

<%
//로그인페이지로 이동
response.sendRedirect("login.jsp");
%>