<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags"%>

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
						<li class="no">Guest님이 접속하셨습니다.</li>
						<li class="no">글쓰기와 다운로드는 로그인이 필요합니다!</li>
					</sec:authorize>
					<sec:authorize access="isAuthenticated()">
						<li><a><sec:authentication property="name"/>님이 접속하셨습니다.</a></li>
					</sec:authorize>		
      			</ul>
			</div>	    
	</nav>
</div>
