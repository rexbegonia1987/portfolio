package com.portfolio.Command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.portfolio.Dao.DaoDirection;

public class MapCmd implements Command {

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String sMember = request.getParameter("Member");
		DaoDirection daoDirection = new DaoDirection();
		model.addAttribute("request", daoDirection.DaoDirection(sMember));
		
	}

}
