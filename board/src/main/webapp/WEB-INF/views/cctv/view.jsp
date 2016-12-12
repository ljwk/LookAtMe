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
	var ip = '${vo.cctvip}';
	function right() {
		console.log("right");
		console.log("http://" + ip.split(':')[0] + ":8890?key=aaaaaa");
		$.ajax("http://" + ip.split(':')[0] + ":8890?key=aaaaaa");
		console.log("right endPoint");
	};

	function left() {
		console.log("left");
		console.log("http://" + ip.split(':')[0] + ":8890?key=ddddddd");
		$.ajax("http://" + ip.split(':')[0] + ":8890?key=ddddddd");
		console.log("left endPoint");
	};
</script>
</head>
<body>
	<div id="view">
		<img style='-webkit-user-select: none'
			src='http://${vo.cctvip}/?id=${sessionid}'>
	</div>
	<c:if test="${vo.authority eq 'ADMIN'}">
		<div>
			<button id="left" onclick="left();">←</button>
			<button id="right" onclick="right();">→</button>
		</div>
	</c:if>
</body>
</html>