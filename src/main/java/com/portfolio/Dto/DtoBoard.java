package com.portfolio.Dto;


public class DtoBoard {
	private int No;
	private String Title;
	private String Content;
	private String CreateDate;
	private Boolean ViewLock;
	private Boolean Reply;
	
	
	public DtoBoard() {
		// TODO Auto-generated constructor stub
	}
	
	public DtoBoard(int No, String Title, String CreateDate, Boolean ViewLock){
		this.No = No;
		this.Title = Title;
		this.CreateDate = CreateDate;
		this.ViewLock = ViewLock;
	}
	public DtoBoard(int No, String Title,String Content,  String CreateDate, Boolean ViewLock, Boolean Reply){
		this.No = No;
		this.Title = Title;
		this.Content = Content;
		this.CreateDate = CreateDate;
		this.ViewLock = ViewLock;
		this.Reply = Reply;
	}
	public DtoBoard(String Content, String CreateDate){
		this.Content = Content;
		this.CreateDate = CreateDate;
	}
	
	public int getNo() {
		return No;
	}
	public void setNo(int no) {
		No = no;
	}
	public String getTitle() {
		return Title;
	}
	public void setTitle(String title) {
		Title = title;
	}
	public String getCreateDate() {
		return CreateDate;
	}
	
	public String getContent() {
		return Content;
	}

	public void setContent(String content) {
		Content = content;
	}

	public void setCreateDate(String createDate) {
		CreateDate = createDate;
	}
	public Boolean getViewLock() {
		return ViewLock;
	}
	public void setViewLock(Boolean viewLock) {
		ViewLock = viewLock;
	}

	public Boolean getReply() {
		return Reply;
	}

	public void setReply(Boolean reply) {
		Reply = reply;
	}
	

}
