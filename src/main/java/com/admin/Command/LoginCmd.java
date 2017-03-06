package com.admin.Command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.admin.Dao.DaoLogin;

public class LoginCmd implements Command {

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String sId = request.getParameter("ID");
		String sPw = request.getParameter("Pw");
		DaoLogin Login = new DaoLogin();
		model.addAttribute("request",Login.Dao(sId,sPw));

	}

}
