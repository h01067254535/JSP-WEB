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
request.setCharacterEncoding("UTF-8");
String reportTitle = null;
String reportContent = null;

if (request.getParameter("ReportTitle") != null) {
	reportTitle = request.getParameter("ReportTitle");
}
if (request.getParameter("ReportContent") != null) {
	reportContent = request.getParameter("ReportContent");
}
if (reportTitle == null || reportContent == null) {
	PrintWriter script = response.getWriter(); //응답 스트림에 텍스트를 기록하기 위해 
	script.println("<script>");
	script.println("alert('입력이 안 된 사항이 있습니다.');");
	script.println("history.back();");
	script.println("</script>");
	script.close();
	return;
}

boolean emailChecked = userDAO.getUserEmailChecked(userID);
if (emailChecked == false) { //이메일 인증이 안된 상태 
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('이메일 인증이 필요합니다.');");
	script.println("location.href='emailSendConfirm.jsp'"); //이전 페이지로 이동 
	script.println("</script>");
	script.close();
	return;
} else { //인증이 된 상태  
	final String from = "gksqhdgkr2@gmail.com"; //your email
	final String password = "Login1323!"; //email password
	final String host = "http://localhost:8080"; //host
	String to = "h01067254535@gmail.com";
	String sub = "강의평가 사이트에서 접수된 신고 내용입니다.";
	String msg = "신고자 : " + userID + "<br>제목: " + reportTitle + "<br>내용 : " + reportContent;
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
PrintWriter script = response.getWriter();
script.println("<script>");
script.println("alert('정상적으로 신고되었습니다');");
script.println("history.back();"); //이전 페이지로 이동 
script.println("</script>");
script.close();

%>
