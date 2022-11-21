package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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

    //게시판 목록 가져오기
    public ArrayList<Bbs> getList(int pageNumber){
        //삭제가 되지않은 글만 가져오기
        String SQL = "SELECT * FROM board WHERE BBS_ID < ? AND BBS_AVAILABLE = 1 ORDER BY BBS_ID DESC LIMIT 10";
        ArrayList<Bbs> list = new ArrayList<Bbs>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            //게시글이 5개일때, getNext는 6이되고 한페이지에 전부표현가능
            pstmt.setInt(1, getNext() - (pageNumber -1) *10);
            rs = pstmt.executeQuery();
           while (rs.next()) {
               Bbs bbs = new Bbs();
               bbs.setBbsId(rs.getInt(1));
               bbs.setBbsTitle(rs.getString(2));
               bbs.setUserId(rs.getString(3));
               bbs.setBbsDate(rs.getString(4));
               bbs.setBbsContent(rs.getString(5));
               bbs.setBbsAvailable(rs.getString(6));
               list.add(bbs); //리스트에 담아서 리턴
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    //페이지 갯수에따라 다음페이지 버튼 존재여부
    public boolean nextPage(int pageNumber){
        String SQL = "SELECT * FROM board WHERE BBS_ID < ? AND BBS_AVAILABLE = 1 ORDER BY BBS_ID DESC LIMIT 10;";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext() - (pageNumber -1) *10);
            rs = pstmt.executeQuery();
            if(rs.next()) { //결과가 하나라도 존재하면 true
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    //게시글 상세불러오기
    public Bbs getBbs(int bbsId){
        String SQL = "SELECT * FROM board WHERE BBS_ID = ? ;";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsId);
            rs = pstmt.executeQuery(); //bbs하나가 나왓다면
            if(rs.next()) {
                Bbs bbs = new Bbs(); //불러온 bbs에서 get하여 하나씩 대입
                bbs.setBbsId(rs.getInt(1));
                bbs.setBbsTitle(rs.getString(2));
                bbs.setUserId(rs.getString(3));
                bbs.setBbsDate(rs.getString(4));
                bbs.setBbsContent(rs.getString(5));
                bbs.setBbsAvailable(rs.getString(6));
                return bbs;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    //게시글 수정
    public int update(int bbsId, String bbsTitle, String bbsContent){
        String SQL = "UPDATE board SET BBS_TITLE = ?, BBS_CONTENT = ? WHERE BBS_ID = ?"; //bbsId 내림차순으로가져와서 +1하면 다음게시물번호
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, bbsTitle);
            pstmt.setString(2, bbsContent);
            pstmt.setInt(3, bbsId );
            return pstmt.executeUpdate(); //성공시 0이상 값 반환
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;//db오류
    }
}
