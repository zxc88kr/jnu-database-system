<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="auth.Auth"%>
<%@ page import="auth.AuthDAO"%>
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
		                        		<li class="active"><a href="auth.jsp">인증코드 관리</a></li>
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
						<th colspan="2" style="background-color:#eeeeee; text-align:center;">인증코드 정보</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width:50%; vertical-align:middle;">학생</td>
						<td style="vertical-align:middle;">관리자</td>
					</tr>
				</tbody>
				<tbody>
					<%
						AuthDAO authDAO = new AuthDAO();
						ArrayList<Auth> list1 = authDAO.getList(false);
						ArrayList<Auth> list2 = authDAO.getList(true);
						int size1 = list1.size();
						int size2 = list2.size();
						int listSize = size1 > size2 ? size1 : size2;
						for (int i = 0; i < listSize; i++) {
					%>
						<tr>
							<td style="width:50%; vertical-align:middle;"><a onclick="return confirm('정말로 삭제하시겠습니까?')"
							href="deleteAuthAction.jsp?target=student&offset=<%= i%>"><%= i<size1?list1.get(i).getAuthCode():""%></a></td>
							<td style="width:50%; vertical-align:middle;"><a onclick="return confirm('정말로 삭제하시겠습니까?')"
							href="deleteAuthAction.jsp?target=manager&offset=<%= i%>"><%= i<size2?list2.get(i).getAuthCode():""%></a></td>
						</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<a href="main.jsp" class="btn btn-primary">메인</a>
			<a href="addAuth.jsp?target=manager" class="btn btn-primary pull-right">관리자 추가</a>
			<a href="addAuth.jsp?target=student" class="btn btn-primary pull-right">학생 추가</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>