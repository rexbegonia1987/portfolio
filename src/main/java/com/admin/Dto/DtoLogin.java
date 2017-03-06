package com.admin.Dto;

public class DtoLogin {

	private String MemberName;
	private String ID;
	
	public DtoLogin() {
		// TODO Auto-generated constructor stub
	}
	public DtoLogin(String MemberName, String ID) {
		this.MemberName = MemberName;
		this.ID = ID;
	}
	
	public String getMemberName() {
		return MemberName;
	}
	public void setMemberName(String memberName) {
		MemberName = memberName;
	}
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
		ID = iD;
	}
	
	
}
