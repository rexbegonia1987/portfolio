package com.portfolio.Command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.portfolio.Dao.DaoBoard;

public class BoardInsertCmd implements Command {

	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String sNo = request.getParameter("ModifyNo");
		String sMember = request.getParameter("Member");
		String sTitle = request.getParameter("TextTitle");
		String sContent = request.getParameter("TheBoard");
		String sPw = request.getParameter("TextPw");
		String sViewLock = request.getParameter("TextLock");
		System.out.println("BoardInsertCmd :: Member : " + sMember + " & Title : " + sTitle + " & TheBoard : " +sContent + " & TextPw : " +  sPw + " & TextLock : "+sViewLock);
		Boolean bViewLock = false;
		if(sViewLock != null){
			bViewLock = true;
		}
		DaoBoard daoBoard = new DaoBoard();
		if(sNo == null){
			model.addAttribute(daoBoard.DBInsert(sMember,sTitle, sContent,sPw,bViewLock));
		}else{
			model.addAttribute(daoBoard.DBInsert(sNo,sMember,sTitle, sContent,sPw,bViewLock));
		}
		

	}

}
