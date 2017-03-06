package com.portfolio.Command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.portfolio.Dao.DaoReserv;

public class ReservDecideCmd implements Command {

	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String, Object> map = model.asMap();
		HttpServletRequest request= (HttpServletRequest) map.get("request");
		String sMember = request.getParameter("Member");
		String date = request.getParameter("Date");
		String sRoom = request.getParameter("Room");
		String sPeopleNum = request.getParameter("PeopleNum");
		String sReservater = request.getParameter("Reservater");
		String sPhoneNumber = request.getParameter("PhoneNumber");
		String sPw = request.getParameter("Pw");
		String sBill = request.getParameter("Bill");
		String sPay = request.getParameter("Pay");
		String sText = request.getParameter("Text");
		String sBarbecue = request.getParameter("Barbecue");
		Boolean bBarbecue = false;
		if(sBarbecue.equals("1")){
			bBarbecue =true;
		}
		String sGrill = request.getParameter("Grill");
		Boolean bGrill = false;
		if(sGrill.equals("1")){
			bGrill =true;
		}
		
		DaoReserv daoReserv = new DaoReserv();
		model.addAttribute("request",daoReserv.DaoReserv(sMember, date, sRoom, Integer.parseInt(sPeopleNum), sReservater, sPhoneNumber, sPw, Integer.parseInt(sBill), sPay, sText, bBarbecue,bGrill));

	}

}
