package com.portfolio.Command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.portfolio.Dao.DaoReserv;

public class CancelCmd implements Command {

	@Override
	public void execute(Model model) {
		System.out.println("CancelCmd");
		Map<String , Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String sReservNum = request.getParameter("ReservNum");
		int iReservNum = Integer.parseInt(sReservNum);
		String sPw = request.getParameter("Pw");
		String sMemberAddress = request.getParameter("MemberAddress");
		DaoReserv daoReserv = new DaoReserv();
		model.addAttribute("request", daoReserv.DaoReserv(sPw, sMemberAddress,iReservNum));

	}

}
