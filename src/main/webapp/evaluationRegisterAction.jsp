<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="evaluation.EvaluationDAO" %>
<%@ page import="evaluation.EvaluationDTO" %>

<%
request.setCharacterEncoding("utf-8"); //데이터를(한글 포함) utf-8로 엔코딩하여 처리한다.



String userID = null;
String userPassword = null;
String userEmail = null;
if (session.getAttribute("userID") != null) {
	userID = (String) session.getAttribute("userID");
}
if (userID == null) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인을 해주세요.');");
	script.println("location.href = 'userLogin.jsp';"); //이메일 인증 
	script.println("</script>");
	script.close();
	return;
}

String lectureName = null;
String professorName = null;
int lectureYear = 0;
String semesterDivide = null;
String lectureDivide = null;
String evaluationTitle = null;
String evaluationContent = null;
String totalScore = null;
String creditScore = null;
String comfortableScore = null;
String lectureScore = null;


if(request.getParameter("LectureName") != null) {
	lectureName = (String) request.getParameter("LectureName");
}

if(request.getParameter("ProfessorName") != null) {
	professorName = (String) request.getParameter("ProfessorName");
}

if(request.getParameter("LectureYear") != null) {
	try {
		lectureYear = Integer.parseInt(request.getParameter("LectureYear"));
	} catch (Exception e) {
	}
}

if(request.getParameter("SemesterDivide") != null) {
	semesterDivide = (String) request.getParameter("SemesterDivide");
}

if(request.getParameter("LectureDivide") != null) {
	lectureDivide = (String) request.getParameter("LectureDivide");
}

if(request.getParameter("EvaluationTitle") != null) {
	evaluationTitle = (String) request.getParameter("EvaluationTitle");

}

if(request.getParameter("EvaluationContent") != null) {
	evaluationContent = (String) request.getParameter("EvaluationContent");
}

if(request.getParameter("TotalScore") != null) {
	totalScore = (String) request.getParameter("TotalScore");
}

if(request.getParameter("CreditScore") != null) {
	creditScore = (String) request.getParameter("CreditScore");
}

if(request.getParameter("ComfortableScore") != null) {
	comfortableScore = (String) request.getParameter("ComfortableScore");
}

if(request.getParameter("LectureScore") != null) {
	lectureScore = (String) request.getParameter("LectureScore");
}

if (lectureName == null || professorName == null || lectureYear == 0 || semesterDivide == null ||
lectureDivide == null || evaluationTitle == null || evaluationContent == null || totalScore == null ||
creditScore == null || comfortableScore == null || lectureScore == null ||
evaluationTitle.equals("") || evaluationContent.equals(""))
 {
	PrintWriter script = response.getWriter(); //응답 스트림에 텍스트를 기록하기 위해 
	script.println("<script>");
	script.println("alert('입력이 안 된 사항이 있습니다.');");
	script.println("history.back()"); //이전 페이지로 이동 
	script.println("</script>");
	script.close();
	return;
}

EvaluationDAO evaluationDAO = new EvaluationDAO();
int result = evaluationDAO.write(new EvaluationDTO(0, userID, lectureName, professorName, lectureYear,
		semesterDivide, lectureDivide, evaluationTitle, evaluationContent,
		totalScore, creditScore, comfortableScore, lectureScore, 0));

if (result == -1){
PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('강의평가 등록 실패했습니다.');");
	script.println("history.back()"); //이전 페이지로 이동 
	script.println("</script>");
	script.close();
	return;
	
} else {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("location.href='index.jsp'"); //이메일 인증 
	script.println("</script>");
	script.close();
	return;
}
%>