<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"><title>투두앱</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<style>
.container{
margin: 50px auto;
padding: 50px;
background-color: #ccc;
border-radius: 10px;
}
input[type=text]{
width: 70%;
display: inline;
}
.form-group{
text-align: center;
}
ul > li > span{
float : right;
}
</style>
</head>
<body>

 
	<div class="container">
	<h2>to do app</h2>
	<hr>
	<div class="form-group">
	<input id="item" type="text" class="form-control" placeholder="할일을 입력하세요">
	<button type="button" class="btn btn-primary" onclick="addItem()">할일 추가</button> 
	</div>
	<hr>
	<ul id="todolist" class="list-group"></ul> 
	</div>

<script>
function addItem(){
	let todo = $("#item").val(); /* 입력값을 읽어와 todo 변수에 저장  */
	let list = document.getElementById("todolist"); /* ul 요소를 참조하여 list 변수에 저장하라 */
	let listitem = document.createElement("li"); /* 새로운 li 요소를 생성하여 listitem 변수에 저장  */
	listitem.className = "list-group-item"; /* 새로운 목록에 부트스트랩 클래스 디자인 추가로 지정 */
	listitem.innerHTML = todo + '<span id="item0" class="glyphicon glyphicon-remove" onclick="removeli(this)"></span>'; 
	/* 이너html을 이용하여 입력된값(todo)를 새롭게 만들어짐 li 태그 바디에 추가하라 */
	list.append(listitem); /* 이제 li의 상위 요소인 ul 즉 리스트에 새로운 li노드를 추가해주면 화면에 추가한 목록이 보인다.  */
}
function removeli(t){
	/* 할일 추가한거 지우기 가능 */
	console.log("삭제 버튼 눌림");
	//$(t).empty();
	$(t).parent().empty()
	} 
</script>	
</body>
</html>	



