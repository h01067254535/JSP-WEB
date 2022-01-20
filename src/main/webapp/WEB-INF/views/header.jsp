<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDAO"%>

<%
	String userID = null;
if(session.getAttribute("userID") != null) {
	userID = (String) session.getAttribute("userID");
	}
if(userID == null) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인을 해주세요.');");
	script.println("location.href = 'index.jsp';"); //이메일 인증 
	script.println("</script>");
	script.close();
	return;
}
boolean emailChecked = new UserDAO().getUserEmailChecked(userID);
if(emailChecked == false) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인을 해주세요.');");
	script.println("location.href = 'emailSendConfirm.jsp';"); //이메일 인증 
	script.println("</script>");
	script.close();
	return;
}
%>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<a class="navbar-brand" href="index.jsp">강의평가 웹 사이트</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarSupportedContent"
		aria-controls="navbarSupportedContent" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item"><a class="nav-link" href="index.jsp">메인
					<span class="sr-only">(current)</span>
			</a></li>
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" href="index.jsp"
				id="navbarDropdown" role="button" data-toggle="dropdown"
				aria-haspopup="true" aria-expanded="false"> 회원 관리 </a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
<%
	if(userID == null){ //로그인이 안되어있으면, 로그인과 회원가입만 보임.
%>
					<a class="dropdown-item" href="userLogin.jsp">로그인</a> 
					<a class="dropdown-item" href="userJoin.jsp">회원가입</a>
<% 
	} else {
%>
					<a class="dropdown-item" href="userLogout.jsp">로그아웃</a>

<%
	}
%>
				</div></li>

		</ul>
		<form class="form-inline my-2 my-lg-0">
			<input class="form-control mr-sm-2" type="search"
				placeholder="내용을 입력하세요." aria-label="Search">
			<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
		</form>
	</div>
</nav>