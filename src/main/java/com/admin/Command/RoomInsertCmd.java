package com.admin.Command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.admin.Dao.DaoRoomManege;

public class RoomInsertCmd implements Command {

	@Override
	public void execute(Model model) {
		System.out.println("RoomName Execute");
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String sId = request.getParameter("ID");
		String sRoomName = request.getParameter("RoomName");
		String[] sData = request.getParameterValues("Data");
		String sType = request.getParameter("Type");
		String sLength = request.getParameter("Length");
		DaoRoomManege daoRoomManege = new DaoRoomManege();
		model.addAttribute("request", daoRoomManege.DaoRoomManege(sId,sRoomName,sData,sType,sLength));

	}

}
