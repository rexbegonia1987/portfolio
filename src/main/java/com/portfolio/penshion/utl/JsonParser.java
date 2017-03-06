package com.portfolio.penshion.utl;

import java.util.ArrayList;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.ui.Model;

import com.google.gson.Gson;
import com.portfolio.Dto.DtoBoard;

public class JsonParser {
	public JsonParser() {
		// TODO Auto-generated constructor stub
	}
	@SuppressWarnings("unchecked")
	public JSONObject JsonParser(Model model) {
		  Gson gson = new Gson();
		  Map<String, Object> map = model.asMap();
		  System.out.println(map);
	      String json = gson.toJson(map);
	      Object obj = JSONValue.parse(json);
	      JSONObject ojson = (JSONObject) obj;
	      System.out.println("JsonParsing Complete!");
	      return ojson;
	}
}
