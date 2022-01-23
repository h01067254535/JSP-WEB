<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="likey.LikeyDTO"%>
<%@ page import="java.io.PrintWriter"%>


<%
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
String evaluationID = null;
String reportContent = null;

if (request.getParameter("evaluationID") != null) {
	evaluationID = request.getParameter("evaluationID");
}

EvaluationDAO evaluationDAO = new EvaluationDAO();

if(userID.equals(evaluationDAO.getUserID(evaluationID))) { //작성자와 삭제하려는 사람 ID가 같을 때,
	int result = new EvaluationDAO().delete(evaluationID);
	if (result ==1) {	
PrintWriter script = response.getWriter(); //응답 스트림에 텍스트를 기록하기 위해 
	script.println("<script>");
	script.println("alert('삭제가 완료되었습니다.');");
	script.println("location.href='index.jsp'");
	script.println("</script>");
	script.close();
	return;
}else {
	PrintWriter script = response.getWriter(); //응답 스트림에 텍스트를 기록하기 위해 
	script.println("<script>");
	script.println("alert('데이터베이스 오류가 발생했습니다.');");
	script.println("history.back();");
	script.println("</script>");
	script.close();
	return;
}
}else {
	PrintWriter script = response.getWriter(); //응답 스트림에 텍스트를 기록하기 위해 
	script.println("<script>");
	script.println("alert('자신이 쓴 글만 삭제 가능합니다.');");
	script.println("history.back();");
	script.println("</script>");
	script.close();
	return;
}
%>