<%--
  Created by IntelliJ IDEA.
  User: Kimtaerin
  Date: 2022-11-18
  Time: 오후 5:08
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ page import="java.io.PrintWriter" %>
<!doctype html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1">
    <link rel="stylesheet" href="../css/bootstrap.css">
    <link rel="stylesheet" href="../css/custom.css">
    <title>JSP 게시판 웹사이트</title>
</head>
<body>
<%
    String userId = null;
    if (session.getAttribute("userId") != null) {
        userId = (String) session.getAttribute("userId");
    }
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
            <li class="active"><a href="main.jsp">메인</a></li>
            <li><a href="bbs.jsp">게시판</a></li>
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
    <div class="jumbotron">
        <div class="container">
            <h1>웹사이트 소개</h1>
            <p>jsp로 만든 첫 프로젝트 - 게시판 구현하기</p>
            <p><a class="btn btn-primary btn-pull" href="#" role="button">자세히 알아보기</a></p>
        </div>
    </div>
</div>
<div class="container">
  <div id="myCarousel" class="carousel" data-ride="carousel">
      <ol class="carousel-indicators">
          <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
          <li data-target="#myCarousel" data-slide-to="1"></li>
          <li data-target="#myCarousel" data-slide-to="2"></li>
      </ol>
      <div class="carousel-inner">
          <div class="item active">
              <img src="../images/img1.jpg">
          </div>
          <div class="item">
              <img src="../images/img2.jpg">
          </div>
          <div class="item">
              <img src="../images/img3.jpg">
          </div>
      </div>
      <a href="#myCarousel" class="left carousel-control" data-slide="prev">
          <span class="glyphicon glyphicon-chevron-left"></span>
      </a>
      <a href="#myCarousel" class="right carousel-control" data-slide="next">
          <span class="glyphicon glyphicon-chevron-right"></span>
      </a>
  </div>
</div>


<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../js/bootstrap.js"></script>
</body>
</html>
