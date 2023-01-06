<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>    
    
<%  
String keyword = request.getParameter("keyword");

String url= "jdbc:mysql://localhost:3306/bigdata?serverTimezone=Asia/Seoul";
String user= "root";
String password= "bigdata";    


StringBuffer qry= new StringBuffer();
qry.append(" SELECT * FROM big_member WHERE mb_out='Y' ");
if(keyword  !=null || "".equals(keyword)){
	qry.append(" AND ( mb_name LIKE ? OR mb_email LIKE ? OR mb_phone LIKE ? OR mb_birth LIKE ? ) ");
}
qry.append("order by mb_joindate desc");
String sql = qry.toString();

Connection conn = null;
PreparedStatement stmt = null; 
ResultSet rs = null;
    
List<HashMap<String, String>> list=new ArrayList<>();
//<String, String>안넣어주면 노란 경고창

try{
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(url, user, password);
	stmt = conn.prepareStatement(sql);
	
	
	if(keyword  !=null || "".equals(keyword)){
		stmt.setString(1, "%"+keyword+"%");
		stmt.setString(2, "%"+keyword+"%");
		stmt.setString(3, "%"+keyword+"%");
		stmt.setString(4, "%"+keyword+"%");
	}
	
	
	rs = stmt.executeQuery();
	while(rs.next()){
		HashMap<String, String> hm = new HashMap<String, String>();
		hm.put("mb_id", rs.getString("mb_id"));
		hm.put("mb_name", rs.getString("mb_name"));
		hm.put("mb_email", rs.getString("mb_email"));
		hm.put("mb_phone", rs.getString("mb_phone"));
		hm.put("mb_birth", rs.getString("mb_birth"));
		hm.put("mb_gender", rs.getString("mb_gender"));
		hm.put("mb_joindate", rs.getString("mb_joindate"));
		
		list.add(hm);
	}

} catch(Exception e){
		
}finally {
	/* try{
		if(rs!=null) rs.close();
		if(stmt!=null) stmt.close();
		if(conn!=null) conn.close();
	}catch(Exception e){
		
	}  이렇게 하면 종료되어 아무것도 안나오고 while 반복문을 배열에 저장해서 해야한다*/
}    
    
%>      
    
<%@ include file="includes/header.jsp"%>
  <div class="wrap">
	<section class="app-content">
		<div class="row">		
			<div class="col-md-12">
				<div class="widget p-lg">
					<h4 class="m-b-lg">탈퇴회원관리</h4>
					<p class="m-b-lg docs">
						탈퇴된 회원 목록입니다. 1년간 로그인이 없을시 틸퇴회원 또는 휴먼계정으로 변환하셔야합니다.
					</p>
					<form>
						<div style="text-align: right; margin-botton:1rem">
						<input type="text" name="keyword"><button>검색</button>
						</div>
					</form>
					<div class="table-responsive">
						<table class="table">
							<tr>
								<th>#순번</th>
								<th>아이디</th>
								<th>회원이름</th>
								<th>이메일</th>
								<th>연락처</th>
								<th>생년월일</th>
								<th>성별</th>
								<th>가입일자</th>
								<th>관리</th>
							</tr>
							
<%
int num = 1;

Iterator<HashMap<String, String>> it = list.iterator();
while(it.hasNext()){
	HashMap<String, String> data = it.next();
%>														
							<tr>
								<td><%=num++%></td>
								<td><%=data.get("mb_id") %></td>
							 	<td><%=data.get("mb_name") %></td>
								<td><%=data.get("mb_email") %></td>
								<td><%=data.get("mb_phone") %></td>
								<td><%=data.get("mb_birth") %></td>
								<td><%=data.get("mb_gender") %></td>
								<td><%=data.get("mb_joindate") %></td>
								<td><button data-mb_id="<%=data.get("mb_id") %>" class="btn">복구</button></td>						
							</tr>							
<%
}

if(num == 1){	
%>
							<tr>
								<td colspan="9">탈퇴된 회원이 없습니다.</td>															
							</tr>	
<%
} 
%>	
													
					
						</table>
					</div>
				</div><!-- .widget -->
			</div><!-- END column -->
		
	
		</div><!-- .row -->
	</section><!-- #dash-content -->
</div><!-- .wrap -->
<script>
$(document).ready(function(){
	$('.btn').on("click",function(){
		let mb_id=$(this).data('mb_id');
		let superEle = $(this).parent().parent(); //tr
		
		if(confirm('정말 복구?')){
			   // ajax 통신
	        $.ajax({
	            type : "POST",            // HTTP method type(GET, POST) 형식이다.
	            url : "../ajax/ajax.memberOutAct.jsp",      // 컨트롤러에서 대기중인 URL 주소이다.
	            data : {mb_id:mb_id},            // Json 형식의 데이터이다. 변수명 : 변수값
	            success : function(res){ // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
	                // 응답코드 > 0000
	               if(res='Success'){
	            		 //  location.reload();
		            	superEle.remove(); 
		           }
	            },
	            error : function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
	            	console.log("통신 실패.")
	            }
	        });				
		}
		//console.log("[button클릭]" +mb_id);
	})
});
</script>
 <%@ include file="includes/footer.jsp"%>