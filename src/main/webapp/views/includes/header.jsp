<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String sess_id = (String)session.getAttribute("sess_id"); 
 /*로그인 실패했을때 "login.jsp"로 이동하게 한다 */
if((sess_id ==null || "".equals(sess_id))){
	response.sendRedirect("login.jsp");
}
%>    
    
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
	<meta name="description" content="Admin, Dashboard, Bootstrap" />
	<link rel="shortcut icon" sizes="196x196" href="../assets/images/logo.png">
	<title>Infinity - Bootstrap Admin Template</title>
	
	<link rel="stylesheet" href="../libs/bower/font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" href="../libs/bower/material-design-iconic-font/dist/css/material-design-iconic-font.css">
	<!-- build:css ../assets/css/app.min.css -->
	<link rel="stylesheet" href="../libs/bower/animate.css/animate.min.css">
	<link rel="stylesheet" href="../libs/bower/fullcalendar/dist/fullcalendar.min.css">
	<link rel="stylesheet" href="../libs/bower/perfect-scrollbar/css/perfect-scrollbar.css">
	<link rel="stylesheet" href="../assets/css/bootstrap.css">
	<link rel="stylesheet" href="../assets/css/core.css">
	<link rel="stylesheet" href="../assets/css/app.css">
	<link rel="stylesheet" href="../assets/css/style.css">
	
	<script src="../assets/js/default.js"></script>
	
	<!-- endbuild -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway:400,500,600,700,800,900,300">
	<script src="../libs/bower/breakpoints.js/dist/breakpoints.min.js"></script>
	<script>
		Breakpoints();
	</script>
		<script src="../libs/bower/jquery/dist/jquery.js"></script>  
</head>
	
<body class="menubar-top menubar-light theme-primary">
<!--============= start main area -->

<!-- APP NAVBAR ==========-->
<nav id="app-navbar" class="navbar navbar-inverse navbar-fixed-top primary">
  
  <!-- navbar header -->
  <div class="navbar-header">
    <button type="button" id="menubar-toggle-btn" class="navbar-toggle visible-xs-inline-block navbar-toggle-left hamburger hamburger--collapse js-hamburger">
      <span class="sr-only">Toggle navigation</span>
      <span class="hamburger-box"><span class="hamburger-inner"></span></span>
    </button>

    <button type="button" class="navbar-toggle navbar-toggle-right collapsed" data-toggle="collapse" data-target="#app-navbar-collapse" aria-expanded="false">
      <span class="sr-only">Toggle navigation</span>
      <span class="zmdi zmdi-hc-lg zmdi-more"></span>
    </button>

    <button type="button" class="navbar-toggle navbar-toggle-right collapsed" data-toggle="collapse" data-target="#navbar-search" aria-expanded="false">
      <span class="sr-only">Toggle navigation</span>
      <span class="zmdi zmdi-hc-lg zmdi-search"></span>
    </button>

    <a href="../index.jsp" class="navbar-brand">
      <span class="brand-icon"><i class="fa fa-gg"></i></span>
      <span class="brand-name">Infinity</span>
    </a>
  </div><!-- .navbar-header -->
  
  <div class="navbar-container container-fluid">
    <div class="collapse navbar-collapse" id="app-navbar-collapse">
      <ul class="nav navbar-toolbar navbar-toolbar-left navbar-left">
        <li class="hidden-float hidden-menubar-top">
          <a href="javascript:void(0)" role="button" id="menubar-fold-btn" class="hamburger hamburger--arrowalt is-active js-hamburger">
            <span class="hamburger-box"><span class="hamburger-inner"></span></span>
          </a>
        </li>
        <li>
          <h5 class="page-title hidden-menubar-top">Dashboard</h5>
        </li>
      </ul>

      <ul class="nav navbar-toolbar navbar-toolbar-right navbar-right">
        <li class="nav-item dropdown hidden-float">
          <a href="javascript:void(0)" data-toggle="collapse" data-target="#navbar-search" aria-expanded="false">
            <i class="zmdi zmdi-hc-lg zmdi-search"></i>
          </a>
        </li>

        <li class="dropdown">
          <a href="javascript:void(0)" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="zmdi zmdi-hc-lg zmdi-notifications"></i></a>
          <div class="media-group dropdown-menu animated flipInY">
            <a href="javascript:void(0)" class="media-group-item">
              <div class="media">
                <div class="media-left">
                  <div class="avatar avatar-xs avatar-circle">
                    <img src="../assets/images/221.jpg" alt="">
                    <i class="status status-online"></i>
                  </div>
                </div>
                <div class="media-body">
                  <h5 class="media-heading">John Doe</h5>
                  <small class="media-meta">Active now</small>
                </div>
              </div>
            </a><!-- .media-group-item -->

            <a href="javascript:void(0)" class="media-group-item">
              <div class="media">
                <div class="media-left">
                  <div class="avatar avatar-xs avatar-circle">
                    <img src="../assets/images/205.jpg" alt="">
                    <i class="status status-offline"></i>
                  </div>
                </div>
                <div class="media-body">
                  <h5 class="media-heading">John Doe</h5>
                  <small class="media-meta">2 hours ago</small>
                </div>
              </div>
            </a><!-- .media-group-item -->

            <a href="javascript:void(0)" class="media-group-item">
              <div class="media">
                <div class="media-left">
                  <div class="avatar avatar-xs avatar-circle">
                    <img src="../assets/images/207.jpg" alt="">
                    <i class="status status-away"></i>
                  </div>
                </div>
                <div class="media-body">
                  <h5 class="media-heading">Sara Smith</h5>
                  <small class="media-meta">idle 5 min ago</small>
                </div>
              </div>
            </a><!-- .media-group-item -->

            <a href="javascript:void(0)" class="media-group-item">
              <div class="media">
                <div class="media-left">
                  <div class="avatar avatar-xs avatar-circle">
                    <img src="../assets/images/211.jpg" alt="">
                    <i class="status status-away"></i>
                  </div>
                </div>
                <div class="media-body">
                  <h5 class="media-heading">Donia Dyab</h5>
                  <small class="media-meta">idle 5 min ago</small>
                </div>
              </div>
            </a><!-- .media-group-item -->
          </div>
        </li>

        <li class="dropdown">
          <a href="javascript:void(0)" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="zmdi zmdi-hc-lg zmdi-settings"></i></a>
          <ul class="dropdown-menu animated flipInY">
            <li><a href="javascript:void(0)"><i class="zmdi m-r-md zmdi-hc-lg zmdi-account-box"></i>My Profile</a></li>
            <li><a href="javascript:void(0)"><i class="zmdi m-r-md zmdi-hc-lg zmdi-balance-wallet"></i>Balance</a></li>
            <li><a href="javascript:void(0)"><i class="zmdi m-r-md zmdi-hc-lg zmdi-phone-msg"></i>Connection<span class="label label-primary">3</span></a></li>
            <li><a href="javascript:void(0)"><i class="zmdi m-r-md zmdi-hc-lg zmdi-info"></i>privacy</a></li>
          </ul>
        </li>
	      </ul>
    </div>
  </div><!-- navbar-container -->
