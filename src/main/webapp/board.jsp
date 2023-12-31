<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="product.Product"%>
<%@ page import="product.ProductDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>물품 대여/반납 웹 사이트</title>
<style type="text/css">
	a, a:hover {
		color: #d9534f;
		text-decoration: none;
	}
	td:nth-child(2) {
		font-weight: bold;
	}
</style>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String)session.getAttribute("userID");
		}
		Boolean adminAvailable = false;
		if (session.getAttribute("adminAvailable") != null) {
			adminAvailable = (Boolean)session.getAttribute("adminAvailable");
		}
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
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
			<%
				if (userID == null) {
			%>
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown">
							<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">접속하기<span class="caret"></span></a>
							<ul class="dropdown-menu">
		                        <li><a href="join.jsp">회원가입</a></li>
		                        <li><a href="login.jsp">로그인</a></li>
		                    </ul>
						</li>
					</ul>
			<%
				}
				else {
			%>
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
			<%
				}
			%>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align:center; border:1px solid #dddddd;">
				<thead>
					<tr>
						<th style="background-color:#eeeeee; text-align:center;">물품번호</th>
						<th style="background-color:#eeeeee; text-align:center;">물품명</th>
						<th style="background-color:#eeeeee; text-align:center;">수량</th>
						<th style="background-color:#eeeeee; text-align:center;">보증금</th>
						<th style="background-color:#eeeeee; text-align:center;">상태</th>
					</tr>
				</thead>
				<tbody>
					<%
						ProductDAO productDAO = new ProductDAO();
						ArrayList<Product> list = productDAO.getList(pageNumber, adminAvailable);
						for (int i = 0; i < list.size(); i++) {
					%>
							<tr>
								<td style="width:15%; vertical-align:middle;"><%= list.get(i).getProductID()%></td>
								<td style="width:35%; vertical-align:middle;"><a href="view.jsp?productID=<%= list.get(i).getProductID()%>"><%= list.get(i).getProductName()%></a></td>
								<td style="width:15%; vertical-align:middle;"><%= list.get(i).getProductCount()%></td>
								<td style="width:15%; vertical-align:middle;"><%= list.get(i).getProductDeposit()%></td>
								<%
									if (list.get(i).getRentAvailable()) {
								%>
										<td style="width:20%; vertical-align:middle;">대여 가능</td>
								<%
									}
									else {
								%>
										<td style="width:20%; vertical-align:middle;">대여 불가능</td>
								<%
									}
								%>
							</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<%
				if (pageNumber != 1) {
			%>
					<a href="board.jsp?pageNumber=<%= pageNumber - 1%>" class="btn btn-success">이전</a>
			<%
				}
				if (productDAO.isExistPage(pageNumber + 1, adminAvailable)) {
			%>
					<a href="board.jsp?pageNumber=<%= pageNumber + 1%>" class="btn btn-success">다음</a>
			<%
				}
				if (adminAvailable) {
			%>
					<a href="write.jsp" class="btn btn-primary pull-right">추가</a>
			<%
				}
			%>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>