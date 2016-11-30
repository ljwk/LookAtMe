<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색결과</title>
<script src="//code.jquery.com/jquery-2.1.3.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<script src="//raw.github.com/botmonster/jquery-bootpag/master/lib/jquery.bootpag.min.js"></script>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script src="<c:url value="/resources/jquery.bootpag.min.js"/>"></script>
<script>
	$(function(){
		$('#page-selection').bootpag({
			total: Math.ceil(${list[0].totalrows}/${rpp}),  
			page: ${page},  
			maxVisible: ${rpp},  
			leaps: true,
			firstLastUse: true,
			first: '←',
			last: '→',
			wrapClass: 'pagination',
			activeClass: 'active', 
			disabledClass: 'disabled',
			nextClass: 'next',
			prevClass: 'prev',
			lastClass: 'last',
			firstClass: 'first'
		}).on("page", function(event, num){
			location.href='search?rpp=10&page='+num+'&search=${search}&searchContents=${searchContents}';
		}); 
	});	
	
	function logout(){
		if(confirm("로그아웃 하시겠습니까?")){			
			location.href="<c:url value='/logout' />";
		}
	}
</script>
<style type="text/css">
	body {text-align: center;}
	table {border: 1px solid black; border-spacing: 0px; margin: 0px auto ;}
	th, td {padding: 5px;}
	th {border: 1px solid black; border-bottom: 3px double black; text-align: center; background: rgb(176, 187, 190);}
	#jul:hover {background-color: rgb(202, 214, 255);}
	td {border: 1px solid black;}
	#content {width: 800px; margin: 0px auto;}
	#title {width: 300px; text-align: left;}
	#author { width: 150px; }
	a:hover {color: red;}
	a:active {color: gold}
	a {color: black; text-decoration: none;}
</style>
</head>
<body>
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="alert alert-info">
			<div class="navbar-header">
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
						<li><a href="javascript:logout();">Logout</a></li>
					</sec:authorize>						
				</ul>
			</div>	    
		</div>
	</nav>
	<br><br><br><br><br><br><br>
	<div id="content" class="panel panel-default">
		<div class="panel-heading">게 시 판 !</div>
		<table class="table" id="tablee">
			<tr>
				<th>글번호</th><th>제목</th><th>작성자</th>	<th>작성일</th>	<th>조회수</th>
			</tr>
			<c:forEach var="e" items="${list}">
			<tr id="jul">
				<td>${e.num}</td><td id="title"><a href="desc?num=${e.num}">${e.title}</a></td><td id="author">${e.id}</td><td>${e.regdate}</td><td>${e.hitcnt}</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	<p>
	<div id="page-selection"><!-- Pagination goes here --></div>		
	<p>
	<a href="main"><button type="button" class="btn btn-default">목 록 으 로</button></a>
</body>
</html>