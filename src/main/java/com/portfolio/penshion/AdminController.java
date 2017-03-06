package com.portfolio.penshion;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.admin.Command.BoardDataCmd;
import com.admin.Command.BoardInsertCmd;
import com.admin.Command.Command;
import com.admin.Command.DataGraphDataCmd;
import com.admin.Command.DepositSetCmd;
import com.admin.Command.ImplicationDataCmd;
import com.admin.Command.LoginCmd;
import com.admin.Command.ReservListDataCmd;
import com.admin.Command.RoomInsertCmd;
import com.admin.Command.RoomModifyCmd;
import com.admin.Command.RoomNameCmd;
import com.admin.Command.BoardReadCmd;
import com.portfolio.penshion.utl.JsonParser;

@Controller
public class AdminController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	Command cmd;
	@RequestMapping("/Admin")
	public String Index(){
		
		return "Admin/Index";
	}
	
	@RequestMapping(method = RequestMethod.POST , value = "/Admin/Login")
	@ResponseBody
	public JSONObject Login(HttpServletRequest request, Model model){
		System.out.println("Login");
		JSONObject obj = new JSONObject();
		model.addAttribute("request", request);
		cmd = new LoginCmd();
		cmd.execute(model);
		JsonParser json = new JsonParser();
		obj = json.JsonParser(model);
		System.out.println(obj);
		return obj;
	}
	@RequestMapping(method = RequestMethod.POST , value = "/Admin/Implication")
	public ModelAndView Implication(HttpServletRequest request, Model model){
		System.out.println("Implication");
		ModelAndView Mv = new ModelAndView();
		String sMemberName = request.getParameter("MemberName");
		String sMemberId = request.getParameter("MemberId");
		model.addAttribute("MemberId",sMemberId);
		model.addAttribute("MemberName",sMemberName);
		Mv.addObject("request", model);
		Mv.setViewName( "/Admin/Implication");
		System.out.println(Mv);
		return Mv;
	}
	
	@RequestMapping(method = RequestMethod.POST , value = "/Admin/ImplicationData")
	@ResponseBody
	public JSONObject ImplicationData(HttpServletRequest request, Model model){
		JSONObject obj = new JSONObject();
		System.out.println("ImplicationData");
		model.addAttribute("request", request);
		cmd = new ImplicationDataCmd();
		cmd.execute(model);
		JsonParser json = new JsonParser();
		obj = json.JsonParser(model);
		System.out.println(obj);
		return obj;
	}
	@RequestMapping(method = RequestMethod.POST , value = "/Admin/ReservList")
	public ModelAndView ReservList(HttpServletRequest request, Model model){
		
		System.out.println("ReservList");
		ModelAndView Mv = new ModelAndView();
		String sMemberName = request.getParameter("MemberName");
		String sMemberId = request.getParameter("MemberId");
		model.addAttribute("MemberId",sMemberId);
		model.addAttribute("MemberName",sMemberName);
		Mv.addObject("request", model);
		Mv.setViewName( "/Admin/ReservList");
		System.out.println(Mv);
		return Mv;
	}
	@RequestMapping(method = RequestMethod.POST , value ="/Admin/ReservListData")
	@ResponseBody
	public JSONObject ReservListData(HttpServletRequest request, Model model){
		JSONObject obj = new JSONObject();
		System.out.println("ReservListData");
		model.addAttribute("request", request);
		cmd = new ReservListDataCmd();
		cmd.execute(model);
		JsonParser json = new JsonParser();
		obj = json.JsonParser(model);
		System.out.println(obj);
		return obj;
		
	}
	@RequestMapping(method = RequestMethod.POST , value = "/Admin/DataGraph")
	public ModelAndView DataGraph(HttpServletRequest request, Model model){
		
		System.out.println("DataGraph");
		ModelAndView Mv = new ModelAndView();
		String sMemberName = request.getParameter("MemberName");
		String sMemberId = request.getParameter("MemberId");
		model.addAttribute("MemberId",sMemberId);
		model.addAttribute("MemberName",sMemberName);
		Mv.addObject("request", model);
		Mv.setViewName( "/Admin/DataGraph");
		System.out.println(Mv);
		return Mv;
	}
	@RequestMapping(method = RequestMethod.POST , value ="/Admin/DataGraphData")
	@ResponseBody
	public JSONObject DataGraphData(HttpServletRequest request, Model model){
		JSONObject obj = new JSONObject();
		System.out.println("DataGraphData");
		model.addAttribute("request", request);
		cmd = new DataGraphDataCmd();
		cmd.execute(model);
		JsonParser json = new JsonParser();
		obj = json.JsonParser(model);
		System.out.println(obj);
		return obj;
		
	}
	@RequestMapping(method = RequestMethod.POST , value = "/Admin/Board")
	public ModelAndView Board(HttpServletRequest request, Model model){
		
		System.out.println("Board");
		ModelAndView Mv = new ModelAndView();
		String sMemberName = request.getParameter("MemberName");
		String sMemberId = request.getParameter("MemberId");
		String sReType = request.getParameter("Type");
		model.addAttribute("MemberId",sMemberId);
		model.addAttribute("MemberName",sMemberName);
		model.addAttribute("Type",sReType);
		Mv.addObject("request", model);
		Mv.setViewName( "/Admin/Board");
		System.out.println(Mv);
		return Mv;
	}
	@RequestMapping(method = RequestMethod.POST , value ="/Admin/BoardData")
	@ResponseBody
	public JSONObject BoardData(HttpServletRequest request , Model model){
		JSONObject obj = new JSONObject();
		System.out.println("BoardData");
		model.addAttribute("request", request);
		cmd = new BoardDataCmd();
		cmd.execute(model);
		JsonParser json = new JsonParser();
		obj = json.JsonParser(model);
		System.out.println(obj);
		return obj;
		
	}
	@RequestMapping(method = RequestMethod.POST , value = "/Admin/BoardRead")
	public ModelAndView BoardRead(HttpServletRequest request, Model model){
		
		System.out.println("BoardRead");
		ModelAndView Mv = new ModelAndView();
		String sMemberName = request.getParameter("MemberName");
		String sMemberId = request.getParameter("MemberId");
		String sNo = request.getParameter("No");
		String sPage = request.getParameter("Page");
		String sReType = request.getParameter("Type");
		model.addAttribute("MemberId",sMemberId);
		model.addAttribute("MemberName",sMemberName);
		model.addAttribute("Page",sPage);
		model.addAttribute("No",sNo);
		model.addAttribute("Type",sReType);
		Mv.addObject("request", model);
		Mv.setViewName( "/Admin/BoardRead");
		System.out.println(Mv);
		return Mv;
	}
	@RequestMapping(method = RequestMethod.POST , value ="/Admin/BoardReadData")
	@ResponseBody
	public JSONObject BoardReadData(HttpServletRequest request , Model model){
		JSONObject obj = new JSONObject();
		System.out.println("BoardReadData");
		model.addAttribute("request", request);
		cmd = new BoardReadCmd();
		cmd.execute(model);
		JsonParser json = new JsonParser();
		obj = json.JsonParser(model);
		System.out.println(obj);
		return obj;
		
	}
	@RequestMapping(method = RequestMethod.POST , value ="/Admin/BoardInsert")
	@ResponseBody
	public JSONObject BoardInsert(HttpServletRequest request , Model model){
		JSONObject obj = new JSONObject();
		System.out.println("BoardInsert");
		model.addAttribute("request", request);
		cmd = new BoardInsertCmd();
		cmd.execute(model);
		System.out.println(model);
		JsonParser json = new JsonParser();
		obj = json.JsonParser(model);
		System.out.println(obj);
		return obj;
		
	}
	@RequestMapping("/Admin/RoomManege")
	public ModelAndView RoomManege(HttpServletRequest request, Model model){
		ModelAndView Mv = new ModelAndView();
		String sMemberName = request.getParameter("MemberName");
		String sMemberId = request.getParameter("MemberId");
		model.addAttribute("MemberId",sMemberId);
		model.addAttribute("MemberName",sMemberName);
		Mv.addObject("request", model);
		Mv.setViewName( "/Admin/RoomManege");
		System.out.println(Mv);
		return Mv;
	}
	
	@RequestMapping(method = RequestMethod.POST , value ="/Admin/RoomName")
	@ResponseBody
	public JSONObject RoomName(HttpServletRequest request, Model model){
		JSONObject obj = new JSONObject();
		model.addAttribute("request", request);
		cmd = new RoomNameCmd();
		cmd.execute(model);
		JsonParser json = new JsonParser();
		obj = json.JsonParser(model);
		System.out.println(obj);
		return obj;
	}
	@RequestMapping(method = RequestMethod.POST , value ="/Admin/RoomModify")
	@ResponseBody
	public JSONObject RoomModify(HttpServletRequest request, Model model){
		JSONObject obj = new JSONObject();
		model.addAttribute("request", request);
		cmd = new RoomModifyCmd();
		cmd.execute(model);
		JsonParser json = new JsonParser();
		obj = json.JsonParser(model);
		System.out.println(obj);
		return obj;
	}
	@RequestMapping(method = RequestMethod.POST , value ="/Admin/RoomInsert")
	@ResponseBody
	public JSONObject RoomInsert(HttpServletRequest request, Model model){
		JSONObject obj = new JSONObject();
		model.addAttribute("request", request);
		cmd = new RoomInsertCmd();
		cmd.execute(model);
		JsonParser json = new JsonParser();
		obj = json.JsonParser(model);
		System.out.println(obj);
		return obj;
	}
	@RequestMapping(method = RequestMethod.POST , value = "/Admin/DepositSet")
	@ResponseBody
	public JSONObject DepositSet(HttpServletRequest request, Model model){
		JSONObject obj = new JSONObject();
		model.addAttribute("request", request);
		cmd = new DepositSetCmd();
		cmd.execute(model);
		JsonParser json = new JsonParser();
		obj = json.JsonParser(model);
		System.out.println(obj);
		return obj;
	}
	
	
}
