package rent;

import java.sql.Date;

public class Rent {
	private int rentID;
	private String userID;
	private String productName;
	private Date rentDate;
	private Date rentExpr;
	private int productDeposit;
	
	public int getRentID() {
		return rentID;
	}
	public void setRentID(int rentID) {
		this.rentID = rentID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public Date getRentDate() {
		return rentDate;
	}
	public void setRentDate(Date rentDate) {
		this.rentDate = rentDate;
	}
	public Date getRentExpr() {
		return rentExpr;
	}
	public void setRentExpr(Date rentExpr) {
		this.rentExpr = rentExpr;
	}
	public int getProductDeposit() {
		return productDeposit;
	}
	public void setProductDeposit(int productDeposit) {
		this.productDeposit = productDeposit;
	}
}