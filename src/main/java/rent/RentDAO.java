package rent;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class RentDAO {
	private Connection conn;
	private ResultSet rs;
	
	public RentDAO() {
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
	
	public Date getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getDate(1); // 질의 성공
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // 데이터베이스 오류
	}
	
	public int getNext() {
		String SQL = "SELECT rentID FROM Rent ORDER BY rentID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1; // 질의 성공
			}
			return 1; // 첫 번째 물품
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int rentUpdate(int productID) {
		String SQL = "UPDATE Product SET productCount = productCount - 1 WHERE productID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, productID);
			return pstmt.executeUpdate(); // 물품 수량 업데이트 성공
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int rent(String userID, int productID, String productName, int productDeposit) {
		String SQL = "INSERT INTO Rent VALUES (?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, userID);
			pstmt.setString(3, productName);
			pstmt.setDate(4, getDate());
			pstmt.setDate(5, new Date(getDate().getTime() + 1000 * 60 * 60 * 24 * 7));
			pstmt.setInt(6, productDeposit);
			pstmt.executeUpdate();
			return rentUpdate(productID); // 물품 대여 성공
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
}