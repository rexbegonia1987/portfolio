package com.admin.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.json.simple.JSONArray;

import com.admin.Dto.DtoReserv;

public class DaoGraph {

	DataSource dataSource;
	public DaoGraph() {
		// TODO Auto-generated constructor stub
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/admin");
		
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public JSONArray DaoGraph(String sId, String sWay, String sTarget, String sSD, String sED) {
		JSONArray jaResult = new JSONArray();
		System.out.println("DaoGraph DataGraphData");
		ArrayList<DtoReserv> ALdtoReserv = new ArrayList<DtoReserv>();
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		String sQuery = "";
		Calendar cStartDate = Calendar.getInstance();
		Calendar cEndDate = Calendar.getInstance();
		Calendar cSelectDate = Calendar.getInstance();
		String[] saTempSD = sSD.split("-");
		String[] saTempED = sED.split("-");
		cStartDate.set(Integer.parseInt(saTempSD[0]),Integer.parseInt(saTempSD[1])-1,Integer.parseInt(saTempSD[2]));
		cEndDate.set(Integer.parseInt(saTempED[0]),Integer.parseInt(saTempED[1])-1,Integer.parseInt(saTempED[2]));
		Integer iDateTerm = (int)((cEndDate.getTimeInMillis() - cStartDate.getTimeInMillis())/(24*60*60*1000) + 1);
		cSelectDate.set(Integer.parseInt(saTempSD[0]),Integer.parseInt(saTempSD[1])-1,Integer.parseInt(saTempSD[2]));
		String sSelectDate = String.valueOf(cSelectDate.get(Calendar.YEAR))+"-"+NumStr(cSelectDate.get(Calendar.MONTH)+1)+"-"+NumStr(cSelectDate.get(Calendar.DATE));
		Integer iSumTemp = 0;
		
		try {
			con = dataSource.getConnection();
			if(sWay.equals("Pay")){
				for(int i = 0 ; i < iDateTerm ; i++){
					sQuery = "SELECT Pay FROM ReservationText WHERE ReservationAddress ='"+sId+"' AND SelectDate = '"+sSelectDate+"';";
					pst = con.prepareStatement(sQuery);
					rs = pst.executeQuery();
					while(rs.next()){
						iSumTemp += rs.getInt("Pay");
					}
					JSONArray InputTemp = new JSONArray();
					if(sTarget.equals("Week")){
						InputTemp.add(FindDay(cSelectDate.get(Calendar.DAY_OF_WEEK)));
					}else{
						InputTemp.add(sSelectDate);
					}
					InputTemp.add(iSumTemp);
					jaResult.add(InputTemp);
					iSumTemp=0;
					cSelectDate.add(Calendar.DATE, 1);
					sSelectDate = String.valueOf(cSelectDate.get(Calendar.YEAR))+"-"+NumStr(cSelectDate.get(Calendar.MONTH)+1)+"-"+NumStr(cSelectDate.get(Calendar.DATE));
				}
			}else{
				for(int i = 0 ; i < iDateTerm ; i++){
					sQuery = "SELECT COUNT(No) AS Reserv FROM ReservationText WHERE ReservationAddress ='"+sId+"' AND SelectDate = '"+sSelectDate+"';";
					pst = con.prepareStatement(sQuery);
					rs = pst.executeQuery();
					JSONArray InputTemp = new JSONArray();
					while(rs.next()){
						if(sTarget.equals("Week")){
							InputTemp.add(FindDay(cSelectDate.get(Calendar.DAY_OF_WEEK)));
						}else{
							InputTemp.add(sSelectDate);
						}
						InputTemp.add(rs.getInt("Reserv"));
					}
					jaResult.add(InputTemp);
					cSelectDate.add(Calendar.DATE, 1);
					sSelectDate = String.valueOf(cSelectDate.get(Calendar.YEAR))+"-"+NumStr(cSelectDate.get(Calendar.MONTH)+1)+"-"+NumStr(cSelectDate.get(Calendar.DATE));
				}
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
		     if ( rs != null ) try{rs.close();}catch(Exception e){} 
		     if ( pst != null ) try{pst.close();}catch(Exception e){}
		     if ( con != null ) try{con.close();}catch(Exception e){}

		}

		
		
		return jaResult;
	}
		private String NumStr( int x){
			int CheckNumber = x;
			String Result;
			if(CheckNumber <10){
				Result = "0"+CheckNumber;
			}else{
				Result = ""+CheckNumber;
			}
			
			return Result;
		}
		private String FindDay( int x ){
			int CheckNumber = x;
			String Result ="";
			switch(CheckNumber){
			   case 1 :
			      	Result = "일";
			      break;
			   case 2 :
					Result = "월";
			      break;
			   case 3 :
					Result = "화";
			      break;
			   case 4 :
					Result = "수";
			      break;
			   case 5 :
					Result = "목";
			      break;
			   case 6 :
					Result = "금";
			      break;
			   case 7 :
					Result = "토";
			      break;
			   }
			
			return Result;
		}
	
}
