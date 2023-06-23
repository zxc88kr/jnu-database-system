package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String dbURL = "jdbc:mysql://localhost:3306/chan";
			String dbID = "root";
			String dbPassword = "1234";
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword, boardAvailable FROM User WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString(1).equals(userPassword)) {
					if (rs.getBoolean(2)) {
						return 2; // 관리자 로그인 성공
					}
					return 1; // 학생 로그인 성공
				}
				return 0; // 비밀번호 불일치
			}
			return -1; // 아이디 없음
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // 데이터베이스 오류
	}
	
	public int auth(String authCode, Boolean adminAvailable) {
		String SQL = "SELECT * FROM Auth WHERE authCode = ? AND adminAvailable = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, authCode);
			pstmt.setBoolean(2, adminAvailable);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return 1; // 인증 성공
			}
			return -1; // 인증 실패
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // 데이터베이스 오류
	}
	
	public int join(User user, String authCode) {
		String SQL = "INSERT INTO User VALUES (?, ?, ?, ?, ?)";
		try {
			if (auth(authCode, user.getAdminAvailable()) != -1) {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, user.getUserID());
				pstmt.setString(2, user.getUserPassword());
				pstmt.setString(3, user.getUserName());
				pstmt.setString(4, user.getUserContact());
				pstmt.setBoolean(5, user.getAdminAvailable());
				return pstmt.executeUpdate(); // 회원가입 성공
			}
			return -1; // 인증번호 불일치
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // 데이터베이스 오류
	}
}