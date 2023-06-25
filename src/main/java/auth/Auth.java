package auth;

public class Auth {
	private String authCode;
	private Boolean adminAvailable;
	
	public String getAuthCode() {
		return authCode;
	}
	public void setAuthCode(String authCode) {
		this.authCode = authCode;
	}
	public Boolean getAdminAvailable() {
		return adminAvailable;
	}
	public void setAdminAvailable(Boolean adminAvailable) {
		this.adminAvailable = adminAvailable;
	}
}