<%--
  Created by IntelliJ IDEA.
  User: Kimtaerin
  Date: 2022-11-21
  Time: 오후 1:51
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="utf-8" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page"/>
<jsp:setProperty name="bbs" property="bbsTitle"/>
<jsp:setProperty name="bbs" property="bbsContent"/>
<
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

    //로그인을 하지않은 경우
    if (userId == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인을 하세요.')");
        script.println("location.href='login.jsp'"); //메인화면으로 이동
        script.println("</script>");
    } else {
        if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("입력이 안된 사항이 있습니다.");
            script.println("</script>");
        } else {
            BbsDAO bbsDAO = new BbsDAO();
            int result = bbsDAO.write(bbs.getBbsTitle(), userId, bbs.getBbsContent());
            if (result == -1) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('글쓰기에 실패했습니다.')");
                script.println("</script>");
            }
            else { //정상 글업로드
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("location.href='bbs.jsp'"); //게시판 메인화면으로 이동
                script.println("</script>");
            }
        }
    }
%>
</body>
</html>
