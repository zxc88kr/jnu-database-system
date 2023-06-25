<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="rent.RentDAO"%>
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
		if (adminAvailable) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('관리자는 대여할 수 없습니다.')");
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
			script.println("alert('존재하지 않는 물품입니다.')");
			script.println("location.href='board.jsp'");
			script.println("</script>");
		}
		Product product = new ProductDAO().getProduct(productID);
		if (!product.getRentAvailable()) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('대여 불가능한 물품입니다.')");
			script.println("location.href='board.jsp'");
			script.println("</script>");
		}
		if (product.getProductCount() <= 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수량이 부족합니다.')");
			script.println("location.href='board.jsp'");
			script.println("</script>");
		}
		RentDAO rentDAO = new RentDAO();
		if (userID != null) {
			int result = rentDAO.rent(userID, productID, product.getProductName(), product.getProductDeposit());
			if (result > -1) { // 물품 대여 성공
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('대여에 성공했습니다. 대여 기간은 7일입니다.')");
				script.println("location.href='board.jsp'");
				script.println("</script>");
			}
			else { // 데이터베이스 오류
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('대여에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
		}
	%>
</body>
</html>