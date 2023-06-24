package product;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ProductDAO {
	private Connection conn;
	private ResultSet rs;
	
	public ProductDAO() {
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
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1); // 질의 성공
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // 데이터베이스 오류
	}
	
	public int getNext() {
		String SQL = "SELECT productID FROM Product ORDER BY productID DESC";
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
	
	public int write(String productName, int productCount, int productDeposit) {
		String SQL = "INSERT INTO Product VALUES (?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, productName);
			pstmt.setInt(3, productCount);
			pstmt.setInt(4, productDeposit);
			pstmt.setBoolean(5, true);
			return pstmt.executeUpdate(); // 물품 추가 성공
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public ArrayList<Product> getList(int pageNumber, Boolean adminAvailable) {
		String SQL = "SELECT * FROM Product WHERE rentAvailable = true ORDER BY productID DESC LIMIT 10 OFFSET ?";
		if (adminAvailable) {
			SQL = "SELECT * FROM Product ORDER BY productID DESC LIMIT 10 OFFSET ?";
		}
		ArrayList<Product> list = new ArrayList<Product>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Product product = new Product();
				product.setProductID(rs.getInt(1));
				product.setProductName(rs.getString(2));
				product.setProductCount(rs.getInt(3));
				product.setProductDeposit(rs.getInt(4));
				product.setRentAvailable(rs.getBoolean(5));
				list.add(product);
			}
			return list; // 물품목록 가져오기 성공
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // 데이터베이스 오류
	}
	
	public boolean isExistPage(int pageNumber, Boolean adminAvailable) {
		String SQL = "SELECT * FROM Product WHERE rentAvailable = true LIMIT 10 OFFSET ?";
		if (adminAvailable) {
			SQL = "SELECT * FROM Product LIMIT 10 OFFSET ?";
		}
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true; // 페이지 존재
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false; // 데이터베이스 오류
	}
	
	public Product getProduct(int productID) {
		String SQL = "SELECT * FROM Product WHERE productID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, productID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Product product = new Product();
				product.setProductID(rs.getInt(1));
				product.setProductName(rs.getString(2));
				product.setProductCount(rs.getInt(3));
				product.setProductDeposit(rs.getInt(4));
				product.setRentAvailable(rs.getBoolean(5));
				return product; // 물품 가져오기 성공
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // 데이터베이스 오류
	}
	
	public int update(int productID, String productName, int productCount, int productDeposit, Boolean rentAvailable) {
		String SQL = "UPDATE Product SET productName = ?, productCount = ?, productDeposit = ?, rentAvailable = ? WHERE productID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, productName);
			pstmt.setInt(2, productCount);
			pstmt.setInt(3, productDeposit);
			pstmt.setBoolean(4, rentAvailable);
			pstmt.setInt(5, productID);
			return pstmt.executeUpdate(); // 물품 수정 성공
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int delete(int productID) {
		String SQL = "DELETE FROM Product WHERE productID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, productID);
			return pstmt.executeUpdate(); // 물품 삭제 성공
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
}