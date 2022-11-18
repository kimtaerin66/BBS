package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
    private Connection conn; //db와 연결
    private PreparedStatement pstmt; //데이터를 어떤식으로 바인딩하는지
    private ResultSet rs; //select 할때 필요, 결과담는용도

    public UserDAO(){
        try{
        String dbURL ="jdbc:mariadb://localhost:3306/bbs";
        String dbID ="root";
        String dbPassword = "pass0001!";
        Class.forName("org.mariadb.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public int login(String userId, String userPassword){
        String SQL = "SELECT USER_PASSWORD FROM user WHERE USER_ID = ?";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userId); //물음표부분에 userId넣기
            rs = pstmt.executeQuery(); //실행한 결과 넣어주기
            if(rs.next()){ //입력한 아이디가 존재한다면
                if(rs.getString(1).equals(userPassword)){ //비밀번호가 일치한다면
                    return 1; //로그인 성공
                }else{
                    return 0; //비밀번호 불일치
                }
            }
            return -1; //아이디없음
        }catch (Exception e){
            e.printStackTrace();
        }
        return -2; //데이터베이스 오류
    }

    public int join(User user){
        String SQL = "INSERT INTO user VALUES (?, ?, ?, ?, ?)";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user.getUserId());
            pstmt.setString(2, user.getUserPassword());
            pstmt.setString(3, user.getUserName());
            pstmt.setString(4, user.getUserGender());
            pstmt.setString(5, user.getUserEmail());
            return pstmt.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }
        return -1; //데이터베이스 오류
    }

}
