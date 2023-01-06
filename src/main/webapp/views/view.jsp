<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>    
    
<%
String url= "jdbc:mysql://localhost:3306/bigdata?serverTimezone=Asia/Seoul";
String user= "root";
String password= "bigdata";

StringBuffer qry= new StringBuffer();
qry.append( " SELECT * FROM big_board WHERE bo_num=?   " );
String sql = qry.toString();

Connection conn = null;
PreparedStatement stmt = null; 
ResultSet rs = null;

HashMap<String,String> view = new HashMap<>();
/* 담을 그릇 만들고 */

try{
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(url, user, password);
	
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, Integer.parseInt(request.getParameter("bo_num"))); 
	/* ? 자리에 숫자가 들어가기에 setString 아니고 setINt/ 리턴값이 스트링이라 Integer.parseInt 매소드로 int로 래핑 */
	rs = stmt.executeQuery();
	if(rs.next()){
		view.put("bo_num",rs.getString("bo_num")); /* 담기 , 어차피 가져올때는 무조건 스트링 문자열이라 여기서 int 바꿀 필요없다 */
		view.put("bo_category",rs.getString("bo_category"));
		view.put("bo_title",rs.getString("bo_title"));
		view.put("bo_content",rs.getString("bo_content"));
		view.put("bo_mb_id",rs.getString("bo_mb_id"));
		view.put("bo_mb_name",rs.getString("bo_mb_name"));
		view.put("bo_inputdate",rs.getString("bo_inputdate"));
		view.put("bo_ip",rs.getString("bo_ip"));	
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

//댓글

sql =" SELECT * FROM big_comment WHERE com_refnum = ? ORDER BY com_num ASC";
List<HashMap<String,String> > list= new ArrayList<>();

try{
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(url, user, password);
	
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, Integer.parseInt(request.getParameter("bo_num"))); 
	rs = stmt.executeQuery();
	
	while(rs.next()){
		HashMap<String,String> comment = new HashMap<>();
		comment.put("com_num",rs.getString("com_num")); /* 담기 , 어차피 가져올때는 무조건 스트링 문자열이라 여기서 int 바꿀 필요없다 */
		comment.put("com_content",rs.getString("com_content"));
		comment.put("com_mb_id",rs.getString("com_mb_id"));
		comment.put("com_mb_name",rs.getString("com_mb_name"));
		comment.put("com_inputdate",rs.getString("com_inputdate"));
		list.add(comment);
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

			<div class="wrap">
				<div class="widget">
					<header class="widget-header">
						<h4 class="widget-title">글내용보기</h4>
					</header><!-- .widget-header -->
					<hr class="widget-separator">
					<div class="widget-body">
						<div class="m-b-lg">
							<small>
								<!-- 설명 -->
							</small>
						</div>
						<form method="post" class="form-horizontal" action="list.jsp">
				
							<div class="form-group">
								<label for="exampleTextInput1" class="col-sm-3 control-label">제목:</label>
								<div class="col-sm-9">
			<%=view.get("bo_title") %>
								</div>
							</div>
							<div class="form-group">
								<label for="exampleTextInput1" class="col-sm-3 control-label">작성자:</label>
								<div class="col-sm-9">
			<%=view.get("bo_mb_name") %>
								</div>
							</div>						

							<div class="form-group">
								<label for="textarea1" class="col-sm-3 control-label">내용:</label>
								<div class="col-sm-9">
			<%=view.get("bo_content").replace("\r\n","<br>") %>			
								</div>
							</div>											
							<div class="form-group">
								<label for="exampleTextInput1" class="col-sm-3 control-label">작성일:</label>
								<div class="col-sm-9">
			<%=view.get("bo_inputdate") %>
								</div>
							</div>
		
						<div class="row">
							<div class="col-sm-7">
							</div>
							<div class="col-sm-5">
							
							<%
							if(sess_id.equals(view.get("bo_mb_id"))){
							%>
							
								<a href="modify.jsp?bo_num=<%=view.get("bo_num") %>" class="btn btn-success">글수정</a>
								<a href="javascript:void(0);" class="btn btn-success" onclick="del()">글삭제</a>								
							<%
							}
							%>	
								<a href="list.jsp" class="btn btn-success">글목록</a>
							</div>
						</div>
						</form>
						<!--댓글시작  -->
				
						<div>					
						<h4 class="widget-title">댓글</h4>						
						<form method="post" action="commentAct.jsp">
						<input type="hidden" id="com_refnum" name="com_refnum" value="<%=view.get("bo_num") %>">
							<div class="form-group">
								<input type="text" id="com_content" name="com_content" class="form-control" required="required">
								<div style="text-align:right;">
								<button id="btn_comment" class="btn btn-default">입력</button>
								</div>
							</div>	
						</form>
					</div>
					
					<!-- 댓글목록 -->
				<div id="commentList">	
<%
int rownum = 0;
Iterator<HashMap<String, String>> it = list.iterator();
while(it.hasNext()){
	HashMap<String, String> data = it.next();
%>				
					<div>
						<div><%=data.get("com_mb_name") %> <%=data.get("com_inputdate") %></div>
						<div><%=data.get("com_content") %></div>
					</div>
					<hr>
<%
rownum++;
}

if(rownum == 0){
%>														
					<div>
						<div>등록된 댓글이 없습니다.</div>
					</div>
<%
}
%>					
				</div>	
					<!-- 댓글목록 끝 -->
						<!-- 댓글 끝 -->
					</div><!-- .widget-body -->
				</div><!-- .widget -->
			</div><!-- END column -->
			
<form id="sendfrm" method="post" action="deleteAct.jsp">
<input type="hidden" name="bo_num" value="<%=view.get("bo_num") %>">
</form>


<script>
function del(){
	if(confirm("정말 삭제?")){
	document.getElementById('sendfrm').submit();
	}	
}

$(document).ready(function(){
	$("#btn_comment").on("click", function(e){
		e.preventDefault();
		let com_refnum=<%=view.get("bo_num") %>;
		let com_content=$('#com_content').val();
		
		console.log("입력"+com_content);
		
		
		// 값전송 ajax	
	    $.ajax({
	        type : "POST",            // HTTP method type(GET, POST) 형식이다.
	        url : "../ajax/ajax.commentAct.jsp",      // 컨트롤러에서 대기중인 URL 주소이다.
	        data : {com_refnum:com_refnum,
	        	com_content:com_content},         // Json 형식의 데이터이다. 변수명 : 변수값				    	
	        success : function(res){ // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
	            // 응답코드 > 0000
	  
	            
	            let jsonData = JSON.parse(res);
	            console.log("["+jsonData.sql+"]") 
	      // 	$("#commentList:last").append(res);
	            if(jsonData.res =='Success'){
	        	  location.reload();
	        	}else{ 
	        		alert("등록실패");
	        	} 
	       	 },
	        error : function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
	        	console.log("통신 실패.")
	        }
	    });

		
	});
});
</script>

<%@ include file="includes/footer.jsp"%>
