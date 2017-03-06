package com.admin.Command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.admin.Dao.DaoRoomManege;

public class RoomModifyCmd implements Command {

	@Override
	public void execute(Model model) {
		System.out.println("RoomName Execute");
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String sId = request.getParameter("ID");
		String sRoomName = request.getParameter("RoomName");
		DaoRoomManege daoRoomManege = new DaoRoomManege();
		model.addAttribute("request", daoRoomManege.DaoRoomManege(sId,sRoomName));

	}

}
