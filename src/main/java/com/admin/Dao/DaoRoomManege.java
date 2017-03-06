package com.admin.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.admin.Dto.DtoReserv;
import com.admin.Dto.DtoRoomManege;

public class DaoRoomManege {
	
	DataSource dataSource;
	public DaoRoomManege() {
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/admin");
		
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public ArrayList<DtoRoomManege> DaoRoomManege(String sId){
		System.out.println("DaoReserv CancelData");
		 ArrayList<DtoRoomManege> ALdtoRoomManege = new ArrayList<DtoRoomManege>();
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		String sQuery = null;
		
		
		try {
			con = dataSource.getConnection();
			sQuery = "Select RoomName From Penshion.RoomInfo WHERE MemberId = '"+ sId+"' ORDER By RoomName ASC;";
			pst = con.prepareStatement(sQuery);
			rs = pst.executeQuery();
			while(rs.next()){
				DtoRoomManege dto = new DtoRoomManege(rs.getString("RoomName"));
				ALdtoRoomManege.add(dto);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
		     if ( rs != null ) try{rs.close();}catch(Exception e){} 
		     if ( pst != null ) try{pst.close();}catch(Exception e){}
		     if ( con != null ) try{con.close();}catch(Exception e){}

		}
		return ALdtoRoomManege;
	}
	
	public JSONArray DaoRoomManege(String sId , String sRoomName){
		JSONArray jaResultData = new JSONArray();
		System.out.println("DaoRoomManege RoomModify");
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		String sQuery = null;
		try {
			con = dataSource.getConnection();
			String sColumn = "RoomName,NumOfPerson,MaxOfPerson,NDailyBill,NFridayBill,NSaturdayBill,NSundayBill,SDailyBill,SFridayBill,SSaturdayBill,SSundayBill,PDailyBill,PFridayBill,PSaturdayBill,PSundayBill,ACT";
			String[] aColumn = sColumn.split(",");
			sQuery = "Select "+sColumn+" From Penshion.RoomInfo WHERE MemberId = '"+ sId+"' AND RoomName = '"+sRoomName+"';";
			pst = con.prepareStatement(sQuery);
			rs = pst.executeQuery();
			while(rs.next()){
				String Temp="";
				for(int i = 0 ; i < aColumn.length;i++){
					Temp = aColumn[i] +"&" +rs.getString(aColumn[i]);
					jaResultData.add(Temp);	
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
		return jaResultData;
	}
	@SuppressWarnings("unchecked")
	public JSONObject DaoRoomManege(String sId, String sRoomName, String[] sData, String sType, String sLength) {
		System.out.println("DaoRoomManege RoomModify");
		Integer iLength = Integer.parseInt(sLength);
		String[] saColumn = new String[iLength];
		String[] saData = new String[iLength];
		JSONObject ResultObject = new JSONObject();
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		String sQuery = "";
		try {
			con = dataSource.getConnection();

			String sColumn = "";
			String sQueryData ="";
			String[] Temp = new String[2];
			for (int i = 0 ; i < iLength ; i++){
				Temp = sData[i].split("&");
				saColumn[i] = Temp[0];
				saData[i] = Temp[1];
				sColumn += saColumn[i]+",";
				sQueryData += "'"+ saData[i]+"',";
			}
			Date dToday = new Date();
			SimpleDateFormat SDF = new SimpleDateFormat("yyyy-MM-dd");
			String sToday = SDF.format(dToday);
			sColumn +="AddBill,MemberId,CreateDate,RoomName";
			sQueryData +="'10000','"+sId +"','"+sToday +"','"+sRoomName+"'";
			if(sType.equals("ADD")){
				sQuery += "INSERT INTO Penshion.RoomInfo (" +sColumn +")values ("+sQueryData+");";
				
			}else if(sType.equals("Modify")){
				sQuery +="UPDATE RoomInfo SET ";
				for(int j = 0 ; j < iLength ; j++){
						sQuery += saColumn[j] +"='"+ saData[j]+"', ";
				}
				sQuery+="ModifiDate ='"+sToday+"' ";
				sQuery +="WHERE RoomName ='"+ sRoomName + "';";
			}			
			pst = con.prepareStatement(sQuery);
			rs = pst.executeQuery();
			ResultObject.put("Result", "Success");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
		     if ( rs != null ) try{rs.close();}catch(Exception e){} 
		     if ( pst != null ) try{pst.close();}catch(Exception e){}
		     if ( con != null ) try{con.close();}catch(Exception e){}

		}
		
		return ResultObject;
	}

}
