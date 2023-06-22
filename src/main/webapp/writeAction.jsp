<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="board" class="board.Board" scope="page"/>
<jsp:setProperty name="board" property="boardTitle"/>
<jsp:setProperty name="board" property="boardContent"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
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
		else {
			if (board.getBoardTitle() == null || board.getBoardContent() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {
				BoardDAO boardDAO = new BoardDAO();
				int result = boardDAO.write(board.getBoardTitle(), userID, board.getBoardContent());
				if (result != -1) { // 게시물 작성 성공
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href='board.jsp'");
					script.println("</script>");
				}
				else { // 데이터베이스 오류
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('게시물 작성에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>