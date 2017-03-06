package com.portfolio.Command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.portfolio.Dao.DaoReserv;

public class ReservRoomDataCmd implements Command {

	@Override
	public void execute(Model model) {
		Map<String,Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String sMember = request.getParameter("Member");
		String sRoom = request.getParameter("Room");
		String sSelecteDate = request.getParameter("SelectDate");
		DaoReserv daoReserv = new DaoReserv();
		model.addAttribute("request",daoReserv.DaoReserv(sMember,sRoom,sSelecteDate));
		


	}

}
