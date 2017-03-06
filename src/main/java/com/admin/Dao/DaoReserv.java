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

import org.json.simple.JSONObject;

import com.admin.Dto.DtoReserv;

public class DaoReserv {
	DataSource dataSource;
	
	public DaoReserv() {
		// TODO Auto-generated constructor stub
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/admin");
		
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public ArrayList<DtoReserv> Dao(String sId, String sDate) {
		System.out.println("DaoReserv CancelData");
		ArrayList<DtoReserv> ALdtoReserv = new ArrayList<DtoReserv>();
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		String[] sSetDate = sDate.split(":");
		Calendar Cal = Calendar.getInstance();
		Date dToday = new Date();
		Date dTurm = new Date();
		SimpleDateFormat SDF = new SimpleDateFormat("yyyy-MM-dd");
		String sToday ="";
		String sTurm ="";
		if(sSetDate.length ==1){
			sToday= sDate;//SDF.format(dToday);
			String[] saTodaySet = sToday.split("-");
			Cal.set(Integer.parseInt(saTodaySet[0]),Integer.parseInt(saTodaySet[1])-1,Integer.parseInt(saTodaySet[2]));
			//Integer iThisWeek = Cal.get(Cal.WEEK_OF_MONTH);
			dToday.setTime(Cal.getTimeInMillis());
			dTurm.setTime(dToday.getTime()+(24*60*60*1000)*7);
			sTurm = SDF.format(dTurm);
		}else{
			sToday = sSetDate[0];
			sTurm = sSetDate[1];
		}
		String sQuery = "SELECT Reservater,ReservNumber,Text,SelectDate,ReservPhone,AmountPeople,Pay,ReservRoom,DepositWay,DepositCheck,DepositSet,CancelCheck,ReservDate,Barbecue,Grill FROM Penshion.ReservationText WHERE ReservationAddress = '" + sId +"' AND SelectDate >='"+sToday + "' AND SelectDate <'" + sTurm +"' ORDER BY SelectDate ASC";
		try {
			con = dataSource.getConnection();
			pst = con.prepareStatement(sQuery);
			rs = pst.executeQuery();
			while(rs.next()){
				DtoReserv dto = new DtoReserv(rs.getString("Reservater"),rs.getString("ReservNumber"),rs.getString("ReservRoom"),rs.getInt("AmountPeople"),SDF.format(rs.getDate("SelectDate")),rs.getString("ReservPhone"),rs.getInt("Pay"),rs.getBoolean("Grill"),rs.getBoolean("Barbecue"),rs.getString("DepositWay"),rs.getBoolean("DepositCheck"),rs.getBoolean("DepositSet"),rs.getBoolean("CancelCheck"),SDF.format(rs.getDate("ReservDate")),rs.getString("Text"));
				ALdtoReserv.add(dto);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
		     if ( rs != null ) try{rs.close();}catch(Exception e){} 
		     if ( pst != null ) try{pst.close();}catch(Exception e){}
		     if ( con != null ) try{con.close();}catch(Exception e){}

		}
		return ALdtoReserv;
	}

	public JSONObject Dao(String sId, String sSelectDate, String sReservNumber) {
		System.out.println("DaoReserv DepositSet");
		JSONObject obj = new JSONObject();
		Connection con = null;
		PreparedStatement pst = null;
		String sQuery = "UPDATE ReservationText SET DepositSet = 1 , DepositCheck = 1 WHERE ReservationAddress = '" +sId+"' AND SelectDate ='" + sSelectDate + "' AND ReservNumber = "+ sReservNumber+";" ;
		ResultSet rs = null;
		
		try {
			con = dataSource.getConnection();
			pst = con.prepareStatement(sQuery);
			rs = pst.executeQuery();
			obj.put("Success", "Success");

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
