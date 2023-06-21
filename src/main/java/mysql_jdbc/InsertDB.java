package mysql_jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class InsertDB {
	public void insert(String id, String name, int age, double grade) {
		Connection conn = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String url = "jdbc:mysql://localhost/chan";
			String user = "root";
			String password = "1234";
			conn = DriverManager.getConnection(url, user, password);
			System.out.println("연결 성공");
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 로딩 실패");
		} catch (SQLException e) {
			System.out.println("에러: " + e);
		}
		
		String sql = "INSERT INTO Students (id, name, age, grade) VALUES (?, ?, ?, ?)";
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, name);
			ps.setInt(3, age);
			ps.setDouble(4, grade);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		int count;
		try {
			count = ps.executeUpdate();
			if (count > 0) {
				System.out.println("추가 성공");
			} else {
				System.out.println("추가 실패");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				ps.close();
				conn.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}
}