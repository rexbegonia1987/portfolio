package com.portfolio.penshion;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.portfolio.Command.Command;
import com.portfolio.Command.BoardInsertCmd;
import com.portfolio.Command.BoardListCmd;
import com.portfolio.Command.BoardLockCmd;
import com.portfolio.Command.BoardReadCmd;
import com.portfolio.Command.CancelCmd;
import com.portfolio.Command.MapCmd;
import com.portfolio.Command.ModifyDataCmd;
import com.portfolio.Command.ReservCancelDataCmd;
import com.portfolio.Command.ReservDecideCmd;
import com.portfolio.Command.ReservRoomDataCmd;
import com.portfolio.Command.ReservRoomMDataCmd;
import com.portfolio.Command.ReservationDataCmd;
import com.portfolio.penshion.utl.JsonParser;

@Controller
public class penshionController {
	public Command cmd;
	
	@RequestMapping("/Page/Board")
	public String Board(){
		System.out.println("BoardPageLoad");
		return "/Page/Board";
	}
	@RequestMapping("/Page/Introduce")
	public String Introduce(){
		System.out.println("IntroduceLoad");
		return "/Page/Introduce";
	}
	@RequestMapping("/Page/Room")
	public String Room(){
		System.out.println("RoomLoad");
		return "/Page/Room";
	}
	@RequestMapping("/Page/Direction")
	public String Direction(){
		System.out.println("DirectionLoad");
		return "/Page/Direction";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/Page/BoardList")
	@ResponseBody
	public JSONObject BoardList(HttpServletRequest request, Model model){
		System.out.println("BoardListControl");
		JSONObject obj = new JSONObject();
		model.addAttribute("request",request);
		cmd = new BoardListCmd();
		cmd.execute(model);
		JsonParser json = new JsonParser();
		obj = json.JsonParser(model);
		System.out.println(obj);
		
		return obj;
	}
	@RequestMapping("/Page/LockCheck")
	@ResponseBody
	public JSONObject LockCheck(HttpServletRequest request, Model model){
		System.out.println("LockCheck");
		JSONObject obj = new JSONObject();
		model.addAttribute("request", request);
		cmd = new BoardLockCmd();
		cmd.execute(model);
		JsonParser json = new JsonParser();
		obj = json.JsonParser(model);
		return obj;
	}
	@RequestMapping(method = RequestMethod.POST , value ="/Page/BoardRead")
	public ModelAndView BoardRead(HttpServletRequest request){
		System.out.println("BoardRead");
		ModelAndView Mv = new ModelAndView();
		String sNo = request.getParameter("No");
		String sPage = request.getParameter("Page");
		System.out.println(sPage);
		Mv.addObject("No",sNo);
		Mv.addObject("Page",sPage);
		Mv.setViewName("Page/BoardRead");
		System.out.println(Mv);
		return Mv;
	}
	@RequestMapping("/Page/BoardReadData")
	@ResponseBody
	public JSONObject BoardReadData(HttpServletRequest request, Model model){
		System.out.println("BoardRead");
		JSONObject obj = new JSONObject();
		model.addAttribute("request", request);
		cmd = new BoardReadCmd();
		cmd.execute(model);
		JsonParser json = new JsonParser();
		obj = json.JsonParser(model);
		System.out.println(obj);
		return obj;
	}
	@RequestMapping("/Page/BoardInsert")
	public ModelAndView BoardInsert(HttpServletRequest request){
		System.out.println("BoardInsert");
		ModelAndView Mv = new ModelAndView();
		String sModifyNo = request.getParameter("ModifyNo");
		String sPw = request.getParameter("ModifyPw");
		Mv.addObject("ModifyNo", sModifyNo);
		Mv.addObject("ModifyPw", sPw);
		Mv.setViewName("Page/BoardInsert");
		return Mv;
	}
	@RequestMapping(method = RequestMethod.POST , value="/Page/InsertData")
	public ModelAndView InsertData(HttpServletRequest request, Model model){
		System.out.println("InsertData");
		model.addAttribute("request",request);
		cmd = new BoardInsertCmd();
		cmd.execute(model);
		ModelAndView Mv = new ModelAndView();
		Mv.setViewName("redirect:/Page/Board");
		return Mv;
	}
	@RequestMapping(method = RequestMethod.POST, value="/Page/BoardModify")
	@ResponseBody
	public JSONObject ModifyData(HttpServletRequest request , Model model){
		System.out.println("ModifyData");
		JSONObject obj = new JSONObject();
		model.addAttribute("request",request);
		cmd = new ModifyDataCmd();
		cmd.execute(model);
		JsonParser json = new JsonParser();
		obj = json.JsonParser(model);
		System.out.println(obj);
		return obj;
	}
	@RequestMapping("/Page/Reservation")
	public String Reservation(){
		System.out.println("Reservation");
		return "Page/Reservation";
	}
	@RequestMapping(method = RequestMethod.POST , value = "/Page/ReservationData")
	@ResponseBody
	public JSONObject ReservationData(HttpServletRequest request, Model model){
		System.out.println("ReservationData");
		JSONObject obj = new JSONObject();
		model.addAttribute("request",request);
		cmd = new ReservationDataCmd();
		cmd.execute(model);
		JsonParser json = new JsonParser();
		obj = json.JsonParser(model);
		System.out.println(obj);
		return obj;
	}
	@RequestMapping(method = RequestMethod.POST , value ="/Page/ReservRoomMData")
	@ResponseBody
	public JSONObject ReservRoomMData(HttpServletRequest request, Model model){
		System.out.print("ReservRoomMData");
		JSONObject obj = new JSONObject();
		model.addAttribute("request",request);
		cmd = new ReservRoomMDataCmd();
		cmd.execute(model);
		JsonParser json = new JsonParser();
		obj = json.JsonParser(model);
		System.out.println(obj);
		return obj;
		
	}
	
	@RequestMapping(method = RequestMethod.POST , value = "/Page/ReservationDecide")
	public ModelAndView ReservationDecide(HttpServletRequest request){
		System.out.print("ReservationDecide");
		ModelAndView Mv = new ModelAndView();
		String sMember= request.getParameter("Member");
		String sAmountPeople = request.getParameter("AmountPeople");
		String sRoom = request.getParameter("SelectRoom");
		String sSelectDate = request.getParameter("SDate");
		String sNumOfPeople = request.getParameter("NumOfPeople");
		String sGrill = request.getParameter("Grill");
		String sBarbecue = request.getParameter("Barbecue");
		Mv.addObject("Member", sMember);
		Mv.addObject("AmountPeople", sAmountPeople);
		Mv.addObject("SelectRoom", sRoom);
		Mv.addObject("sDate", sSelectDate);
		Mv.addObject("NumOfPeople", sNumOfPeople);
		Mv.addObject("Grill", sGrill);
		Mv.addObject("Barbecue", sBarbecue);
		Mv.setViewName("/Page/ReservationDecide");
		
		return Mv;
	}
	@RequestMapping(method = RequestMethod.POST , value = "/Page/ReservRoomData")
	@ResponseBody
	public JSONObject ReservRoomData(HttpServletRequest request, Model model){
		System.out.print("ReservRoomData");
		JSONObject obj = new JSONObject();
		model.addAttribute("request",request);
		cmd = new ReservRoomDataCmd();
		cmd.execute(model);
		JsonParser json = new JsonParser();
		obj = json.JsonParser(model);
		System.out.println(obj);
		return obj;
	}
	@RequestMapping(method = RequestMethod.POST , value = "/Page/ReservDecide")
	@ResponseBody
	public JSONObject ReservDecide(HttpServletRequest request, Model model){
		System.out.print("ReservDecide");
		JSONObject obj = new JSONObject();
		model.addAttribute("request", request);
		cmd = new ReservDecideCmd();
		cmd.execute(model);
		JsonParser json = new JsonParser();
		obj = json.JsonParser(model);
		System.out.println(obj);
		return obj;
	}
	@RequestMapping("/Page/ReservCancel")
	public String ReservCancel(){
		System.out.print("ReservCancel");
		return "Page/ReservCancel";
	}
	@RequestMapping(method = RequestMethod.POST, value = "/Page/ReservCancelData")
	@ResponseBody
	public JSONObject ReservCancelData(HttpServletRequest request, Model model){
		System.out.println("ReservCancelData");
		JSONObject obj = new JSONObject();
		model.addAttribute("request", request);
		cmd = new ReservCancelDataCmd();
		cmd.execute(model);
		JsonParser json = new JsonParser();
		obj = json.JsonParser(model);
		System.out.println(obj);
		return obj;
	}
	@RequestMapping(method = RequestMethod.POST , value = "/Page/Cancel")
	@ResponseBody
	public JSONObject CancelData(HttpServletRequest request, Model model){
		JSONObject obj = new JSONObject();
		System.out.println("CancelData");
		model.addAttribute("request",request);
		cmd = new CancelCmd();
		cmd.execute(model);
		JsonParser json = new JsonParser();
		obj = json.JsonParser(model);
		System.out.println(obj);
		return obj;
	}
	@RequestMapping(method = RequestMethod.POST , value = "/Page/Map")
	@ResponseBody
	public JSONObject MapData(HttpServletRequest request, Model model){
		JSONObject obj = new JSONObject();
		model.addAttribute("request", request);
		cmd = new MapCmd();
		cmd.execute(model);
		JsonParser json = new JsonParser();
		obj = json.JsonParser(model);
		System.out.println(obj);
		return obj;
		
	}

}
