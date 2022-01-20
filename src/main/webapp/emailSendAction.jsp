<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.Properties"%>
<%@ page import="javax.mail.*"%>
<%@ page import="javax.mail.internet.*"%>


<%
UserDAO userDAO = new UserDAO();
String userID = null;
if (session.getAttribute("userID") != null) { //사용자가 로그인한 상태(세션 o)
   userID = (String) session.getAttribute("userID");
} else {
   PrintWriter script = response.getWriter(); //응답 스트림에 텍스트를 기록하기 위해 
   script.println("<script>");
   script.println("alert('로그인을 해주세요');");
   script.println("location.href='userLogin.jsp'");
   script.println("</script>");
   script.close();
   return;
}

boolean emailChecked = userDAO.getUserEmailChecked(userID);
if (emailChecked == true) { //이메일 인증이 된 상태 
   PrintWriter script = response.getWriter();
   script.println("<script>");
   script.println("alert('이미 인증된 회원입니다.');");
   script.println("location.href='index.jsp'"); //이전 페이지로 이동 
   script.println("</script>");
   script.close();
   return;
} else { //인증이 되지 않은 상태 
   final String from = "h01067254535@gmail.com";
   final String password = "han4294535";
   final String host = "http://localhost:8080/";
   String to = userDAO.getUserEmail(userID);
   String sub = "강의평가를 위한 인증 메일";
   String msg = "다음 링크에 접속하여 메일 인증을 진행하세요." + "<a href='" + host + "emailCheckAction.jsp?code=" + new SHA256().getSHA256(to)
   + "'> 이메일 인증하기</a>";

   Properties props = new Properties();
   props.put("mail.smtp.host", "smtp.gmail.com");
   props.put("mail.smtp.auth", "true");
   props.put("mail.smtp.port", "465");
   props.put("mail.smtp.socketFactory.port", "465");
   props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
   props.put("mail.smtp.ssl.protocols", "TLSv1.2");

   //get Session   
   Session mail_session = Session.getInstance(props, new javax.mail.Authenticator() {
      protected PasswordAuthentication getPasswordAuthentication() {
   return new PasswordAuthentication(from, password);
      }
   });
   //compose message    
   try {
      MimeMessage message = new MimeMessage(mail_session);
      message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
      message.setSubject(sub);
      message.setText(msg, null, "html");
      //send message  
      Transport.send(message);
   } catch (MessagingException e) {
      throw new RuntimeException(e);
   }
}
%>

<!DOCTYPE html>
<html>
<head>
<title>메일 전송 완료</title>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 반응형 처리 -->

<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
   integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
   crossorigin="anonymous">


</head>



<body>
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
						if (userID == null) { //로그인이 안되어있으면, 로그인과 회원가입만 보임.
						%>
						<a class="dropdown-item" href="userLogin.jsp">로그인</a> <a
							class="dropdown-item" href="userJoin.jsp">회원가입</a>
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
   <section class="container mt-3" style="max-width: 560px;">
      <div class="alert alert-success mt-4" role="alert">메일을 전송하였습니다. 회원가입 시 입력한 메일로 인증을 완료해 주세요</div>
   </section>
   
   <jsp:include page="./WEB-INF/views/footer.jsp" />


   <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
      integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
      crossorigin="anonymous"></script>
   <script
      src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
      integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
      crossorigin="anonymous"></script>
   <script
      src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
      integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
      crossorigin="anonymous"></script>

</body>
</html>



