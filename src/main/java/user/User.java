package user;

public class User {
	private String userID;
	private String userPassword;
	private String userName;
	private String userContact;
	private Boolean adminAvailable;
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserContact() {
		return userContact;
	}
	public void setUserContact(String userContact) {
		this.userContact = userContact;
	}
	public Boolean getAdminAvailable() {
		return adminAvailable;
	}
	public void setAdminAvailable(Boolean adminAvailable) {
		this.adminAvailable = adminAvailable;
	}
}