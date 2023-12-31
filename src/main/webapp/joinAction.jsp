<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userContact"/>
<jsp:setProperty name="user" property="adminAvailable"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>물품 대여/반납 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String)session.getAttribute("userID");
		}
		if (userID != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인되어 있습니다.')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}
		if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null ||
			user.getUserContact() == null || user.getAdminAvailable() == null || request.getParameter("authCode") == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user, (String)request.getParameter("authCode"));
			if (result > -1) { // 회원가입 성공
				session.setAttribute("userID", user.getUserID());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='main.jsp'");
				script.println("</script>");
			}
			else if (result == -1) { // 인증번호 불일치
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('인증번호가 틀립니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else if (result == -2) { // 데이터베이스 오류
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
		}
	%>
</body>
</html>