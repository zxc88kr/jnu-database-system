<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="product.Product"%>
<%@ page import="product.ProductDAO"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
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
			script.println("alert('존재하지 않는 물품입니다.')");
			script.println("location.href='board.jsp'");
			script.println("</script>");
		}
		Product product = new ProductDAO().getProduct(productID);
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expanded="false">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="main.jsp">물품 대여/반납 웹 사이트</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="board.jsp">게시판</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">마이페이지<span class="caret"></span></a>
					<ul class="dropdown-menu">
                        <li><a href="rent.jsp">대여이력 조회</a></li>
                        <li><a href="return.jsp">반납이력 조회</a></li>
                        <li><a href="change.jsp">개인정보 변경</a></li>
                        <%
                        	if (adminAvailable) {
                        %>
                        		<li><a href="auth.jsp">인증코드 관리</a></li>
                        <%
							}
                        %>
                        <li><a href="logoutAction.jsp">로그아웃</a></li>
                    </ul>
				</li>
			</ul>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<form method="post" action="updateAction.jsp?productID=<%= productID%>">
				<table class="table table-striped" style="text-align:center; border:1px solid #dddddd;">
					<thead>
						<tr>
							<th colspan="2" style="background-color:#eeeeee; text-align:center;">물품 수정</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width:20%; vertical-align:middle;">물품명</td>
							<td><input type="text" class="form-control" placeholder="물품명" name="productName" maxlength="20" value="<%= product.getProductName()%>"></td>
						</tr>
						<tr>
							<td style="vertical-align:middle;">수량</td>
							<td><input type="number" class="form-control" placeholder="수량" name="productCount" max="10000" value="<%= product.getProductCount()%>"></td>
						</tr>
						<tr>
							<td style="vertical-align:middle;">보증금</td>
							<td><input type="number" class="form-control" placeholder="보증금" name="productDeposit" max="1000000" value="<%= product.getProductDeposit()%>"></td>
						</tr>
						<tr>
							<td style="vertical-align:middle;">상태</td>
							<td>
								<div class="form-group" style="margin-bottom:0px;">
			                        <div class="btn-group btn-group-justified" data-toggle="buttons">
			                        	<label class="btn btn-primary <%= product.getRentAvailable()?"active":""%>">
			                        		<input type="radio" name="rentAvailable" autocomplete="off" value="true" <%= product.getRentAvailable()?"checked":""%>>대여 가능
			                        	</label>
			                        	<label class="btn btn-primary <%= product.getRentAvailable()?"":"active"%>">
			                        		<input type="radio" name="rentAvailable" autocomplete="off" value="false" <%= product.getRentAvailable()?"":"checked"%>>대여 불가능
			                        	</label>
			                        </div>
			                    </div>
							</td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="완료">
			</form>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>