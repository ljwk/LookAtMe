<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="<c:url value="/resources/jquery-3.1.1.min.js"/>"></script>
<script type="text/javascript">
	var connection = true;
// 	$(window).on('load', function() {
// 		var obj = {};
// 		obj.id = '${sessionid}';
// 		$.ajax({
// 			url : 'http://192.168.2.26:8083',
// 			data : obj,
// // 			type : 'post',
// 			complete : function() {
// 				$('#view').html("<img style='-webkit-user-select: none' src='http://192.168.2.26:8080?id=${sessionid}'>");
				
// 			}
// 		});
// 		console.log('first ajax endpoint');
// 	});
</script>
</head>
<body>
	<div id="view"><img style='-webkit-user-select: none' src='http://192.168.2.26:8083?id=${sessionid}'></div>
</body>
</html>