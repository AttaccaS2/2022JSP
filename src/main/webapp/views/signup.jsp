<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="includes/loginHeader.jsp"%>

<div class="simple-page-form animated flipInY" id="login-form">
	<h4 class="form-title m-b-xl text-center">Sign Up For a new Account</h4>
	<form method="post" action="signupAct.jsp">
	
		<div class="form-group">
			<input id="mb_id" type="text" name="mb_id" class="form-control" placeholder="아이디">
			<p id="idErrMsg"></p>
		</div>
		
		<div class="form-group">
			<input id="mb_pw" type="password" name="mb_pw" class="form-control" placeholder="비밀번호">
			<p id="pwErrMsg"></p>
		</div>
				
		<div class="form-group">
			<input id="mb_name" type="text" name="mb_name" class="form-control" placeholder="이름">
			<p id="nameErrMsg"></p>	
		</div>

		<div class="form-group">
			<input id="mb_email" type="email" name="mb_email" class="form-control" placeholder="이메일">
		</div>
		
		<div class="form-group">
			<input id="mb_zipcode" type="text" name="mb_zipcode" class="form-control" placeholder="우편번호">
					<button type="button"  onclick="sample3_execDaumPostcode()">우편번호 검색</button>
		</div>
		
		<div class="form-group">
			<input id="mb_addr" type="text" name="mb_addr" class="form-control" placeholder="주소">
		</div>
		
		<div class="form-group">
			<input id="mb_detailAddr" type="text" name="mb_detailAddr" class="form-control" placeholder="상세주소">
		</div>
		
		<div id="wrap" style="display:none;border:1px solid;width:100%;height:300px;margin:5px 0;position:relative">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
		</div>
				
		<div class="form-group">
			<input id="mb_phone" type="tel" name="mb_phone" class="form-control" placeholder="연락처">
		</div>
		
		<div class="form-group">
			<input id="mb_birth" type="number" name="mb_birth" class="form-control" placeholder="생년월일">
		</div>
		
		<div class="form-group">
			<input id="mb_genderM" type="radio" name="mb_gender" value="M"  placeholder="남">M
			<input id="mb_genderF" type="radio" name="mb_gender" value="F" placeholder="여">F
		</div>
	
		<input type="submit" class="btn btn-primary" value="회원가입">	
	</form>
</div><!-- #login-form -->

<div class="simple-page-footer">
	<p>
		<small>Do you have an account ?</small>
		<a href="login.jsp">로그인</a>
	</p>
</div><!-- .simple-page-footer -->

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 찾기 화면을 넣을 element
    var element_wrap = document.getElementById('wrap');

    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }

    function sample3_execDaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다.
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    //document.getElementById("sample3_extraAddress").value = extraAddr;
                
                } else {
                    //document.getElementById("sample3_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('mb_zipcode').value = data.zonecode;
                document.getElementById("mb_addr").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("mb_detailAddr").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';

                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize : function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).embed(element_wrap);

        // iframe을 넣은 element를 보이게 한다.
        element_wrap.style.display = 'block';
    }
</script>

<script>

