<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="product.Product"%>
<%@ page import="product.ProductDAO"%>
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
		Boolean adminAvailable = false;
		if (session.getAttribute("adminAvailable") != null) {
			adminAvailable = (Boolean)session.getAttribute("adminAvailable");
		}
		if (!adminAvailable) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='board.jsp'");
			script.println("</script>");
		}
		int productID = 0;
		if (request.getParameter("productID") != null) {
			productID = Integer.parseInt(request.getParameter("productID"));
		}
		if (productID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 게시물입니다.')");
			script.println("location.href='board.jsp'");
			script.println("</script>");
		}
		ProductDAO productDAO = new ProductDAO();
		int result = productDAO.delete(productID);
		if (result > -1) { // 물품 삭제 성공
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='board.jsp'");
			script.println("</script>");
		}
		else { // 데이터베이스 오류
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('물품 삭제에 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>