</nav>
<!--========== END app navbar -->

<!-- APP ASIDE ==========-->
<aside id="menubar" class="menubar light">
  <div class="app-user">
    <div class="media">
      <div class="media-left">
        <div class="avatar avatar-md avatar-circle">
          <a href="profile.jsp"><img class="img-responsive" src="../assets/images/221.jpg" alt="avatar"/></a>
        </div><!-- .avatar -->
      </div>
      <div class="media-body">
        <div class="foldable">
          <h5><a href="javascript:void(0)" class="username">John Doe</a></h5>
          <ul>
            <li class="dropdown">
              <a href="javascript:void(0)" class="dropdown-toggle usertitle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <small>Web Developer</small>
                <span class="caret"></span>
              </a>
              <ul class="dropdown-menu animated flipInY">
                <li>
                  <a class="text-color" href="/index.jsp">
                    <span class="m-r-xs"><i class="fa fa-home"></i></span>
                    <span>Home</span>
                  </a>
                </li>
                <li>
                  <a class="text-color" href="profile.jsp">
                    <span class="m-r-xs"><i class="fa fa-user"></i></span>
                    <span>Profile</span>
                  </a>
                </li>
                <li>
                  <a class="text-color" href="settings.jsp">
                    <span class="m-r-xs"><i class="fa fa-gear"></i></span>
                    <span>Settings</span>
                  </a>
                </li>
                <li role="separator" class="divider"></li>
                <li>
                  <a class="text-color" href="logout.jsp">
                    <span class="m-r-xs"><i class="fa fa-power-off"></i></span>
                    <span>Logout</span>
                  </a>
                </li>
              </ul>
            </li>
          </ul>
        </div>
      </div><!-- .media-body -->
    </div><!-- .media -->
  </div><!-- .app-user -->

  <div class="menubar-scroll">
    <div class="menubar-scroll-inner">
      <ul class="app-menu">
      
          <li class="has-submenu">
          <a href="javascript:void(0)" class="submenu-toggle">
            <i class="menu-icon fa fa-users zmdi-hc-lg"></i>
            <span class="menu-text">회원관리</span>
            <i class="menu-caret zmdi zmdi-hc-sm zmdi-chevron-right"></i>
          </a>
          <ul class="submenu">
            <li><a href="memberList.jsp"><span class="menu-text">회원관리</span></a></li>
            <li><a href="memberOutList.jsp"><span class="menu-text">탈퇴회원</span></a></li>
          </ul>
        </li>
      
        <li class="has-submenu">
          <a href="javascript:void(0)" class="submenu-toggle">
            <i class="menu-icon fa fa-archive  zmdi-hc-lg"></i>
            <span class="menu-text">게시판관리</span>
            <i class="menu-caret zmdi zmdi-hc-sm zmdi-chevron-right"></i>
          </a>
          <ul class="submenu">
            <li><a href="list.jsp"><span class="menu-text">게시판</span></a></li>
            <li><a href="gallery.jsp"><span class="menu-text">갤러리</span></a></li>
          </ul>
        </li>

      </ul><!-- .app-menu -->
    </div><!-- .menubar-scroll-inner -->
  </div><!-- .menubar-scroll -->
</aside>
<!--========== END app aside -->

<!-- navbar search -->
<div id="navbar-search" class="navbar-search collapse">
  <div class="navbar-search-inner">
    <form action="#">
      <span class="search-icon"><i class="fa fa-search"></i></span>
      <input class="search-field" type="search" placeholder="search..."/>
    </form>
    <button type="button" class="search-close" data-toggle="collapse" data-target="#navbar-search" aria-expanded="false">
      <i class="fa fa-close"></i>
    </button>
  </div>
  <div class="navbar-search-backdrop" data-toggle="collapse" data-target="#navbar-search" aria-expanded="false"></div>
</div><!-- .navbar-search -->

<!-- APP MAIN ==========-->
<main id="app-main" class="app-main">