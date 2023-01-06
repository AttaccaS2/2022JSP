<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%
String url= "jdbc:mysql://localhost:3306/bigdata?serverTimezone=Asia/Seoul";
String user= "root";
String password= "bigdata";

int pageRow = 20;
int p=1;
/* page는 위에 나오는 예약어라서 못써서 p */
String param = request.getParameter("p");
if(!(param == null || "".equals(param))){ /* null이나 빈값이 아닐때 */
	p=Integer.parseInt(param);
}

StringBuffer qry= new StringBuffer();
qry.append(" SELECT * FROM big_board  ORDER BY bo_num desc LIMIT " + ((pageRow*p)-pageRow) +   "," + pageRow );
/*  1페이지당 20줄이 나오도록 만들 예정 */
String sql = qry.toString();

Connection conn = null;
PreparedStatement stmt = null;
ResultSet rs = null;
List<HashMap<String, String>> list=new ArrayList<>();

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(url, user, password);
	
	stmt = conn.prepareStatement(sql);
	rs= stmt.executeQuery();
	
	while(rs.next()){
		HashMap<String, String> hm= new HashMap<String, String>();
		hm.put("bo_num",rs.getString("bo_num"));
		hm.put("bo_category",rs.getString("bo_category"));
		hm.put("bo_title",rs.getString("bo_title"));
		hm.put("bo_content",rs.getString("bo_content"));
		hm.put("bo_mb_id",rs.getString("bo_mb_id"));
		hm.put("bo_mb_name",rs.getString("bo_mb_name"));
		hm.put("bo_inputdate",rs.getString("bo_inputdate"));
		hm.put("bo_ip",rs.getString("bo_ip"));
		
		list.add(hm); /* ﻿추가하고 난 것을 배열에 넣어주는 함수 */
	}
	
} catch(Exception e){
	
} finally{
	try{
		if(rs!=null) rs.close();
		if(stmt!=null) stmt.close();
		if(conn!=null) conn.close();
	}catch(Exception e){		
	}
}

//또 다른 트라이 캐치 구문 시작
sql=" SELECT count(*) as cnt FROM big_board  "; /* 총 글수 */
int total =0 ;

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(url, user, password);
	stmt = conn.prepareStatement(sql);
	rs= stmt.executeQuery();
	
	if(rs.next()){
		total = rs.getInt("cnt");
		/* 별칭을 넣어주었다*/
	}
	
} catch(Exception e){
	
} finally{
	try{
		if(rs!=null) rs.close();
		if(stmt!=null) stmt.close();
		if(conn!=null) conn.close();
	}catch(Exception e){		
	}
}

%>    
<%@ include file="includes/header.jsp"%>
<% 
int totalPage = 0;
if(total % pageRow == 0){
	totalPage=total/pageRow;
}	else {
	totalPage= (total/pageRow)+1;
	}
	
%>
  <div class="wrap">
	<section class="app-content">
		<div class="row">
				<div class="col-md-12">
				<%=p %>/<%= totalPage %>
					<div class="mail-toolbar m-b-lg  pull-right">										
						<div class="btn-group" role="group">
							<a href="list.jsp?p=<%=p-1 %>" class="btn btn-default <%= (p == 1)? "disabled" : ""  %>"><i class="fa fa-chevron-left"></i></a>
						<!-- 디스에이블로 첫페이지일때 앞페이지 못넘기게 함-->
							<a href="list.jsp?p=<%=p+1 %>" class="btn btn-default <%= (p == totalPage)? "disabled" : ""  %>"><i class="fa fa-chevron-right"></i></a>
						</div>
						
						<div class="btn-group" role="group">
							<a href="write.jsp" class="btn btn-default">글쓰기</a>
						</div>
						
					</div>
				</div>
		</div>
	</section><!-- #dash-content -->
</div><!-- .wrap -->
 
			<div class="col-md-12">
				<div class="widget p-lg">
					<h4 class="m-b-lg">게시판</h4>
					<p class="m-b-lg docs">
						설명
					</p>
					<div class="table-responsive">
						<table class="table">
			<%
			boolean dataChk = false;  /* 보통 불리언 초깃값은 false */
			int rowNum = total - ((p-1)*pageRow); 
			
			Iterator<HashMap<String, String>> it =	list.iterator();
			while(it.hasNext()){
				HashMap<String, String> data =	it.next();
			%>								
							<tr>
								<td><%=rowNum-- %> <a href="view.jsp?bo_num=<%=data.get("bo_num") %>"><%=data.get("bo_title")%></a></td>
								<!-- i++나 i-- 처럼 rowNum--하면 1씩 줄어들며 글번호 나온다 -->
								<td align="right"><%=data.get("bo_inputdate")  %></td>
							</tr>						
			<%
			dataChk = true ;
			}
			
			if(!dataChk){  /* 만약 트루가 아니라면*/
			%>						
							<tr>
								<td colspan="2">등록된 글이 없습니다..</td>
							</tr>	
			<%
			}
			%>							
						</table>
					</div>
				</div><!-- .widget -->
			</div><!-- END column -->

<%@ include file="includes/footer.jsp"%>