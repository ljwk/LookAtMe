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
<style type="text/css">
html, body { margin:0; padding:0; height:100%; }
#wrap {
    height:100%;
    color:#fff;
}
#header {
    position:relative;
    width:100%;
    height:45px;
    background-color:#FD428E;
}
#body {
    margin:-45px 0 -50px;
    width:100%;
    min-height:100%;    
    background-color:#24C3FF;
}
#body #container {
    padding:45px 0 50px;
}

#footer {
    width:100%;
    height:50px;
    background-color:#ff0000;
}
</style>

</head>
<body>

<div id="wrap">
    <div id="header">Header</div>
    <div id="body">
        <div id="container">Contents</div>
    </div>
    <div id="footer">Footer</div>
</div>
</body>
</html>
