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
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword, adminAvailable FROM User WHERE userID = ?";
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
	
	public User getBriefUser(String userID) {
		String SQL = "SELECT * FROM User WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				User briefUser = new User();
				briefUser.setUserID(null);
				briefUser.setUserPassword(null);
				briefUser.setUserName(rs.getString(3));
				briefUser.setUserContact(rs.getString(4));
				briefUser.setAdminAvailable(null);
				return briefUser; // 사용자 가져오기 성공 (보안 주의)
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // 데이터베이스 오류
	}
	
	public Boolean isMatchPassword(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM User WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString(1).equals(userPassword)) {
					return true; // 패스워드 일치
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false; // 데이터베이스 오류
	}
	
	public int change(String userID, String userName, String userContact, String currentPassword, String newPassword, String retypePassword) {
		String SQL = "UPDATE User SET userName = ?, userContact = ?, userPassword = ? WHERE userID = ?";
		try {
			if (isMatchPassword(userID, currentPassword)) {
				if (newPassword.equals(retypePassword)) {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					pstmt.setString(1, userName);
					pstmt.setString(2, userContact);
					if (retypePassword.equals("")) {
						pstmt.setString(3, currentPassword);
					}
					else {
						pstmt.setString(3, newPassword);
					}
					pstmt.setString(4, userID);
					return pstmt.executeUpdate(); // 개인정보 변경 성공
				}
				return -1; // 재입력 비밀번호 불일치
			}
			return -2; // 현재 비밀번호 불일치
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -3; // 데이터베이스 오류
	}
}