package com.portfolio.Command;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.portfolio.Dao.DaoBoard;
import com.portfolio.Dto.DtoBoard;

public class ModifyDataCmd implements Command {

	@Override
	public void execute(Model model) {
		Map<String,Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String sMember = request.getParameter("Member");
		String sNo = request.getParameter("No");
		String sPw = request.getParameter("Pw");
		int iNo = Integer.parseInt(sNo);
		System.out.println("BoardReadCmd :: No : " + sNo);
		DaoBoard dao = new DaoBoard();
		model.addAttribute("request", dao.DBBoardModify(sMember, iNo,sPw));
		model.addAttribute("Result", true);
		
	}

}
