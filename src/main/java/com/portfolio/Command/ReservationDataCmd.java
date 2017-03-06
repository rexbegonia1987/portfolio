package com.portfolio.Command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.portfolio.Dao.DaoReserv;

public class ReservationDataCmd implements Command {

	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String sMember = request.getParameter("Member");
		String sYear = request.getParameter("Year");
		String sMonth = request.getParameter("Month");
		System.out.println("ReservationDataCmd :: Member : " +sMember + " & Year : " + sYear + " & Month : " + sMonth );
		int iYear = Integer.parseInt(sYear);
		int iMonth = Integer.parseInt(sMonth);
		DaoReserv daoReserv = new DaoReserv();
		model.addAttribute("request",daoReserv.DaoReserv(sMember,iYear,iMonth));
		
	}


	

}
