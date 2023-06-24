<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8");%>
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
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 되어있지 않습니다.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
		if (request.getParameter("userName") == null || request.getParameter("userContact") == null || request.getParameter("currentPassword") == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.change(userID, request.getParameter("userName"), request.getParameter("userContact"),
			request.getParameter("currentPassword"), request.getParameter("newPassword"), request.getParameter("retypePassword"));
			if (result > -1) { // 개인정보 변경 성공
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href='main.jsp'");
				script.println("</script>");
			}
			else if (result == -1) { // 비밀번호 재입력 불일치
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('재입력한 비밀번호가 틀립니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else if (result == -2) { // 현재 비밀번호 불일치
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('현재 비밀번호가 틀립니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else if (result == -3) { // 데이터베이스 오류
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('존재하지 않는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
		}
	%>
</body>
</html>