package com.portfolio.Command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.portfolio.Dao.DaoReserv;

public class ReservRoomMDataCmd implements Command {

	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String sMember = request.getParameter("Member");
		String sRoom = request.getParameter("Room");
		DaoReserv daoReserv = new DaoReserv();
		model.addAttribute("request", daoReserv.DaoReserv(sMember, sRoom));

	}

}
