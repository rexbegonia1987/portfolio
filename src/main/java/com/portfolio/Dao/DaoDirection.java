package com.portfolio.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.json.simple.JSONObject;

public class DaoDirection {
DataSource dataSource;
	
	public DaoDirection() {
		// TODO Auto-generated constructor stub
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/admin");
		
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@SuppressWarnings("unchecked")
	public JSONObject DaoDirection(String sMember){
		System.out.println("DaoReserv ReservCancelData");
		JSONObject obj = new JSONObject();
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		String sQuery = null;
		Boolean bResult = true;
		
		try {
			con = dataSource.getConnection();
			sQuery = "SELECT Address FROM Penshion.Member WHERE MemberID ='"+sMember+"';";
			pst = con.prepareStatement(sQuery);
			rs = pst.executeQuery();
			while(rs.next()){
				obj.put("Result", rs.getString("Address"));
					
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return obj;
		
	}

}
