<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 

<%
String mb_name="";

String url= "jdbc:mysql://localhost:3306/bigdata?serverTimezone=Asia/Seoul";
String user= "root";
String password= "bigdata";

StringBuffer qry= new StringBuffer();
qry.append(" select * from big_member where mb_id=? ");
String sql = qry.toString();


Connection conn = null;
PreparedStatement stmt = null; 
ResultSet rs = null;

try{
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(url, user, password);
	
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, (String)session.getAttribute("sess_id"));
	rs = stmt.executeQuery();
	
	if(rs.next()){
		mb_name = rs.getString("mb_name");
	}else {
		response.sendRedirect("login.jsp");
	}
	
} catch(Exception e){
	
	
}finally{
	try{
		if(rs!=null) rs.close();
		if(stmt!=null) stmt.close();
		if(conn!=null) conn.close();
	}catch(Exception e){
		
	}
	
}
%>






<%@ include file="includes/header.jsp"%>
<style>
.wrap {
padding-bottom : 1.5rem;
}
</style>
  <div class="wrap">
  <div class="profile-header">
	<div class="profile-cover">
		<div class="cover-user m-b-lg">
			<div>
				<span class="cover-icon"><i class="fa fa-heart-o"></i></span>
			</div>
			<div>
				<div class="avatar avatar-xl avatar-circle">
					<a href="javascript:void(0)">
						<img class="img-responsive" src="../assets/images/221.jpg" alt="avatar"/>
					</a>
				</div><!-- .avatar -->
			</div>
			<div>
				<span class="cover-icon"><i class="fa fa-envelope-o"></i></span>
			</div>
		</div>
		<div class="text-center">
			<h4 class="profile-info-name m-b-lg"><a href="javascript:void(0)" class="title-color"><%=mb_name %></a></h4>
			<div>
				<a href="javascript:void(0)" class="m-r-xl theme-color"><i class="fa fa-bolt m-r-xs"></i> Web Developer</a>
				<a href="javascript:void(0)" class="theme-color"><i class="fa fa-map-marker m-r-xs"></i>Cairo, Egypt</a>
			</div>
		</div>
	</div><!-- .profile-cover -->

	<div class="promo-footer">
		<div class="row no-gutter">
			<div class="col-sm-2 col-sm-offset-3 col-xs-6 promo-tab">
				<div class="text-center">
					<small>Experience</small>
					<h4 class="m-0 m-t-xs">+2 years</h4>
				</div>
			</div>
			<div class="col-sm-2 col-xs-6 promo-tab">
				<div class="text-center">
					<small>Hourly Rate</small>
					<h4 class="m-0 m-t-xs">12$ - 25$</h4>
				</div>
			</div>
			<div class="col-sm-2 col-xs-12 promo-tab">
				<div class="text-center">
					<small>Reviews</small>
					<div class="m-t-xs">
						<i class="text-primary fa fa-star"></i>
						<i class="text-primary fa fa-star"></i>
						<i class="text-primary fa fa-star"></i>
						<i class="text-primary fa fa-star"></i>
						<i class="text-primary fa fa-star-o"></i>
					</div>
				</div>
			</div>
		</div>
	</div><!-- .promo-footer -->
</div><!-- .profile-header -->

<!-- Likes/comments Modal -->
<div id="likesModal" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">3 people like this</h4>
			</div>
			<div class="modal-body">
				<ul class="list-group m-0">
					<li class="list-group-item">
						<div class="media">
							<div class="media-left">
								<a href="javascript:void(0)" class="avatar avatar-sm">
									<img class="img-responsive" src="../assets/images/221.jpg" alt="avatar"/>
								</a><!-- .avatar -->
							</div>
							<div class="media-body">
								<h5 class="media-heading m-0"><a href="javascript:void(0)">John Doe</a></h5>
							</div>
							<div class="media-right">
								<a href="javascript:void(0)" class="btn btn-sm btn-default"><i class="fa fa-rss m-r-xs"></i>Follow</a>
							</div>
						</div>
					</li>

					<li class="list-group-item">
						<div class="media">
							<div class="media-left">
								<a href="javascript:void(0)" class="avatar avatar-sm">
									<img class="img-responsive" src="../assets/images/104.jpg" alt="avatar"/>
								</a><!-- .avatar -->
							</div>
							<div class="media-body">
								<h5 class="media-heading m-0"><a href="javascript:void(0)">Sara Adams</a></h5>
							</div>
							<div class="media-right">
								<a href="javascript:void(0)" class="btn btn-sm btn-default"><i class="fa fa-user-plus m-r-xs"></i>Add Freind</a>
							</div>
						</div>
					</li>

					<li class="list-group-item">
						<div class="media">
							<div class="media-left">
								<a href="javascript:void(0)" class="avatar avatar-sm">
									<img class="img-responsive" src="../assets/images/101.jpg" alt="avatar"/>
								</a><!-- .avatar -->
							</div>
							<div class="media-body">
								<h5 class="media-heading m-0"><a href="javascript:void(0)">John Doe</a></h5>
							</div>
							<div class="media-right">
								<a href="javascript:void(0)" class="btn btn-sm btn-default"><i class="fa fa-user-plus m-r-xs"></i>Add Friend</a>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</div><!-- /.wrap -->
<%@ include file="includes/footer.jsp"%>