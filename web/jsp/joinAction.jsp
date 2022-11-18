<%--
  Created by IntelliJ IDEA.
  User: Kimtaerin
  Date: 2022-11-18
  Time: 오전 9:01
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="utf-8" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userId"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userEmail"/>
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

    if (user.getUserId() == null || user.getUserPassword() == null || user.getUserGender() == null ||
            user.getUserName() == null || user.getUserEmail() == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("입력이 안된 사항이 있습니다.");
        script.println("</script>");
    } else {
        UserDAO userDAO = new UserDAO();
        int result = userDAO.join(user);
        if (result == -1) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('이미 존재하는 아이디입니다.')");
            script.println("</script>");
        } else if (result == 0) { //정상 회원가입
            session.setAttribute("userId", user.getUserId());
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("location.href='main.jsp'"); //메인화면으로 이동
            script.println("</script>");
        }
    }
%>
</body>
</html>
