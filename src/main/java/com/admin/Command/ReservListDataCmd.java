package com.admin.Command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.admin.Dao.DaoLogin;
import com.admin.Dao.DaoReserv;
import com.portfolio.penshion.utl.DateTurm;

public class ReservListDataCmd implements Command {

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String sId = request.getParameter("ID");
		String sDate = request.getParameter("Date");
		DaoReserv daoReserv = new DaoReserv();
		model.addAttribute("request",daoReserv.Dao(sId,sDate));
		DateTurm dateTurm = new DateTurm();
		sDate = dateTurm.DateTurm(sDate);
		model.addAttribute("NextDate",sDate);

	}

}
