<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
//로그아웃하는거니까 세션 삭제후 login.jsp로 이동
session.invalidate(); 
response.sendRedirect("login.jsp");

%>

