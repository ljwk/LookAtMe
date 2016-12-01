<%@ page contentType="text/html;charset=utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<c:set var="hello" value="Hello World!" />
<html>
<head>
<meta charset="UTF-8">
<title>index</title>

<script src="//code.jquery.com/jquery-2.1.3.min.js"></script>

<!-- jQuery library (served from Google) -->
<script src="<c:url value="/resources/js/jquery.bxslider.js"/>"></script>
<!-- bxSlider Javascript file -->
<script src="<c:url value="/resources/js/jquery.bxslider.min.js"/>"></script>
<!-- bxSlider CSS file -->
<link href="<c:url value="/resources/js/jquery.bxslider.css"/>" rel="stylesheet" />

<script type="text/javascript">
	$(document).ready(function(){
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
#div1{width: 500px;}
</style>
</head>
<body>
<div id="div1">
	<ul class="bxslider">
	    <li><img src="http://malsup.github.io/images/p1.jpg"></li>
	    <li><img src="http://malsup.github.io/images/p2.jpg"></li>
	    <li><img src="http://malsup.github.io/images/p3.jpg"></li>
	   <li><img src="http://malsup.github.io/images/p4.jpg"></li>
	</ul>
	</div>
</body>
</html>