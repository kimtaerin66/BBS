package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BbsDAO {
    private Connection conn; //db와 연결
    private ResultSet rs; //select 할때 필요, 결과담는용도

    public BbsDAO() {
        try {
            String dbURL = "jdbc:mariadb://localhost:3306/bbs";
            String dbID = "root";
            String dbPassword = "pass0001!";
            Class.forName("org.mariadb.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //작성날짜 가져오기
    public String getDate() {
        String SQL = "SELECT NOW()"; //현재날짜시간조회
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";//db오류
    }

    public int getNext() {
        String SQL = "SELECT BBS_ID FROM board ORDER BY BBS_ID DESC"; //bbsId 내림차순으로가져와서 +1하면 다음게시물번호
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) + 1;
            }
            return 1; //첫번째 게시물인경우
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;//db오류
    }

    public int write(String bbsTitle, String userId, String bbsContent) {
        String SQL = "INSERT INTO board VALUES (?, ? ,? ,? ,?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            //순서대로 하나씩 넣어주기
            pstmt.setInt(1, getNext()); //bbsId
            pstmt.setString(2, bbsTitle); //bbsTitle
            pstmt.setString(3, userId);
            pstmt.setString(4, getDate());
            pstmt.setString(5, bbsContent);
            pstmt.setInt(6, 1);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;//db오류
    }

}
