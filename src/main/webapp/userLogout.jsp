<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%
	session.invalidate(); //클라이언트의 세션정보 파기
%>
<script>
	location.href = 'index.jsp';
</script>