<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="includes/header.jsp"%>
		<div class="wrap">
				<div class="widget">
					<header class="widget-header">
						<h4 class="widget-title">글수정</h4>
					</header><!-- .widget-header -->
					<hr class="widget-separator">
					<div class="widget-body">
						<div class="m-b-lg">
							<small>
								<!-- 설명 -->
							</small>
						</div>
						<form method="post" class="form-horizontal" action="">
							<table class=table id="crew">
								<tr>
									<th>#</th><th>항목1</th><th>항목2</th><th></th>
								</tr>
								<tr>
									<td>1</td>
									<td><input class="form-control"></td>
									<td><input class="form-control"></td>
									<td><button id="" type="button" class="btn btn-default" onclick="addItem()">+</button>
									<button id="" type="button" class="btn btn-default"  onclick="delItem(this)">-</button></td>									
								</tr>
								
								<tr>
									<td>2</td>
									<td><input class="form-control"></td>
									<td><input class="form-control"></td>
									<td><button id="" type="button" class="btn btn-default" onclick="addItem()">+</button>
									<button id="" type="button" class="btn btn-default"  onclick="delItem(this)">-</button></td>									
								</tr>									
							</table>
						</form>
					</div><!-- .widget-body -->
				</div><!-- .widget -->
		</div><!-- END column -->
		
<script>

function delItem(t){
	let len = $('#crew tr').length;
	if(len > 2){
		$(t).parent().parent().remove();
	}	
}

function addItem(){		
	let len = $('#crew tr').length; //시작점 0 , crew 안에 있는 모든 자손 요소 tr , crew > tr 은 자식 요소만 나와 계속 0임
	console.log(len);
	let html = "";
	html += '<tr>';
	html += '<td>'+len+'</td>';
	html += '<td><input class="form-control"></td>';
	html += '<td><input class="form-control"></td>';
	html += '<td><button id="" type="button" class="btn btn-default" onclick="addItem()">+</button>';
	html += '<button id="" type="button" class="btn btn-default"  onclick="delItem(this)">-</button></td>';									
	html += '</tr>';
	
	$('#crew:last').append(html);
}


$(document).ready(function(){
	
});
</script>
		
<%@ include file="includes/footer.jsp"%>
    