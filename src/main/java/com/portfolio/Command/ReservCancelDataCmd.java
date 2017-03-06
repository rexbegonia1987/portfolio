package com.portfolio.Command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.portfolio.Dao.DaoReserv;

public class ReservCancelDataCmd implements Command {

	@Override
	public void execute(Model model) {
		Map<String,Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String sNum = request.getParameter("ReservNum");
		int iNum = Integer.parseInt(sNum);
		String sPw = request.getParameter("Pw");
		String sMemberAddress = request.getParameter("MemberAddress");
		DaoReserv dao = new DaoReserv();
		model.addAttribute("request", dao.DaoReserv(iNum, sPw,sMemberAddress));

	}

}
