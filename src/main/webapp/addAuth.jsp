<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">마이페이지<span class="caret"></span></a>
					<ul class="dropdown-menu">
                        <li><a href="rent.jsp">대여이력 조회</a></li>
                        <li><a href="returned.jsp">반납이력 조회</a></li>
                        <li><a href="change.jsp">개인정보 변경</a></li>
                        <%
                        	if (adminAvailable) {
                        %>
                        		<li class="active"><a href="auth.jsp">인증코드 관리</a></li>
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
			<form method="post" action="addAuthAction.jsp?target=<%= request.getParameter("target")%>">
				<table class="table table-striped" style="text-align:center; border:1px solid #dddddd;">
					<thead>
						<tr>
							<th colspan="2" style="background-color:#eeeeee; text-align:center;">인증코드 추가</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width:20%; vertical-align:middle;">인증코드</td>
							<td><input type="text" class="form-control" placeholder="인증코드" name="authCode" maxlength="10"></td>
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