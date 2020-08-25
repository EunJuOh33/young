package com.user.bean;

public class UserBean {
	/* 필드 총 11개 */
	private String user_id;
    private String user_pw;
    private String user_name;
    private int user_birth;
	private String user_phone;
    private String user_email;
    private int user_zip;
    private String user_addr;
    private String user_gender;
    private String select_p;
    private String rcv_agree;
    
    /* 메소드 */
    // 필드 변수의 앞글자를 대문자로 바꾸어서 이름이 정해진다.
	public String getUser_id() {	// get메소드는 private 변수를 외부로 리턴한다. 
		return user_id;
	}
	public void setUser_id(String user_id) {	// set메소드는 외부에서 private 변수의 값을 변경할 수 있다.
		this.user_id = user_id;
	}
	public String getUser_pw() {
		return user_pw;
	}
	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public int getUser_birth() {
		return user_birth;
	}
	public void setUser_birth(int user_birth) {
		this.user_birth = user_birth;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public int getUser_zip() {
		return user_zip;
	}
	public void setUser_zip(int user_zip) {
		this.user_zip = user_zip;
	}
	public String getUser_addr() {
		return user_addr;
	}
	public void setUser_addr(String user_addr) {
		this.user_addr = user_addr;
	}
	public String getUser_gender() {
		return user_gender;
	}
	public void setUser_gender(String user_gender) {
		this.user_gender = user_gender;
	}
	public String getSelect_p() {
		return select_p;
	}
	public void setSelect_p(String select_p) {
		this.select_p = select_p;
	}
	public String getRcv_agree() {
		return rcv_agree;
	}
	public void setRcv_agree(String rcv_agree) {
		this.rcv_agree = rcv_agree;
	}
}
