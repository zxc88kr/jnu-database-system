package returned;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ReturnedDAO {
	private Connection conn;
	private ResultSet rs;
	
	public ReturnedDAO() {
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
		String SQL = "INSERT INTO Rent VALUES (?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, userID);
			pstmt.setInt(3, productID);
			pstmt.setString(4, productName);
			pstmt.setDate(5, getDate());
			pstmt.setDate(6, new Date(getDate().getTime() + 1000 * 60 * 60 * 24 * 7));
			pstmt.setInt(7, productDeposit);
			pstmt.executeUpdate();
			return rentUpdate(productID); // 물품 대여 성공
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public ArrayList<Returned> getList(int pageNumber, Boolean adminAvailable, String userID) {
		String SQL = "SELECT * FROM Rent WHERE userID = ? ORDER BY rentID DESC LIMIT 10 OFFSET ?";
		if (adminAvailable) {
			SQL = "SELECT * FROM Rent ORDER BY rentID DESC LIMIT 10 OFFSET ?";
		}
		ArrayList<Returned> list = new ArrayList<Returned>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setInt(2, (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Returned rent = new Returned();
				rent.setRentID(rs.getInt(1));
				rent.setUserID(rs.getString(2));
				rent.setProductID(rs.getInt(3));
				rent.setProductName(rs.getString(4));
				rent.setRentDate(rs.getDate(5));
				rent.setRentExpr(rs.getDate(6));
				rent.setProductDeposit(rs.getInt(7));
				list.add(rent);
			}
			return list; // 대여목록 가져오기 성공
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // 데이터베이스 오류
	}
	
	public boolean isExistPage(int pageNumber, Boolean adminAvailable, String userID) {
		String SQL = "SELECT * FROM Rent WHERE userID = ? LIMIT 10 OFFSET ?";
		if (adminAvailable) {
			SQL = "SELECT * FROM Rent LIMIT 10 OFFSET ?";
		}
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setInt(2, (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true; // 페이지 존재
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false; // 데이터베이스 오류
	}
}