package com.admin.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.admin.Dto.DtoImplicaion;

public class DaoImplication {
	
	
	DataSource dataSource;
	public DaoImplication() {
		// TODO Auto-generated constructor stub
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/admin");
		
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public JSONObject DaoImplication(String sMemberId){
		JSONObject obj = new JSONObject();
		System.out.println("Login");
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		String sQuery=null;
		String sGetMemberName = null;
		
		try {
			con = dataSource.getConnection();
			System.out.println("DataSource Connection!");
			sQuery = "SELECT MemberName FROM Penshion.Member WHERE MemberID = '" + sMemberId +"';";
			pst = con.prepareStatement(sQuery);
			rs = pst.executeQuery();
			Calendar Cal = Calendar.getInstance();
			Date dToday = new Date();
			SimpleDateFormat SDF = new SimpleDateFormat("yyyy-MM-dd");
			String sToday = SDF.format(dToday);
			String[] saTodaySet = sToday.split("-");
			sQuery = "SELECT DepositSet, DepositCheck, CancelCheck FROM Penshion.ReservationText WHERE ReservationAddress = '"+ sMemberId + "' AND SelectDate >= '" +sToday +"';";
			pst = con.prepareStatement(sQuery);
			rs = pst.executeQuery();
			JSONArray jaDepositSet = new JSONArray();
			JSONArray jaDepositCheck = new JSONArray();
			JSONArray jaCancelCheck = new JSONArray();
			while(rs.next()){
				jaDepositSet.add(rs.getBoolean("DepositSet"));
				jaDepositCheck.add(rs.getBoolean("DepositCheck"));
				jaCancelCheck.add(rs.getBoolean("CancelCheck"));
			}
			
			JSONArray jaReservData = new JSONArray();
			//String[] saReservData;
			obj.put("DepositSet",jaDepositSet);
			obj.put("DepositCheck",jaDepositCheck);
			obj.put("CancelCheck",jaCancelCheck);
			
			pst = null;
			rs = null;
			sQuery = "SELECT ReservRoom, DepositCheck, Reservater,AmountPeople, ReservNumber, ReservPhone,Barbecue, Grill FROM Penshion.ReservationText WHERE ReservationAddress ='"+sMemberId+"' AND SelectDate = '"+sToday + "' AND CancelCheck = 0 ORDER BY ReservRoom ASC";
			pst = con.prepareStatement(sQuery);
			rs = pst.executeQuery();
			JSONArray jaTodayReservRoom = new JSONArray();
			JSONArray jaTodayDepositCheck = new JSONArray();
			JSONArray jaReservater = new JSONArray();
			JSONArray jaReservPhone = new JSONArray();
			JSONArray jaReservNumber = new JSONArray();
			JSONArray jaAmountPeople = new JSONArray();
			JSONArray jaBarbecue = new JSONArray();
			JSONArray jaGrill = new JSONArray();
			while(rs.next()){
				jaTodayReservRoom.add(rs.getString("ReservRoom"));
				jaReservater.add(rs.getString("Reservater"));
				jaReservNumber.add(rs.getInt("ReservNumber"));
				jaAmountPeople.add(rs.getInt("AmountPeople"));
				jaReservPhone.add(rs.getString("ReservPhone"));
				jaTodayDepositCheck.add(rs.getBoolean("DepositCheck"));
				jaBarbecue.add(rs.getBoolean("Barbecue"));
				jaGrill.add(rs.getBoolean("Grill"));
			}
			obj.put("TodayRoom",jaTodayReservRoom);
			obj.put("Reservater",jaReservater);
			obj.put("ReservNumber",jaReservNumber);
			obj.put("ReservPhone",jaReservPhone);
			obj.put("TodayDepositCheck",jaTodayDepositCheck);
			obj.put("AmountPeople",jaAmountPeople);
			obj.put("Barbecue",jaBarbecue);
			obj.put("Grill",jaGrill);
			
			pst = null;
			rs = null;
			sQuery = "SELECT count(DepositSet) AS CountDeposit FROM Penshion.ReservationText WHERE ReservationAddress ='"+sMemberId+"' AND DepositCheck = 0 AND DepositSet = 0 AND SelectDate >= '" +sToday +"';";
			pst = con.prepareStatement(sQuery);
			rs = pst.executeQuery();
			Integer iCountDeposit = 0;
			while(rs.next()){
				iCountDeposit = rs.getInt("CountDeposit");
			}
			obj.put("DepositCount",iCountDeposit);
			pst = null;
			rs = null;
			sQuery = "SELECT count(CancelCheck) AS CountCancelCheck FROM Penshion.ReservationText WHERE ReservationAddress ='"+sMemberId+"' AND CancelCheck = 1  AND SelectDate >= '" +sToday+"';";
			pst = con.prepareStatement(sQuery);
			rs = pst.executeQuery();
			Integer iCountCancel = 0;
			while(rs.next()){
				iCountCancel = rs.getInt("CountCancelCheck");
			}
			obj.put("CancelCheckCount",iCountCancel);
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
		     if ( rs != null ) try{rs.close();}catch(Exception e){} 
		     if ( pst != null ) try{pst.close();}catch(Exception e){}
		     if ( con != null ) try{con.close();}catch(Exception e){}

		}
		
		return obj;
		
	}

}
