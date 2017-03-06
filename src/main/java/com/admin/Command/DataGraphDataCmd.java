package com.admin.Command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.admin.Dao.DaoGraph;

public class DataGraphDataCmd implements Command {

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String sId = request.getParameter("ID");
		String sWay = request.getParameter("Way");
		String sTarget = request.getParameter("Target");
		String sSD = request.getParameter("SD");
		String sED = request.getParameter("ED");
		DaoGraph daoGraph = new DaoGraph();
		System.out.println(sSD + " :: " + sED);
		model.addAttribute("request", daoGraph.DaoGraph(sId,sWay,sTarget,sSD,sED));
		

	}

}
