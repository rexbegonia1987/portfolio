package com.portfolio.Dao;

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

import org.json.simple.JSONObject;

import com.portfolio.Dto.DtoBoard;
import com.portfolio.penshion.utl.JsonParser;

public class DaoBoard {
	DataSource dataSource;
	
	
	public DaoBoard() {
		// TODO Auto-generated constructor stub
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/admin");
		
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public ArrayList<DtoBoard> DBList(String Member , String RC){
		ArrayList<DtoBoard> ALboard = new ArrayList<DtoBoard>();

		System.out.println("DBListLoad");
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		String sQuery=null;
		int iGetRowCount = Integer.parseInt(RC)*10;
		try {
			con = dataSource.getConnection();
			System.out.println("DataSource Connection!");
			sQuery = "SELECT No,Title,CreateDate,ViewLock FROM Penshion.Board WHERE Link is NULL AND MemberAddress='"+ Member+"' ORDER BY No DESC limit "+iGetRowCount +",10;";
			pst = con.prepareStatement(sQuery);
			rs = pst.executeQuery();
			SimpleDateFormat SMD = new SimpleDateFormat("yyyy-MM-dd");
			while(rs.next()){
				DtoBoard dtoBoard = new DtoBoard(rs.getInt("No"),rs.getString("Title"),SMD.format(rs.getDate("CreateDate")),rs.getBoolean("ViewLock"));
				ALboard.add(dtoBoard);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
		     if ( rs != null ) try{rs.close();}catch(Exception e){} 
		     if ( pst != null ) try{pst.close();}catch(Exception e){}
		     if ( con != null ) try{con.close();}catch(Exception e){}

		}

		return ALboard;
	}
	public int DBList(String Member){
		System.out.println("DBListLoad(FullRow)");
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		String sQuery=null;
		int iGetFullRow = 0;
		try {
			con = dataSource.getConnection();
			System.out.println("DataSource Connection!");
			sQuery = "SELECT COUNT(No) FROM Penshion.Board WHERE Link is Null"; 
			pst = con.prepareStatement(sQuery);
			rs = pst.executeQuery();
			while(rs.next()){
				iGetFullRow = rs.getInt("COUNT(No)");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
		     if ( rs != null ) try{rs.close();}catch(Exception e){} 
		     if ( pst != null ) try{pst.close();}catch(Exception e){}
		     if ( con != null ) try{con.close();}catch(Exception e){}

		}

		
		return iGetFullRow;
	}
	public Boolean DBList(String Member, int No, String Pw){
		System.out.println("DBListLoad(LockCheck)");
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		String sQuery=null;
		Boolean sResult = false;
		try {
			con = dataSource.getConnection();
			System.out.println("DataSource Connection!");
			sQuery = "	SELECT No FROM Penshion.Board WHERE MemberAddress = '"+ Member+"' AND No = "+No+" AND Pw = '"+Pw +"';"; 
			pst = con.prepareStatement(sQuery);
			rs = pst.executeQuery();
			while(rs.next()){
				sResult = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
		     if ( rs != null ) try{rs.close();}catch(Exception e){} 
		     if ( pst != null ) try{pst.close();}catch(Exception e){}
		     if ( con != null ) try{con.close();}catch(Exception e){}

		}
		
		
		return sResult;
	}
	public ArrayList<DtoBoard> DBBoardRead(String Member, int No){
		ArrayList<DtoBoard> ALRead = new ArrayList<DtoBoard>();
		System.out.println("DBBoardRead");
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		String sQuery=null;
		
		try {
			con = dataSource.getConnection();
			System.out.println("DataSource Connection!");
			sQuery = "SELECT No, Title,Content, CreateDate,ViewLock,Reply FROM Penshion.Board WHERE MemberAddress = '"+ Member+"' AND No = "+No+";"; 
			pst = con.prepareStatement(sQuery);
			rs = pst.executeQuery();
			SimpleDateFormat SMD = new SimpleDateFormat("yyyy-MM-dd");
			while(rs.next()){
				DtoBoard dtoReadBoard = new DtoBoard(rs.getInt("No"), rs.getString("Title"),rs.getString("Content"),SMD.format(rs.getDate("CreateDate")),rs.getBoolean("ViewLock"),rs.getBoolean("Reply"));
				ALRead.add(dtoReadBoard);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
		     if ( rs != null ) try{rs.close();}catch(Exception e){} 
		     if ( pst != null ) try{pst.close();}catch(Exception e){}
		     if ( con != null ) try{con.close();}catch(Exception e){}

		}
		return ALRead;
	}
	public ArrayList<DtoBoard> DBReContent(int No){
		ArrayList<DtoBoard> ALRecontent = new ArrayList<DtoBoard>();
		System.out.println("DBBoardRead");
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		String sQuery=null;
			
		try {
			con = dataSource.getConnection();
			System.out.println("DataSource Connection!");
			sQuery = "SELECT Content, CreateDate From Penshion.Board WHERE Link = " +No +";"; 
			pst = con.prepareStatement(sQuery);
			rs = pst.executeQuery();
			SimpleDateFormat SMD = new SimpleDateFormat("yyyy-MM-dd");
			while(rs.next()){
				DtoBoard dtoReadBoard = new DtoBoard(rs.getString("Content"),SMD.format(rs.getDate("CreateDate")));
				ALRecontent.add(dtoReadBoard);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
		     if ( rs != null ) try{rs.close();}catch(Exception e){} 
		     if ( pst != null ) try{pst.close();}catch(Exception e){}
		     if ( con != null ) try{con.close();}catch(Exception e){}

		}
		
		return ALRecontent;
	}
	public String DBInsert(String sMember, String sTitle, String sContent, String sPw, Boolean sViewLock) {
		System.out.println("DBInsert(Insert)");
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		String sQuery=null;
		Date dToday = new Date();
		SimpleDateFormat SMD = new SimpleDateFormat("yyyy-MM-dd");
		String sToday = SMD.format(dToday);
		try {
			con = dataSource.getConnection();
			System.out.println("DataSource Connection!");
			sQuery = "INSERT INTO Board (MemberAddress, Title, Content, CreateDate, Pw, ViewLock) values('" + sMember+"', '"+ sTitle +"' , '"+ sContent+ "', '"+ sToday+"' ,'"+sPw+"' ,"+sViewLock+");"; 
			pst = con.prepareStatement(sQuery);
			rs = pst.executeQuery();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			 if ( rs != null ) try{rs.close();}catch(Exception e){} 
		     if ( pst != null ) try{pst.close();}catch(Exception e){}
		     if ( con != null ) try{con.close();}catch(Exception e){}

		}
		
		return "Page/Board";
		
	}
	public String DBInsert(String sNo, String sMember, String sTitle, String sContent, String sPw, Boolean sViewLock) {
		
		System.out.println("DBInsert(Modify)");
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		String sQuery=null;
		Date dToday = new Date();
		SimpleDateFormat SMD = new SimpleDateFormat("yyyy-MM-dd");
		String sToday = SMD.format(dToday);
		try {
			con = dataSource.getConnection();
			System.out.println("DataSource Connection!");
			sQuery = "UPDATE Penshion.Board SET Pw = '"+sPw+"', Title = '"+sTitle+"' ,Content = '"+ sContent+"' ,ModifyDate = '"+ sToday+"', ViewLock = " + sViewLock+ " WHERE MemberAddress='"+ sMember+"' AND No = "+ sNo+";"; 
			System.out.println(sQuery);
			pst = con.prepareStatement(sQuery);
			rs = pst.executeQuery();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			 if ( rs != null ) try{rs.close();}catch(Exception e){} 
		     if ( pst != null ) try{pst.close();}catch(Exception e){}
		     if ( con != null ) try{con.close();}catch(Exception e){}

		}
		
		
		return "Page/Board";
	}
	public ArrayList<DtoBoard> DBBoardModify(String sMember, int iNo, String sPw) {
		ArrayList<DtoBoard> ALRead = new ArrayList<DtoBoard>();
		System.out.println("DBBoardRead");
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		String sQuery=null;
		
		try {
			con = dataSource.getConnection();
			System.out.println("DataSource Connection!");
			sQuery = "SELECT No, Title,Content, CreateDate,ViewLock,Reply FROM Penshion.Board WHERE MemberAddress = '"+ sMember+"' AND No = "+iNo+" AND Pw ='"+sPw+"';"; 
			pst = con.prepareStatement(sQuery);
			rs = pst.executeQuery();
			SimpleDateFormat SMD = new SimpleDateFormat("yyyy-MM-dd");
			while(rs.next()){
				DtoBoard dtoReadBoard = new DtoBoard(rs.getInt("No"), rs.getString("Title"),rs.getString("Content"),SMD.format(rs.getDate("CreateDate")),rs.getBoolean("ViewLock"),rs.getBoolean("Reply"));
				ALRead.add(dtoReadBoard);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
		     if ( rs != null ) try{rs.close();}catch(Exception e){} 
		     if ( pst != null ) try{pst.close();}catch(Exception e){}
		     if ( con != null ) try{con.close();}catch(Exception e){}

		}

		return ALRead;
		
	}
	
}
