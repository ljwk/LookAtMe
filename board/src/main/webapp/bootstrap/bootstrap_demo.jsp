<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>부트스트랩 프레임워크 테스트</title>
<script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
<script type="text/javascript">
	function menu2(){
		alert("2");
	}
	function menu3(){
		alert("3");
	}
	function menu4(){
		alert("4");
	}
	function menu5(){
		alert("5");
	}
	
</script>
</head>
<body>
	<nav class="navbar navbar-default navbar-fixed-top">
	 <div class="alert alert-info">
	    <div class="navbar-header">
	      <a class="navbar-brand" href="#">Main</a>
	    </div>
	
	    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	      <ul class="nav navbar-nav">
	        <li ><a href="/testWeb/login">Login</a></li>
	        <li onclick="menu2();"><a href="#">Menu2</a></li>
	        <li onclick="menu3();"><a href="#">Menu3</a></li>
	        <li onclick="menu4();"><a href="#">Menu4</a></li>
	        <li onclick="menu5();"><a href="#">Menu5</a></li>
	      </ul>
	    </div>
	    
	  </div>
	</nav>
</body>
</html>