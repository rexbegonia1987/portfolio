package com.portfolio.Command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.portfolio.Dao.DaoBoard;


public class BoardListCmd implements Command {

	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String,Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String sMember = request.getParameter("Member");
		String sRowCount = request.getParameter("RowCount");
		System.out.println("BoardListCmd execute :: Member : " + sMember + " & RowCount : " + sRowCount);
		DaoBoard dao = new DaoBoard();
		model.addAttribute("request",dao.DBList(sMember, sRowCount));
		model.addAttribute("FullRow",dao.DBList(sMember));
		model.addAttribute("NowPage",sRowCount);
		
	}

}
