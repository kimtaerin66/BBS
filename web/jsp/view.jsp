<%--
  Created by IntelliJ IDEA.
  User: Kimtaerin
  Date: 2022-11-21
  Time: 오후 3:25
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<!doctype html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1">
    <link rel="stylesheet" href="../css/bootstrap.css">
    <title>JSP 게시판 웹사이트</title>
</head>
<body>
<%
    String userId = null;
    if (session.getAttribute("userId") != null) {
        userId = (String) session.getAttribute("userId");
    }
    //url애 넘어온 bbsId 이용
    int bbsId =0;
    if(request.getParameter("bbsId") != null){
        bbsId = Integer.parseInt(request.getParameter("bbsId"));
    }
    if(bbsId == 0){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 글입니다')");
        script.println("location.href = 'bbs.jsp'");
        script.println("</script>");
    }
    Bbs bbs = new BbsDAO().getBbs(bbsId);
%>
<nav class="navbar navbar-default">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expanded="false">
            <%--        메뉴바 --%>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
    </div>
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav">
            <li><a href="main.jsp">메인</a></li>
            <li class="active"><a href="bbs.jsp">게시판</a></li>
        </ul>
        <%--        로그인 안되어있는 사람만보이게--%>
        <%--        오른쪽 메뉴--%>
        <%
            if (userId == null) {
        %>
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                   aria-expanded="false" aria-haspopup="true">접속하기<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="login.jsp">로그인</a></li>
                    <li><a href="join.jsp">회원가입</a></li>
                </ul>
                    <%
                    } else {
                %>
                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                           aria-expanded="false" aria-haspopup="true">회원관리<span class="caret"></span></a>
                        <ul class="dropdown-menu">
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
            <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
                <thead>
                <tr>
                    <th colspan="3" style="background-color: #eeeeee; text-align: center">게시판 글 보기</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td style="width: 20%;">글 제목</td>
                    <td colspan="2"><%= bbs.getBbsTitle()%></td>
                </tr>
                <tr>
                    <td>작성자</td>
                    <td colspan="2"><%= bbs.getUserId()%></td>
                </tr>
                <tr>
                    <td>작성일자</td>
                    <td colspan="2"><%= bbs.getBbsDate().substring(0,11)%></td>
                </tr>
                <tr>
                    <td>내용</td>
                    <td colspan="2" ><div style="min-height: 200px; text-align: left"><%= bbs.getBbsContent().replaceAll("","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;") %> </div></td>
                </tr>
                </tbody>
            </table>
         <a href="bbs.jsp" class="btn btn-primary">목록</a>

        <%
        if(userId != null && userId.equals(bbs.getUserId())){
        %>
        <a href="update.jsp?bbsId=<%= bbsId%>" class="btn btn-primary">수정</a>
        <a href="deleteAction.jsp?bbsId=<%= bbsId%>" class="btn btn-primary">삭제</a>
        <%
        }
        %>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../js/bootstrap.js"></script>
</body>
</html>
