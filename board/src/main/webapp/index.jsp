<%@page import="org.springframework.security.core.Authentication"%>
<%@page import="org.springframework.security.web.authentication.WebAuthenticationDetails"%>
<%@ page contentType="text/html;charset=utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<html>
<head>
<meta charset="UTF-8">
<title>index</title>
<script src="//code.jquery.com/jquery-2.1.3.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script src="<c:url value="/resources/jquery.bootpag.min.js"/>"></script>

<link href="<c:url value="/resources/ihover/ihover.css"/>" rel="stylesheet">

<!--bxslider-->
<!-- jQuery library (served from Google) -->
<script src="<c:url value="/resources/js/jquery.bxslider.js"/>"></script>
<!-- bxSlider Javascript file -->
<script src="<c:url value="/resources/js/jquery.bxslider.min.js"/>"></script>
<!-- bxSlider CSS file -->
<link href="<c:url value="/resources/js/jquery.bxslider.css"/>" rel="stylesheet" />
<!--bxslider end-->
<script type="text/javascript">
	$(function(){
		$("#footer").load("resources/footer.jsp");
		$('.bxslider').bxSlider({
			  mode:'horizontal', //default : 'horizontal', options: 'horizontal', 'vertical', 'fade'
			  speed:1000, //default:500 이미지변환 속도
			  auto: true, //default:false 자동 시작
			  captions: true, // 이미지의 title 속성이 노출된다.
			  autoControls: true, //default:false 정지,시작 콘트롤 노출, css 수정이 필요
			});
	});
	
	function logout(){	
		if(confirm("로그아웃 하시겠습니까?")){			
			var dateObj = {};
			
			$.ajax({  
				url : 'user/session' , 
				data : dateObj,
				type : 'post', 
				dataType : 'json', 
				success : function(res) {
					 
				}, 
				error(xhr, status, error){
					alert(error);
				}
			});  
			location.href="<c:url value='/logout' />";
		}
	}
</script>
<style type="text/css">
#navdiv {height:100px;}
#sliderimg {border-spacing: 0px; margin-left: 410px; width: 1100px;}
.bxslider > li > img {height:400px; width:1350px;}
.bxslider > li {height:400px; width: 500px;}
#allsubimage{margin-left:370px;width:1150px; height: 300px;}
#subimg{float:left;width:250px; height:250px;}
#subimg1{float:left;width:250px; height:250px;margin-left:35px;}
a:hover {color: red;}
a:active {color: gold}
a {color: gray; text-decoration: none;}
.no {position: relative; display: block; padding: 12px 15px;}
#main {margin-left: 380px;}

#footer > ul {text-align: center;}
</style>
</head>
<body>
	<div id="navdiv">
	 	<nav class="nav nav-tabs">
			<div class="navbar-header" id="main">
				<a class="navbar-brand" href="/board/index.jsp">Main</a>
			</div>
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<sec:authorize access="isAuthenticated()">
						<li><a href="<c:url value='/cctv/list' />">CCTV</a></li>
					</sec:authorize>		  					 
	  				<li><a href="/board/notice/main">Notice</a></li>
					<li><a href="/board/free/main">Board</a></li>
					<sec:authorize access="! isAuthenticated()">	      	
						<li><a href="/board/user/joinForm">Join</a></li>
						<li><a href="/board/user/login">Login</a></li>
					</sec:authorize>
					<sec:authorize access="isAuthenticated()">				
						<li><a href="/board/user/info?id=<sec:authentication property="name"/>">My Page</a></li>
						<li><a href="javascript:logout();">Logout</a></li>
					</sec:authorize>									
				</ul>		
			</div> 
		</nav>
	</div>
	<div id="sliderimg">
 	<ul class="bxslider">
	 	<li><img src="resources/js/images/main1.jpg"></li>
	    <li><img src="resources/js/images/main2.jpg"></li>
	    <li><img src="resources/js/images/main3.jpg"></li>
	</ul>
	</div>
		<div id="allsubimage">
			<!-- normal -->
			<div id="subimg1" class="ih-item square effect3 bottom_to_top">
				<img src="resources/js/images/appphone.png" alt="img">
			</div>
			<!-- end normal -->
			<!-- normal -->
			<div id="subimg1" class="ih-item square effect13 top_to_bottom">
				<a href="#">
					<div class="img">
						<img src="resources/js/images/babysafe.jpg" alt="img">
					</div>
					<div class="info">
						<h3>Look Out과 함께라면</h3>
						<p>사랑하는 자녀를 항상 확인할 수 있습니다</p>
					</div>
				</a>
			</div>
			<!-- end normal -->

			<!-- normal -->
			<div id="subimg1" class="ih-item square effect13 top_to_bottom">
				<a href="#">
					<div class="img">
						<img src="resources/js/images/dogsafe.jpg" alt="img">
					</div>
					<div class="info">
						<h3>Look Out과 함께라면</h3>
						<p>사랑하는 애완동물을 언제나 볼 수 있습니다</p>
					</div>
				</a>
			</div>
			<!-- end normal -->
			<!-- normal -->
			<div id="subimg1" class="ih-item square effect13 top_to_bottom">
				<a href="#">
					<div class="img">
						<img src="resources/js/images/firesafe.jpg" alt="img">
					</div>
					<div class="info">
						<h3>Look Out과 함께라면</h3>
						<p>화재를 예방할 수 있습니다</p>
					</div>
				</a>
			</div>
		</div>
	<!-- end normal -->
	<div id="footarea">
		<div id="footer"></div>
	</div>
</body>
</html> 