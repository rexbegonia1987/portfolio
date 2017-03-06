package com.admin.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.json.simple.JSONObject;

public class DaoLogin {

	DataSource dataSource;
	public DaoLogin() {
		// TODO Auto-generated constructor stub
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/admin");
		
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public JSONObject Dao(String sId, String sPw) {
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
			sQuery = "SELECT MemberName FROM Penshion.Member WHERE MemberID = '" + sId +"' AND Password ='"+sPw +"';";
			pst = con.prepareStatement(sQuery);
			rs = pst.executeQuery();
			while(rs.next()){
				sGetMemberName = rs.getString("MemberName");
			}
			if(sGetMemberName != null){
				pst = null;
				rs = null;
				sQuery = "";
				Date dToday = new Date();
				SimpleDateFormat SDF = new SimpleDateFormat("yyy-MM-dd");
				String sToday = SDF.format(dToday);
				sQuery = "UPDATE Penshion.ReservationText SET SkipDate = 0 WHERE ReservationAddress ='"+sId+"' AND SelectDate < '"+sToday +"';" ;
				pst = con.prepareStatement(sQuery);
				rs = pst.executeQuery();
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
		     if ( rs != null ) try{rs.close();}catch(Exception e){} 
		     if ( pst != null ) try{pst.close();}catch(Exception e){}
		     if ( con != null ) try{con.close();}catch(Exception e){}

		}
		obj.put("MemberName", sGetMemberName);
		obj.put("ID", sId);
		
		return obj;
	}

}
