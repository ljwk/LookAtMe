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
		$("#navdiv").load("../resources/nav.jsp");
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
	.no{
	position: relative;
    display: block;
    padding: 12px 15px;
    }
</style>
</head>
<body>
<div id="navdiv">
</div>
	<h3>게 시 판 !</h3>
	<div id="content" class="panel panel-default">

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