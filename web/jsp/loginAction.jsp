<%--
  Created by IntelliJ IDEA.
  User: Kimtaerin
  Date: 2022-11-18
  Time: 오전 9:01
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="utf-8" %>
<%--userDAO import--%>
<%@ page import="user.UserDAO" %>
<%--js 작성하기위해 import--%>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userId"/>
<jsp:setProperty name="user" property="userPassword"/>
<!doctype html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>JSP 게시판 웹사이트</title>
</head>
<body>
<%
    String userId = null;

    if (session.getAttribute("userId") != null) {
        userId = (String) session.getAttribute("userId");
    }

    if (userId != null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이미 로그인이 되어있습니다.')");
        script.println("location.href='main.jsp'"); //메인화면으로 이동
        script.println("</script>");
    }

    UserDAO userDAO = new UserDAO();
    int result = userDAO.login(user.getUserId(), user.getUserPassword());
    if (result == 1) { //로그인 성공시
        session.setAttribute("userId", user.getUserId()); //세션부여
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("location.href='main.jsp'"); //메인화면으로 이동
        script.println("</script>");
    } else if (result == 0) { //비밀번호 불일치
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('비밀번호가 틀립니다.')");
        script.println("history.back()"); //로그인페이지로 돌려보내기
        script.println("</script>");
    } else if (result == -1) { //아이디 없음
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('존재하지 않는 아이디입니다.')");
        script.println("history.back()");
        script.println("</script>");
    } else if (result == -2) { //db오류
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('데이터베이스 오류가 발생했습니다')");
        script.println("history.back()");
        script.println("</script>");
    }
%>
</body>
</html>
