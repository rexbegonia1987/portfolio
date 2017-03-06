package com.admin.Command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.admin.Dao.DaoReserv;
import com.admin.Dao.DaoRoomManege;

public class DepositSetCmd implements Command {

	@Override
	public void execute(Model model) {
		System.out.println("DepositSet Execute");
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String sId = request.getParameter("ID");
		String sSelectDate = request.getParameter("SelectDate");
		String sReservNumber = request.getParameter("ReservNumber");
		DaoReserv daoReserv = new DaoReserv();
		model.addAttribute("request", daoReserv.Dao(sId, sSelectDate,sReservNumber));

	}

}
