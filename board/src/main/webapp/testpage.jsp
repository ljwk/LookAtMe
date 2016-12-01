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

<script type="text/javascript">
$(document).ready(function(){
    $("#div1").load("resources/nav.jsp");
});
</script>

</head>
<body>
<div id="div1"></div>
</body>
</html>
$(function(){
    $("#navdiv").load("../resources/nav.jsp");
});