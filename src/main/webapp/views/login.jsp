<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 
String sess_id = (String)session.getAttribute("sess_id"); 
 /*로그인 했을때 "dashboard.jsp"로 이동하게 한다 */
if(!(sess_id ==null || "".equals(sess_id))){
	response.sendRedirect("dashboard.jsp");
}
%>
	
<%@ include file="includes/loginHeader.jsp"%>

<div class="simple-page-form animated flipInY" id="login-form">
	<h4 class="form-title m-b-xl text-center">Sign In With Your Infinity Account</h4>
	<form method="post" action="loginAct.jsp">
		<div class="form-group">
			<input id="mb_id" type="text" name="mb_id" class="form-control" placeholder="아이디">
		</div>

		<div class="form-group">
			<input id="mb_pw" type="password" name="mb_pw" class="form-control" placeholder="비밀번호">
		</div>

		<div class="form-group m-b-xl">
			<div class="checkbox checkbox-primary">
				<input type="checkbox" id="keep_me_logged_in" /> <label
					for="keep_me_logged_in">Keep me signed in</label>
			</div>
		</div>
		<input type="submit" class="btn btn-primary" value="SING IN">
	</form>
</div>
<!-- #login-form -->


    <div class="simple-page-footer">
	<p><a href="password-forget.jsp">FORGOT YOUR PASSWORD ?</a></p>
	<p>
		<small>Don't have an account ?</small>
		<a href="signup.jsp">CREATE AN ACCOUNT</a>
	</p>
</div><!-- .simple-page-footer -->

<script>
$(document).ready(function(){
	$("input[type=submit]").on("click",function(){	
	//	e.preventDefault(); 	/* a태그, 폼 이벤트를 없애는 매소드임 void(0)처럼 */
		console.log("클릭");
		let mb_id = $('#mb_id').val().trim(); 
		let mb_pw = $('#mb_pw').val().trim(); 
		
		if(mb_id==''){
			alert('아이디 6~16글자 입력하셔야합나디');
			
		} else if(mb_id.length < 6 || mb_id.length > 16){
			alert('아이디 6~16글자 입력하셔야합나디');
			$('#mb_id').css("color","red");  //조건에서 어긋나면 빨간색으로 나와요
		} else if(mb_pw==''){
			alert('비밀번호 6~16글자 입력하셔야합나디');
		} else if(mb_pw.length < 6 || mb_pw.length > 16){
			alert('비밀번호 6~16글자 입력하셔야합나디');
		} else{
			   // ajax 통신
	        $.ajax({
	            type : "POST",            // HTTP method type(GET, POST) 형식이다.
	            url : "../ajax/ajax.loginAct.jsp",      // 컨트롤러에서 대기중인 URL 주소이다.
	            data : {mb_id:mb_id,
	            	mb_pw:mb_pw},            // Json 형식의 데이터이다. 변수명 : 변수값
	            success : function(res){ // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
	                // 응답코드 > 0000
	               if(res=='Success'){
	            	   location.href="dashboard.jsp"
	               }
	            },
	            error : function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
	            	console.log("통신 실패.")
	            }
	        });
			
		}
		console.log(mb_id);
	});
});
</script>

<%@ include file="includes/loginFooter.jsp"%>