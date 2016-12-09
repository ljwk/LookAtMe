package org.dev.lam.CCTV;

public class CCTVVO {
	private String id;
	private String cctvip;
	private String cctvname;
	private String authority;
	private int num;

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCctvip() {
		return cctvip;
	}

	public void setCctvip(String cctvip) {
		this.cctvip = cctvip;
	}

	public String getCctvname() {
		return cctvname;
	}

	public void setCctvname(String cctvname) {
		this.cctvname = cctvname;
	}

	public String getAuthority() {
		return authority;
	}

	public void setAuthority(String authority) {
		this.authority = authority;
	}

}
