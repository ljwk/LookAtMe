<%@ page contentType="text/html;charset=utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<c:set var="hello" value="Hello World!" />
<html>
<head>
<meta charset="UTF-8">
<title>index</title>
<script src="//code.jquery.com/jquery-2.1.3.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<script src="//raw.github.com/botmonster/jquery-bootpag/master/lib/jquery.bootpag.min.js"></script>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script src="<c:url value="/resources/jquery.bootpag.min.js"/>"></script>
<script type="text/javascript">
function logout(){
	if(confirm("로그아웃 하시겠습니까?")){			
		location.href="<c:url value='/logout' />";
	}
}
</script>
</head>
<body>
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="alert alert-info">
			<div class="navbar-header">
				<a class="navbar-brand" href="/board/index.jsp">Main</a>
			</div>
		
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
				<sec:authorize access="! isAuthenticated()">	      	
					<li><a href="/board/user/joinForm">Join</a></li>
					<li><a href="/board/user/login">Login</a></li>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
					<li><a href="<c:url value='/logout' />">Logout</a></li>
				</sec:authorize>		        
					<li><a href="/board/home/main">Board</a></li>
				<sec:authorize access="isAuthenticated()">
					<li><a href="<c:url value='/cctv/list' />">CCTV</a></li>
				</sec:authorize>		  					
				</ul>
			</div>	    
		</div>
	</nav>
	<br><br><br><br><br><br><br>
	<h3>인덱스 페이지!</h3>
	${hello}	
</body>
</html> 