var pwValidate = -1;  /* 전역변수 선언 */ 

	$(document).ready(function(){
			//아이디를 빈칸, 잘못된 글자수를 입력했을때 회원가입 버튼을 누르지 않고도 메세지 출력
		$('#mb_id').on("blur",function(){
			let mb_id = $('#mb_id').val().trim();
			if(mb_id == ''){
				$('#idErrMsg').text('아이디를 6~16글자 입력하세요'); /* .html은 태그까지 다나옴 */
				$('#idErrMsg').css('color','red');
				$('#mb_id').focus();
			} else if(mb_id.length < 6 || mb_id.length > 16){
				$('#idErrMsg').text('아이디를 6~16글자 입력하세요'); 
				$('#idErrMsg').css('color','red');
				$('#mb_id').focus();
			} else{
				$('#idErrMsg').text(''); 
				$('#idErrMsg').css('color','');				
			//아작스를 이용한 아이디 중복체크
			//else조건 안에 있기때문에 성공시 나오는 메세지다.
			    $.ajax({
			        type : "POST",            // HTTP method type(GET, POST) 형식이다.
			        url : "../ajax/ajax.idchkAct.jsp",      // 컨트롤러에서 대기중인 URL 주소이다.
			        data : {mb_id:mb_id},         // Json 형식의 데이터이다. 변수명 : 변수값 겟방식으로 표현하면?1=2
			        success : function(res){ // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
			            // 응답코드 > 0000
			           if(res=='Success'){
			        	   $('#idErrMsg').text('사용가능한 아이디');
			        	   $('#idErrMsg').css('color','green');
			           }else{ 
			        	   $('#idErrMsg').text('중복된 아이디');
			        	   $('#idErrMsg').css('color','red');
			        	   $('#mb_id').focus();
			           }
			        },
			        error : function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
			        	console.log("통신 실패.")
			        }
			    });
			}
		});
			//비밀번호 빈칸, 잘못된 글자수로 입력했을때 메세지 나오기  
		$('#mb_pw').on("keyup",function(){
			let mb_pw = $('#mb_pw').val().trim();
			let reg = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,16}$/;
		//	console.log(pwValidate);
			pwValidate = -1;
			
			if(mb_pw == ''){
				$('#pwErrMsg').text('비밀번호를 6~16글자 입력하세요'); /* .html은 태그까지 다나옴 */
				$('#pwErrMsg').css('color','red');
				return;
			} else if(mb_pw.length < 6 || mb_pw.length > 16){
				$('#pwErrMsg').text('비밀번호를 6~16글자 입력하세요'); 
				$('#pwErrMsg').css('color','red');
		//특수문자 포함시키기		
			} else if(!reg.test(mb_pw)  ){
				$('#pwErrMsg').text('영문자, 숫자, 특수문자 각 1개 이상 입력하세요'); 
				$('#pwErrMsg').css('color','red');
			} else {
				$('#pwErrMsg').text('');
				pwValidate = 0; //이조건들에 안걸렸을때 그러니까 제대로 입력했을때				
			}	
			
		}); //$('#mb_pw').on("keyup",function() 끝
								
				//버튼 클릭 이벤트 발생시 일어나는 일
			$('input[type=submit]').on("click", function(e){
				e.preventDefault();			
				console.log(pwValidate);
				let mb_id = $('#mb_id').val().trim();
				let mb_pw = $('#mb_pw').val().trim();
				let mb_name = $('#mb_name').val().trim();
				let mb_email = $('#mb_email').val().trim();
				let mb_zipcode = $('#mb_zipcode').val().trim();
				let mb_addr = $('#mb_addr').val().trim();
				let mb_detailAddr = $('#mb_detailAddr').val().trim();
				let mb_phone = $('#mb_phone').val().trim();
				let mb_birth = $('#mb_birth').val().trim();
				let mb_gender = $('input[name=mb_gender]:checked').val(); //라디오는 아이디로 못한다
				
				if(mb_id==''){
					$('#idErrMsg').text("아이디를 6~16글자 입력하세요");
					$('#idErrMsg').css('color','red');
					$('#mb_id').focus(); //커서가 아이디 자리에 고정
				} else if(pwValidate != 0 || mb_pw == '' ){
					$('#pwErrMsg').text("비밀번호를 6~16글자 입력하세요");
					$('#pwErrMsg').css('color','red');
					$('#mb_pw').focus(); 
					$('#mb_pw').select(); //글자 선택됨
				} else if(mb_name==''){
					/* 클릭 이벤트 발생시 이름 값이 빈칸이면 아래 메세지 출력됨 */
					$('#nameErrMsg').text("이름을 입력하세요");
					$('#nameErrMsg').css('color','red');
					$('#mb_name').focus(); 
				} else{
					//위 조건을 다 만족하지 않는다면 회원가입 단추를 클릭할수 없게 한다.
				//	$(this).hide();  // 이거랑 같음 $('input[type=submit]').hide();
				//	$(this).addClass("disabled"); //css에 있는 클래스를 추가하겠다
				//	$(this).attr("disabled","disabled"); // html로 disabled 속성 준다	
					$(this).prop("disabled",true); //자바스크립트로 disabled 속성 준다	
					
				// 값전송 ajax DB에 값전송해서 성공시 로그인 할수있게한다.	
				    $.ajax({
				        type : "POST",            // HTTP method type(GET, POST) 형식이다.
				        url : "../ajax/ajax.signupAct.jsp",      // 컨트롤러에서 대기중인 URL 주소이다.
				        data : {mb_id:mb_id,
				        	mb_pw:mb_pw,
				        	mb_name:mb_name,
				        	mb_email:mb_email,
				        	mb_zipcode:mb_zipcode,
				        	mb_addr:mb_addr,
				        	mb_detailAddr:mb_detailAddr,
				        	mb_phone:mb_phone,
				        	mb_birth:mb_birth,
				        	mb_gender:mb_gender},         // Json 형식의 데이터이다. 변수명 : 변수값  모든 데이터를 다 가져올때는 아래 사진처럼						    	
				        success : function(res){ // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
				            // 응답코드 > 0000
				            console.log("["+res+"]") //이게 sussess가 나와야 제대로 통신됨
				           if(res=='Success'){
				        	   location.href="login.jsp";
				        	}else{ 
					        	$(this).prop("disabled",false);
					        	alert("회원가입 실패");	           	
					        }
				       	 },
				        error : function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
				        	console.log("통신 실패.")
				        }
				    });
				}
			});
			
	}); //$(document).ready(function() 끝
</script>
<%@ include file="includes/loginFooter.jsp"%>
