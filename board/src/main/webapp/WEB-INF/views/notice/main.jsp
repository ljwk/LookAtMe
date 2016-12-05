<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<script src="//code.jquery.com/jquery-2.1.3.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<script src="//raw.github.com/botmonster/jquery-bootpag/master/lib/jquery.bootpag.min.js"></script>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script src="<c:url value="/resources/jquery.bootpag.min.js"/>"></script>
<script>
	$(function(){
	    $("#navdiv").load("../resources/nav.jsp");
	    $("#footer").load("../resources/footer.jsp");
	});

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
	#navdiv {height:100px;}
	table {border-spacing: 0px; margin: 0px auto;}
	th, td {padding: 5px;}
	th {text-align: center; background: rgb(252, 252, 252);}
	td {color: gray;}
	#tnum {width: 45px;}
	#ttitle {width:420px;}
	#tauthor {width:80px;}
	#tdate {width:100px;}
	#tnum {width:60px;}
	#jul:hover {background-color: rgb(202, 214, 255);}
	#content {width: 800px; margin: 0px auto;margin-top:50px;}
	#title {width: 300px; text-align: left;}
	a:hover {color: red;}
	a:active {color: gold}
	a {color: gray; text-decoration: none;}
	.no {position: relative; display: block; padding: 12px 15px;}
</style>
</head>
<body>
<div id="navdiv"></div>
	<h3 style="margin-right: 700px; font:bold 32px none;">공지사항</h3>
	<hr style="width: 800px; border:1px solid lightgray; margin-bottom:50px;">
	<div id="content" class="panel panel-default"><!-- Dynamic Content goes here --></div>
	<br>
	<form name="updateForm" action="search">
		<input type="hidden"  id="rpp" name="rpp" value="10">
		<input type="hidden"  id="page"  name="page" value="1">
		<select name="search" style="height: 30px;">
			<option>번호</option><option>제목</option><option>작성자</option><option>내용</option>
		</select>
		<input type="text" name="searchContents" style="height: 30px;">
		<button type="submit" class="btn btn-default" onclick="search();">검색</button>
		<sec:authorize access="hasAuthority('USER_MANAGER')">
			<a href="add?id=<sec:authentication property="name"/>" ><button type="button" class="btn btn-default">글쓰기</button></a>
		</sec:authorize>
	</form>
	<div id="page-selection"><!-- Pagination goes here --></div>
	<div id="footarea">
	<div id="footer"></div>
	</div>
</body>
</html>