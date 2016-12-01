<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
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
			getList(num);
		}); 
		getList(1);
	});
	
	function getList(num){
		var dateObj = {};
		dateObj.page=num;
		dateObj.rpp=${rpp};
		
		$.ajax({
			url : 'list' , 
			data : dateObj,
			type : 'post',
			dataType : 'html',
			success : function(res) {
				$('#content').html(res); 
			}, 
			error(xhr, status, error){
				alert(error);
			} 
		});
	}
	
	function logout(){
		if(confirm("로그아웃 하시겠습니까?")){			
			location.href="<c:url value='/logout' />";
		}
	}
</script>
<style type="text/css">
	body {text-align: center;}
	#navdiv{height:100px;}
	table {border-spacing: 0px; margin: 0px auto;}
	th, td {padding: 5px;}
	th {text-align: center; background: rgb(252, 252, 252);}
	td{color: gray;}
	#tnum{width: 45px;}
	#ttitle{width:420px;}
	#tauthor{width:80px;}
	#tdate{width:100px;}
	#tnum{width:60px;}
	#jul:hover {background-color: rgb(202, 214, 255);}
	#content {width: 800px; margin: 0px auto;margin-top:50px;}
	#title {width: 300px; text-align: left;}
	a:hover {color: red;}
	a:active {color: gold}
	a {color: gray; text-decoration: none;}
</style>
</head>
<body>
<div id="navdiv">
	<nav class="nav nav-tabs">
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
				<ul class="nav navbar-nav navbar-right">
					<sec:authorize access="!isAuthenticated()">
						<li><a>Guest님이 접속하셨습니다.</a></li>
						<li><a>글쓰기와 다운로드는 로그인이 필요합니다!</a></li>
					</sec:authorize>
					<sec:authorize access="isAuthenticated()">
						<li><a><sec:authentication property="name"/>님이 접속하셨습니다.</a></li>
					</sec:authorize>		
      			</ul>
			</div>	    
	</nav>
</div>
	<h3>게 시 판 !</h3>
	<div id="content" class="panel panel-default"><!-- Dynamic Content goes here --></div>
	<p>	
	<br>	
	<form name="updateForm" action="search">
		<input type="hidden"  id="rpp" name="rpp" value="10">
		<input type="hidden"  id="page"  name="page" value="1">
		<select name="search" style="height: 30px;">
			<option>번호</option><option>제목</option><option>작성자</option><option>내용</option>
		</select>
		<input type="text" name="searchContents" style="height: 30px;">
		<button type="submit" class="btn btn-default" onclick="search();">검색</button>
		<sec:authorize access="isAuthenticated()">
			<a href="add?id=<sec:authentication property="name"/>" ><button type="button" class="btn btn-default">글쓰기</button></a>
		</sec:authorize>
	</form>
		<div id="page-selection"><!-- Pagination goes here --></div>		
</body>
</html>