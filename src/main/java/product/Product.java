package product;

public class Product {
	private int productID;
	private String productName;
	private int productCount;
	private int productDeposit;
	private Boolean rentAvailable;
	
	public int getProductID() {
		return productID;
	}
	public void setProductID(int productID) {
		this.productID = productID;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public int getProductCount() {
		return productCount;
	}
	public void setProductCount(int productCount) {
		this.productCount = productCount;
	}
	public int getProductDeposit() {
		return productDeposit;
	}
	public void setProductDeposit(int productDeposit) {
		this.productDeposit = productDeposit;
	}
	public Boolean getRentAvailable() {
		return rentAvailable;
	}
	public void setRentAvailable(Boolean rentAvailable) {
		this.rentAvailable = rentAvailable;
	}
}