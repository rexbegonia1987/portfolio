package com.portfolio.Dto;

public class DtoReserv {
	int MOP;
	int NOP;
	String Act;
	
	int Barbecue;
	int Grill;
	int Bill;
	int AddBill;
	
	String Member;
	String date;
	String Room;
	int PeopleNum;
	String Reservater;
	String PhoneNumber;
	String Pw;
	String Pay;
	String Text;
	Boolean bBarbecue;
	Boolean bGrill;
	
	Boolean Result;
	
	
	public DtoReserv() {
		// TODO Auto-generated constructor stub
	}
	public DtoReserv(String Pw, Boolean Result){
		this.Pw = Pw;
		this.Result = Result;
	}
	public DtoReserv(String Member, String date, String Room, int PeopleNum, String Reservater, String PhoneNumber, String Pw, int Bill, String Pay, String Text, Boolean bBarbecue, Boolean bGrill){
		this.Member = Member;
		this.date = date;
		this.Room = Room;
		this.PeopleNum = PeopleNum;
		this.Reservater = Reservater;
		this.PhoneNumber = PhoneNumber;
		this.Pw = Pw;
		this.Bill = Bill;
		this.Pay = Pay;
		this.Text = Text;
		this.bBarbecue = bBarbecue;
		this.bGrill =bGrill;
		
		
		
	}
	
	public DtoReserv(int Barbecue, int Grill, int Bill, int AddBill){
		
		this.Barbecue = Barbecue;
		this.Grill = Grill;
		this.Bill = Bill;
		this.AddBill = AddBill;
		
	}
	public DtoReserv(int MOP, int NOP,String Act){
		this.MOP = MOP;
		this.NOP = NOP;
		this.Act = Act;
	}
	
	public int getMOP() {
		return MOP;
	}
	public void setMOP(int mOP) {
		MOP = mOP;
	}
	public int getNOP() {
		return NOP;
	}
	public void setNOP(int nOP) {
		NOP = nOP;
	}

	public String getAct() {
		return Act;
	}

	public void setAct(String act) {
		Act = act;
	}

	
	public int getBill() {
		return Bill;
	}
	public void setBill(int bill) {
		Bill = bill;
	}
	public int getAddBill() {
		return AddBill;
	}
	public void setAddBill(int addBill) {
		AddBill = addBill;
	}
	public int getBarbecue() {
		return Barbecue;
	}

	public void setBarbecue(int barbecue) {
		Barbecue = barbecue;
	}

	public int getGrill() {
		return Grill;
	}

	public void setGrill(int grill) {
		Grill = grill;
	}
	public String getMember() {
		return Member;
	}
	public void setMember(String member) {
		Member = member;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getRoom() {
		return Room;
	}
	public void setRoom(String room) {
		Room = room;
	}
	public int getPeopleNum() {
		return PeopleNum;
	}
	public void setPeopleNum(int peopleNum) {
		PeopleNum = peopleNum;
	}
	public String getReservater() {
		return Reservater;
	}
	public void setReservater(String reservater) {
		Reservater = reservater;
	}
	public String getPhoneNumber() {
		return PhoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		PhoneNumber = phoneNumber;
	}
	public String getPw() {
		return Pw;
	}
	public void setPw(String pw) {
		Pw = pw;
	}
	public String getPay() {
		return Pay;
	}
	public void setPay(String pay) {
		Pay = pay;
	}
	public String getText() {
		return Text;
	}
	public void setText(String text) {
		Text = text;
	}
	public Boolean getbBarbecue() {
		return bBarbecue;
	}
	public void setbBarbecue(Boolean bBarbecue) {
		this.bBarbecue = bBarbecue;
	}
	public Boolean getbGrill() {
		return bGrill;
	}
	public void setbGrill(Boolean bGrill) {
		this.bGrill = bGrill;
	}
	public Boolean getResult() {
		return Result;
	}
	public void setResult(Boolean result) {
		Result = result;
	}
	
	
}
