package com.admin.Command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.admin.Dao.DaoBoard;


public class BoardInsertCmd implements Command {

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String sMember = request.getParameter("Member");
		String sNo = request.getParameter("No");
		String sData = request.getParameter("Data");
		System.out.println(sMember + "  && " + sNo + " :: " + sData);
		DaoBoard daoBoard = new DaoBoard();
		model.addAttribute("request",daoBoard.DBInsert(sMember,sNo,sData));
		daoBoard.DBReply(sMember,sNo);

	}

}
