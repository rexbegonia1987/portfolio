package com.admin.Command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.admin.Dao.DaoBoard;


public class BoardDataCmd implements Command {

	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String,Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String sMember = request.getParameter("MemberId");
		String sRowCount = request.getParameter("RowCount");
		String sType = request.getParameter("Type");
		System.out.println("BoardListCmd execute :: Member : " + sMember + " & RowCount : " + sRowCount);
		DaoBoard dao = new DaoBoard();
		model.addAttribute("request",dao.DBList(sMember, sType, sRowCount));
		model.addAttribute("FullRow",dao.DBList(sMember, sType));
		model.addAttribute("NowPage",sRowCount);

	}

}
