package com.admin.Dto;

public class DtoReserv {
	String Reservater;
	String ReservNumber;
	String ReservRoom;
	int AmountPeople;
	String SelectDate;
	String ReservPhone;
	int Pay;
	Boolean Grill;
	Boolean Barbecue;
	String DepositWay;
	Boolean DepositCheck;
	Boolean DepositSet;
	Boolean CancelCheck;
	String ReservDate;
	String Text;
	
	public DtoReserv() {
		// TODO Auto-generated constructor stub
	}
	public DtoReserv(String Reservater,	String ReservNumber,String ReservRoom,int AmountPeople,String SelectDate,String ReservPhone,int Pay,Boolean Grill,Boolean Barbecue,String DepositWay,Boolean DepositCheck,Boolean DepositSet,Boolean CancelCheck,String ReservDate,String Text ){
		this.Reservater = Reservater;
		this.ReservNumber = ReservNumber;
		this.ReservRoom = ReservRoom;
		this.AmountPeople = AmountPeople;
		this.SelectDate = SelectDate;
		this.ReservPhone = ReservPhone;
		this.Pay = Pay;
		this.Grill = Grill;
		this.Barbecue = Barbecue;
		this.DepositWay = DepositWay;
		this.DepositCheck = DepositCheck;
		this.DepositSet = DepositSet;
		this.CancelCheck = CancelCheck;
		this.ReservDate = ReservDate;
		this.Text = Text;
		
	}
	
	
	public String getReservater() {
		return Reservater;
	}
	public void setReservater(String reservater) {
		Reservater = reservater;
	}
	public String getReservNumber() {
		return ReservNumber;
	}
	public void setReservNumber(String reservNumber) {
		ReservNumber = reservNumber;
	}
	public String getReservRoom() {
		return ReservRoom;
	}
	public void setReservRoom(String reservRoom) {
		ReservRoom = reservRoom;
	}
	public int getAmountPeople() {
		return AmountPeople;
	}
	public void setAmountPeople(int amountPeople) {
		AmountPeople = amountPeople;
	}
	public String getSelectDate() {
		return SelectDate;
	}
	public void setSelectDate(String selectDate) {
		SelectDate = selectDate;
	}
	public String getReservPhone() {
		return ReservPhone;
	}
	public void setReservPhone(String reservPhone) {
		ReservPhone = reservPhone;
	}
	public int getPay() {
		return Pay;
	}
	public void setPay(int pay) {
		Pay = pay;
	}
	public Boolean getGrill() {
		return Grill;
	}
	public void setGrill(Boolean grill) {
		Grill = grill;
	}
	public Boolean getBarbecue() {
		return Barbecue;
	}
	public void setBarbecue(Boolean barbecue) {
		Barbecue = barbecue;
	}
	public String getDepositWay() {
		return DepositWay;
	}
	public void setDepositWay(String depositWay) {
		DepositWay = depositWay;
	}
	public Boolean getDepositCheck() {
		return DepositCheck;
	}
	public void setDepositCheck(Boolean depositCheck) {
		DepositCheck = depositCheck;
	}
	public Boolean getDepositSet() {
		return DepositSet;
	}
	public void setDepositSet(Boolean depositSet) {
		DepositSet = depositSet;
	}
	public Boolean getCancelCheck() {
		return CancelCheck;
	}
	public void setCancelCheck(Boolean cancelCheck) {
		CancelCheck = cancelCheck;
	}
	public String getReservDate() {
		return ReservDate;
	}
	public void setReservDate(String reservDate) {
		ReservDate = reservDate;
	}
	public String getText() {
		return Text;
	}
	public void setText(String text) {
		Text = text;
	}
	
	

}
