<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
request.setCharacterEncoding("utf-8"); //데이터를(한글 포함) utf-8로 엔코딩하여 처리한다.

String userID = null;
String userPassword = null;

if (request.getParameter("userID") != null) {
	userID = request.getParameter("userID");
}
if (request.getParameter("userPassword") != null) {
	userPassword = request.getParameter("userPassword");
}

if (userID == null || userPassword == null) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('입력이 안 된 사항이 있습니다.');");
	script.println("history.back()"); //이전 페이지로 이동 
	script.println("</script>");
	script.close();
	return;
}

UserDAO userDAO = new UserDAO();
int result = userDAO.login(userID, userPassword);
if (result == 1) { //회원가입 실패 (아이디 중복)
	session.setAttribute("userID", userID);
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("location.href = 'index.jsp'"); //이전 페이지로 이동 
	script.println("</script>");
	script.close();
	return;
} else if (result == 0){
	//세션 생성 
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('비밀번호가 틀립니다.');");
	script.println("history.back();"); //이메일 인증 
	script.println("</script>");
	script.close();
	return;
}
else if (result == -1){
	//세션 생성 
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('존재하지 않는 아이디입니다.');");
	script.println("history.back();"); //이메일 인증 
	script.println("</script>");
	script.close();
	return;
}
else if (result == -2){
	//세션 생성 
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('데이터베이스 오류가 발생했습니다.');");
	script.println("history.back();"); //이메일 인증 
	script.println("</script>");
	script.close();
	return;
}
%>