<%@ page contentType="text/html;charset=utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<html>
<head>
<meta charset="UTF-8">
<title>index</title>
<script src="//code.jquery.com/jquery-2.1.3.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<script src="//raw.github.com/botmonster/jquery-bootpag/master/lib/jquery.bootpag.min.js"></script>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script src="<c:url value="/resources/jquery.bootpag.min.js"/>"></script>

<!--bxslider-->
<!-- jQuery library (served from Google) -->
<script src="<c:url value="/resources/js/jquery.bxslider.js"/>"></script>
<!-- bxSlider Javascript file -->
<script src="<c:url value="/resources/js/jquery.bxslider.min.js"/>"></script>
<!-- bxSlider CSS file -->
<link href="<c:url value="/resources/js/jquery.bxslider.css"/>" rel="stylesheet" />
<!--bxslider end-->

<script type="text/javascript">
function logout(){
	if(confirm("로그아웃 하시겠습니까?")){			
		location.href="<c:url value='/logout' />";
	}
}
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
</script>
<style type="text/css">

#navdiv{
height:100px;
}
#sliderimg{
border-spacing: 0px; 
margin-left: 410px;
width: 1100px;
}
.bxslider > li > img{
height:400px;
width:1350px;
}
.bxslider > li{
height:400px;
width: 500px;
}
#imgs{
margin-left:370px;
width: 1400px;
height: 300px;
}
#imgs > img{
float:left;
margin-left: 35px;
width:250px;
height:250px;
}
a:hover {color: red;}
a:active {color: gold}
a {color: gray; text-decoration: none;}
.no{
	position: relative;
    display: block;
    padding: 12px 15px;
}
#main{margin-left: 380px;}
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
	<div id="imgs">
		 <img src="resources/js/images/appphone.png">
		 <img src="resources/js/images/babysafe.png">
		 <img src="resources/js/images/dogsafe.png">
		 <img src="resources/js/images/firesafe.png">
	</div>
	<div id="footer">
	</div>
</body>
</html> 