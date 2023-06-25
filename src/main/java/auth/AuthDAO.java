package auth;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class AuthDAO {
	private Connection conn;
	private ResultSet rs;
	
	public AuthDAO() {
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
	
	public ArrayList<Auth> getList(Boolean adminAvailable) {
		String SQL = "SELECT authCode FROM Auth WHERE adminAvailable = ? ORDER BY authCode";
		ArrayList<Auth> list = new ArrayList<Auth>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setBoolean(1, adminAvailable);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Auth auth = new Auth();
				auth.setAuthCode(rs.getString(1));
				list.add(auth);
			}
			return list; // 인증코드 가져오기 성공
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // 데이터베이스 오류
	}
	
	public int add(String authCode, String target) {
		String SQL = "INSERT INTO Auth VALUES (?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, authCode);
			if (target.equals("student")) {
				pstmt.setBoolean(2, false);
			}
			else if (target.equals("manager")) {
				pstmt.setBoolean(2, true);
			}
			return pstmt.executeUpdate(); // 인증코드 추가 성공
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public String deleteTarget(String target, int offset) {
		String SQL = "SELECT authCode FROM Auth WHERE adminAvailable = ? ORDER BY authCode LIMIT 1 OFFSET ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			if (target.equals("student")) {
				pstmt.setBoolean(1, false);
			}
			else if (target.equals("manager")) {
				pstmt.setBoolean(1, true);
			}
			pstmt.setInt(2, offset);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1); // 질의 성공
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // 데이터베이스 오류
	}
	
	public int delete(String target, int offset) {
		String SQL = "DELETE FROM Auth WHERE adminAvailable = ? AND authCode = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			if (target.equals("student")) {
				pstmt.setBoolean(1, false);
			}
			else if (target.equals("manager")) {
				pstmt.setBoolean(1, true);
			}
			pstmt.setString(2, deleteTarget(target, offset));
			return pstmt.executeUpdate(); // 인증코드 삭제 성공
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
}