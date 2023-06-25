<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="returned.Returned"%>
<%@ page import="returned.ReturnedDAO"%>
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
				<li><a href="board.jsp">게시판</a></li>
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
		                        <li class="active"><a href="return.jsp">반납이력 조회</a></li>
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
						<th style="background-color:#eeeeee; text-align:center;">반납번호</th>
						<th style="background-color:#eeeeee; text-align:center;">아이디</th>
						<th style="background-color:#eeeeee; text-align:center;">물품명</th>
						<th style="background-color:#eeeeee; text-align:center;">대여일</th>
						<th style="background-color:#eeeeee; text-align:center;">반납일</th>
					</tr>
				</thead>
				<tbody>
					<%
						ReturnedDAO returnedDAO = new ReturnedDAO();
						ArrayList<Returned> list = returnedDAO.getList(pageNumber, adminAvailable, userID);
						for (int i = 0; i < list.size(); i++) {
					%>
							<tr>
								<td style="width:15%; vertical-align:middle;"><%= list.get(i).getReturnID()%></td>
								<td style="width:20%; vertical-align:middle;"><%= list.get(i).getUserID()%></td>
								<td style="width:35%; vertical-align:middle;"><%= list.get(i).getProductName()%></td>
								<td style="width:15%; vertical-align:middle;"><%= list.get(i).getRentDate()%></td>
								<td style="width:15%; vertical-align:middle;"><%= list.get(i).getReturnDate()%></td>
							</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<%
				if (pageNumber != 1) {
			%>
					<a href="return.jsp?pageNumber=<%= pageNumber - 1%>" class="btn btn-success">이전</a>
			<%
				}
				if (returnedDAO.isExistPage(pageNumber + 1, adminAvailable, userID)) {
			%>
					<a href="return.jsp?pageNumber=<%= pageNumber + 1%>" class="btn btn-success">다음</a>
			<%
				}
			%>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>