<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="<c:url value="/resources/jquery-3.1.1.min.js"/>"></script>
<script type="text/javascript">
	function right() {
		console.log("right");
		var obj = {};
		obj.key = 'aaaaaaa';
		$.ajax({
			url : "http://192.168.2.26:8084",
			data : obj
		});
		console.log("right endPoint");
	};
	
	function left() {
		var obj = {};
		obj.key = 'ddddddd';
		$.ajax({
			url : "http://192.168.2.26:8084",
			data : obj
		});
		console.log("left endPoint");
	};
</script>
</head>
<body>
	<div id="view">
		<img style='-webkit-user-select: none'
			src='http://192.168.2.26:8083?id=${sessionid}'>
	</div>
	<div>
		<button id="left" onclick="left();">←</button>
		<button id="right" onclick="right();">→</button>
	</div>
</body>
</html>