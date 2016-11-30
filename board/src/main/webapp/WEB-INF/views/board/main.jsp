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
				<sec:authorize access="! isAuthenticated()">	      	
					<li><a href="/board/user/joinForm">Join</a></li>
					<li><a href="/board/user/login">Login</a></li>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
					<li><a href="javascript:logout();">Logout</a></li>
				</sec:authorize>		        
					<li><a href="/board/free/main">Board</a></li>
				<sec:authorize access="isAuthenticated()">
					<li><a href="<c:url value='/cctv/list' />">CCTV</a></li>
				</sec:authorize>						
				</ul>
			</div>	    
		</div>
	</nav>
	<br><br><br><br><br><br><br>
	<div id="content" class="panel panel-default"><!-- Dynamic Content goes here --></div>
	<p>
	<div id="page-selection"><!-- Pagination goes here --></div>
	<p>
	<sec:authorize access="isAuthenticated()">
		<a href="add?id=<sec:authentication property="name"/>" ><button type="button" class="btn btn-default">글쓰기</button></a>
	</sec:authorize>			
	<p>
	<sec:authorize access="!isAuthenticated()">
		<h4>Guest님이 접속하셨습니다.</h4>
		<h5>글쓰기와 다운로드는 로그인이 필요합니다!</h5>
	</sec:authorize>	
	<sec:authorize access="isAuthenticated()">
		<h4><sec:authentication property="name"/>님이 접속하셨습니다.</h4>
	</sec:authorize>			
	
	<br>	
	<form name="updateForm" action="search">
		<input type="hidden"  id="rpp" name="rpp" value="10">
		<input type="hidden"  id="page"  name="page" value="1">
		<select name="search">
			<option>번호</option><option>제목</option><option>작성자</option><option>내용</option>
		</select>
		<input type="text" name="searchContents">
		<button type="submit" class="btn btn-default" onclick="search();">검색</button>
	</form>
</body>
</html>