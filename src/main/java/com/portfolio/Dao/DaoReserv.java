package com.portfolio.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.portfolio.Dto.DtoReserv;
import com.portfolio.penshion.utl.PeakCheckSwtich;

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
	@SuppressWarnings("unchecked")
	public JSONObject DaoReserv(String sMember, int iyear, int imonth) {
		JSONObject CalendarObject = new JSONObject();
		// TODO Auto-generated constructor stub
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		String sQuery = "Select RoomsNames FROM Penshion.Member WHERE MemberID ='" +sMember+"';";
	
		try {
			con = dataSource.getConnection();
			pst= con.prepareStatement(sQuery);
			rs = pst.executeQuery();
			
			String sTempRoomsName = "";
			while(rs.next()){
				sTempRoomsName = rs.getString("RoomsNames");	
			}
			
			Integer iYear = iyear;
			Integer iMonth = imonth;

			Calendar Fast = Calendar.getInstance();
			Calendar Now = Calendar.getInstance();
			Calendar After = Calendar.getInstance();
			
			int FastLastDate =0; //전달 마지막 일
			int FastLastDay;  //전달 마지막 요일
			int NowFristDay;  //이번달 첫날 요일
			int NowLastDate;  // 이번날 마지막 일
			int AfterFristDay;//다음달 첫날 요일
			int NowCountOfWeek;//이번달 주 수
			
			Integer iSetFastDateYear = 0;
			Integer iSetFastDateMonth = 0;
			Integer iSetFastDateDate = 0;
			
			Integer iSetAfterDateYear = 0;
			Integer iSetAfterDateMonth = 0;
			Integer iSetAfterDateDate = 0;		
			
			Now.set(iYear,iMonth,1); //이번달 1일로 설정
			NowFristDay = Now.get(Calendar.DAY_OF_WEEK)-1; //이번달 1일의 요일찾기
			NowLastDate = Now.getActualMaximum(Calendar.DAY_OF_MONTH); //이번달 마지막날 찾기
			Now.set(iYear,iMonth,NowLastDate); //이번달 마지막날로 설정
			NowCountOfWeek = Now.get(Calendar.WEEK_OF_MONTH); //이번달 총 주 수 찾기
			

			if(iMonth !=0){ //요청달이 1월이 아닐때
				Fast.set(iYear,iMonth-1,1);//지난달 월 셋
				FastLastDate = Fast.getActualMaximum(Calendar.DAY_OF_MONTH); // 마지막날 찾기
				Fast.set(iYear, iMonth-1,FastLastDate);//마지막날로 설정
				iSetFastDateYear = iYear; 
				iSetFastDateMonth = iMonth;
			}else{			//요청달이 1월일때
				Fast.set(iYear-1, 11,1); //전년도 12월로 설정
				FastLastDate = Fast.getActualMaximum(Calendar.DAY_OF_MONTH); //마지막날 찾기
				Fast.set(iYear-1, 11,FastLastDate); //마지막날로 설정
				iSetFastDateYear = iYear-1;
				iSetFastDateMonth = 12;
			}


			FastLastDay = NowFristDay-1; //전달 마지막날의 요일 찾기 (달력의 첫줄에 전달의 내용 출력용)
			if(NowFristDay !=0){
				iSetFastDateDate = FastLastDate - FastLastDay;	
			}else{
				iSetFastDateDate = FastLastDate;
			}
				


			if(iMonth !=11){ //요청달이 12월이 아닐때
				After.set(iYear, iMonth+1,1);//다음달 첫날로 이동
				iSetAfterDateYear = iYear;
				iSetAfterDateMonth = iMonth+2;
			}else{			 //요청달이 12월일때
				After.set(iYear+1,0,1); //다음달 첫날로 이동
				iSetAfterDateYear = iYear+1;
				
			}
			AfterFristDay = After.get(Calendar.DAY_OF_WEEK)-1;
			JSONArray TempSet = new JSONArray(); //화면에 띄울 데이터 입력
			
			if(NowFristDay != 0){ //선택달 시작이 일요일이 아닐때
				
				//iReservLastMonthDate = FastLastDate-FastLastDay - 1;
			
				for (int i = FastLastDay ; i >=0 ; i--){//전달의 내용 입력
					TempSet.add( FastLastDate - i);//이전달 내용만 출력
				}
				
				int TempDate=1;
				for (int i = NowFristDay ; i <= 6 ; i++){
					TempSet.add(TempDate);
					TempDate++;
				}
				for(int i = 1; i < NowCountOfWeek ; i++){
					for (int j = 0 ; j <=6 ; j++){
						if(TempDate>NowLastDate){
							break;
						}
						TempSet.add(TempDate);
						TempDate++;
					}
				}
				TempDate = 1;
				for(int i = AfterFristDay; i <=6 ; i++){
						TempSet.add(TempDate);
						TempDate++;
					
				}
				
			//	iReservAfterMonthDate = TempDate; //TempDate는 출력된 다음달 마지막날보다 1이 추가된 상태이다
				iSetAfterDateDate = TempDate;
			
			}else{//선택달 시작이 일요일일 때
				int TempDate=1;
				int TempDay=0;
				//iReservLastMonthDate = null;
				for(int i = 0; i <= NowCountOfWeek ; i++){ //해달 달의 주 수만큼 반복
					for (int j = 0 ; j <=6 ; j++){
						if(TempDate>NowLastDate){//해달 달 입력이 다 되었을때 구문 탈출
							TempDay = j;
							break;
						}else{
							TempSet.add(TempDate);
							TempDate++;	
						}			
					}
				}
				TempDate = 1;
				for(int k = TempDay ; k <=6 ; k++){//다음달 내용 입력
					TempSet.add(TempDate);
					TempDate++;	
				}
				//iReservAfterMonthDate = TempDate;
				iSetAfterDateDate = TempDate;
			}
			String sReservLastMonthDate = iSetFastDateYear + "-" + iSetFastDateMonth + "-" + iSetFastDateDate;
			String sResrevAfterMonthDate =iSetAfterDateYear + "-" + iSetAfterDateMonth + "-" + iSetAfterDateDate;
			
			sQuery = "Select Reservater, SelectDate,StayDate,ReservRoom,DepositSet From ReservationText	WHERE SelectDate >= '"+sReservLastMonthDate+"' AND SelectDate <='"+sResrevAfterMonthDate+"' 	Order BY SelectDate asc;";
			rs = pst.executeQuery(sQuery);
			Integer iRoomsNum = 0;
			Integer iDBLine =0; 
					/*if(rs.getRow() !=0){
						iDBLine = rs.getRow();
					}*/
			rs.last();
			iDBLine = rs.getRow();
			rs.beforeFirst();
			Integer iDataSet = 0;
			JSONArray jaSendData = new JSONArray();
			String TempSendData ="";
			while(rs.next()){
				TempSendData += rs.getString("SelectDate")+ ":";
				TempSendData += rs.getString("StayDate")+ ":";
				TempSendData += rs.getString("ReservRoom")+ ":";
				TempSendData += rs.getString("DepositSet");
				//sTempRoomsName = rs.getString("RoomsNames");
				jaSendData.add(TempSendData);
				TempSendData = "";
				iDataSet++;
				
			}
			CalendarObject.put("WeekOfDate", NowCountOfWeek );
			CalendarObject.put("Data", TempSet);
			//CalendarObject.put("RoomsNum", iRoomsNum);
			CalendarObject.put("RoomsName", sTempRoomsName);
			CalendarObject.put("ReservData", jaSendData);
			CalendarObject.put("ReservDataLine", iDBLine);

			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
		     if ( rs != null ) try{rs.close();}catch(Exception e){} 
		     if ( pst != null ) try{pst.close();}catch(Exception e){}
		     if ( con != null ) try{con.close();}catch(Exception e){}

		}
		
		return CalendarObject;
	}
	
	public ArrayList<DtoReserv> DaoReserv(String sMember, String sRoom) {
		// TODO Auto-generated method stub
		System.out.println("ReservRoomMdata Dao");
		ArrayList<DtoReserv> dtoReserv = new ArrayList<DtoReserv>();
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		String sQuery = null;
		
		try {
			con = dataSource.getConnection();
			sQuery = "Select NumOfPerson,MaxOfPerson,Act FROM Penshion.RoomInfo WHERE MemberId = '" + sMember+"' AND RoomName ='" + sRoom + "';" ;
			pst= con.prepareStatement(sQuery);
			rs = pst.executeQuery();
			Integer iNOP = 0, iMOP = 0;
			String sAct ="";
			
			while(rs.next()){
				
				DtoReserv dto = new DtoReserv(rs.getInt("MaxOfPerson"),rs.getInt("NumOfPerson"),rs.getString("Act"));
				dtoReserv.add(dto);
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
		     if ( rs != null ) try{rs.close();}catch(Exception e){} 
		     if ( pst != null ) try{pst.close();}catch(Exception e){}
		     if ( con != null ) try{con.close();}catch(Exception e){}

		}

		return dtoReserv;
	}
	public ArrayList<DtoReserv> DaoReserv(String sMember, String sRoom, String sSelecteDate) {
		System.out.println("ReservRoomData Dao");
		ArrayList<DtoReserv> dtoReserv = new ArrayList<DtoReserv>();
		PeakCheckSwtich pck = new PeakCheckSwtich();
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		String sQuery = null;
		String[] sChangeDate = new String[3];
		Integer[] iCheckDate = new Integer[3];
		Integer iPeakCheck = 0;
		Integer iWeekCheck = 0;
		Integer iGrill = 0;
		Integer iBarbecue = 0;
		Integer iAddBill = 0;
		Integer iBill = 0;
		sChangeDate = sSelecteDate.split("-");
		
		for(int i = 0 ; i < 3 ; i++){
			iCheckDate[i] = Integer.parseInt(sChangeDate[i]);	
		}
		
		Calendar Select = Calendar.getInstance();
		Calendar Cal = Calendar.getInstance();
		Select.set(iCheckDate[0], iCheckDate[1]-1, iCheckDate[2]);
		iWeekCheck = Select.get(Select.DAY_OF_WEEK_IN_MONTH);
		
		try {
			con = dataSource.getConnection();
			sQuery = "Select Grill, Barbecue, SSamePeak, SPeak,WSamePeak, WPeak FROM Penshion.Member WHERE MemberID = '" + sMember+"' ;" ;
			pst = con.prepareStatement(sQuery);
			rs = pst.executeQuery();

			String sSSamePeak ="", sSPeak ="",sWSamePeak ="",sWPeak ="";
			String[][] sGetData = new String[4][2]; 
			while(rs.next()){
				sSSamePeak = rs.getString("SSamePeak");
				sSPeak = rs.getString("SPeak");
				sWSamePeak = rs.getString("WSamePeak");
				sWPeak = rs.getString("WPeak");
				iBarbecue = rs.getInt("Barbecue");
				iGrill = rs.getInt("Grill");
				
			}
			sGetData[0] = sSSamePeak.split(":");
			sGetData[1] = sSPeak.split(":");
			sGetData[2] = sWSamePeak.split(":");
			sGetData[3] = sWPeak.split(":");
			
			String[] sTempCheckS = new String[2];
			String[] sTempCheckE = new String[2];
			String sTempWeekCheck = "";
			for(int i = 0 ; i < 4 ; i++){
				sTempCheckS = sGetData[i][0].split("&");
				sTempCheckE = sGetData[i][1].split("&");
				if(sTempCheckS[0].replace("M","").equals(sTempCheckE[0].replace("M",""))){
					if(iCheckDate[1] == Integer.parseInt(sTempCheckS[0].replace("M",""))){
						sTempWeekCheck = sTempCheckS[1].replace("W","");
						if(sTempWeekCheck.equals("F")){
							
							sTempWeekCheck = "0";
							
						}else if(sTempWeekCheck.equals("L")){
							Cal.set(iCheckDate[0],Integer.parseInt(sTempCheckS[0].replace("M","")));
							sTempWeekCheck = Integer.toString(Cal.get(Cal.WEEK_OF_MONTH));
						}
						
						if(iWeekCheck >= Integer.parseInt(sTempWeekCheck)){
							iPeakCheck = pck.PeakCheckSwtich(i);
						}
							i=4;
					}
				}else{
					if(iCheckDate[1] >= Integer.parseInt(sTempCheckS[0].replace("M","")) && iCheckDate[1] <= Integer.parseInt(sTempCheckE[0].replace("M",""))){
						if(iCheckDate[1] == Integer.parseInt(sTempCheckS[0].replace("M",""))){
							sTempWeekCheck = sTempCheckS[1].replace("W","");
							if(sTempWeekCheck.equals("F")){
								sTempWeekCheck = "0";
							}else if(sTempWeekCheck.equals("L")){
								Cal.set(iCheckDate[0],Integer.parseInt(sTempCheckE[0].replace("M","")));
								sTempWeekCheck = Integer.toString(Cal.get(Cal.WEEK_OF_MONTH));
							}
							if(iWeekCheck >= Integer.parseInt(sTempWeekCheck)){
								iPeakCheck = pck.PeakCheckSwtich(i);
							}
								i=4;
							
						}else if(iCheckDate[1] == Integer.parseInt(sTempCheckE[0].replace("M",""))){
							sTempWeekCheck = sTempCheckE[1	].replace("W","");
							if(sTempWeekCheck.equals("F")){
								sTempWeekCheck = "0";
							}else if(sTempWeekCheck.equals("L")){
								Cal.set(iCheckDate[0],Integer.parseInt(sTempCheckE[0].replace("M","")));
								sTempWeekCheck = Integer.toString(Cal.get(Cal.WEEK_OF_MONTH));
							}if(iWeekCheck >= Integer.parseInt(sTempWeekCheck)){
								iPeakCheck = pck.PeakCheckSwtich(i);
							}
								i=4;
						}else{
							iPeakCheck = pck.PeakCheckSwtich(i);
							i=4;
						}

					}			
				}
				
			}
			String sSendPeak ="";
			switch(iPeakCheck){
			case 0:
				sSendPeak = "N";
				break;
			case 1:
				sSendPeak = "S";
				break;
			case 2:
				sSendPeak = "P";
				break;
			}
			
			switch(Select.get(Select.DAY_OF_WEEK)){
			case 1:
				sSendPeak +="SundayBill";
				break;
			case 6:
				sSendPeak +="FridayBill";
				break;
			case 7:
				sSendPeak +="SaturdayBill";
				
				break;
			default:
				sSendPeak += "DailyBill";
			
			}
			
			sQuery = "";
			sQuery = "Select AddBill," + sSendPeak + " as Bill FROM RoomInfo WHERE RoomName ='" + sRoom + "';";
			rs = pst.executeQuery(sQuery);
			while(rs.next()){
				iBill = rs.getInt("Bill");
				iAddBill = rs.getInt("AddBill");
			}
			DtoReserv dto = new DtoReserv(iBarbecue,iGrill,iBill,iAddBill);
			dtoReserv.add(dto);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
		     if ( rs != null ) try{rs.close();}catch(Exception e){} 
		     if ( pst != null ) try{pst.close();}catch(Exception e){}
		     if ( con != null ) try{con.close();}catch(Exception e){}

		}
		
		return dtoReserv;
	}
	
	public JSONObject DaoReserv(String Member, String date, String Room, int PeopleNum, String Reservater, String PhoneNumber, String Pw, int Bill, String Pay, String Text, Boolean bBarbecue, Boolean bGrill){
		System.out.println("DaoReserv ReservDecide");
		JSONObject obj = new JSONObject();
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		String sQuery = null;
		Boolean BReserverCheck = false;
		
		try {
			con = dataSource.getConnection();
			sQuery = "Select DepositSet FROM Penshion.ReservationText WHERE ReservRoom = '" + Room + "' AND SelectDate ='" + date +"';";
			pst = con.prepareStatement(sQuery);
			rs = pst.executeQuery();
			if(!rs.next()){
				BReserverCheck = true;
			}
			
			if(BReserverCheck){
				Random rRand = new Random();
				Integer iResevNum = 0;
				Boolean bRand = true;
				pst = null;
				
				Date dToday = new Date();
				Date dSelectDay = new Date();
				Date dTomorrow = new Date();
				SimpleDateFormat SDF = new SimpleDateFormat("yyyy-MM-dd");
				SimpleDateFormat FSDF = new SimpleDateFormat("yyy-MM-dd HH:mm:ss");
				String sToday = SDF.format(dToday);
				String sReservDate = FSDF.format(dToday);
				Calendar cCal = Calendar.getInstance();
				String[] saDate = date.split("-");
				cCal.set(Integer.parseInt(saDate[0]), Integer.parseInt(saDate[1])-1, Integer.parseInt(saDate[2]));
				dSelectDay.setTime(cCal.getTimeInMillis());
				dTomorrow.setTime(dSelectDay.getTime()+(24*60*60*1000));
				String sTomorrow = SDF.format(dTomorrow);
				ResultSet rsResNum =  null;
				String rQuery = "SELECT ReservNumber FROM ReservationText WHERE SelectDate >= '" + sToday + "';";
				pst = con.prepareStatement(rQuery);
				rsResNum = pst.executeQuery();
				rsResNum.last();
				int IGetRow = rsResNum.getRow();
				Integer[] iaReservNum = new Integer[IGetRow];
				rsResNum.beforeFirst();
				int tempi = 0;
				while(rsResNum.next()){
					iaReservNum[tempi] = rsResNum.getInt("ReservNumber");
					tempi++;
					
				}
				for(int i = 0 ; i < tempi ; i++){
					
					if(bRand){
						iResevNum = Integer.parseInt(String.valueOf(rRand.nextInt(100000)));
						bRand = false; 
					}
					if(iaReservNum[i] == iResevNum || iResevNum < 9999){
						bRand = true;
						i = 0;
					}
				}
				if(BReserverCheck){
					pst = null;
					ResultSet InsertRs = null;
					String sInsertQuery = "INSERT INTO ReservationText (ReservationAddress,Reservater,ReservPhone,ReservNumber,text,SelectDate,OutDate,AmountPeople,Pay,ReservRoom,DepositWay,ReservDate,Barbecue,Grill,ReservPw) VALUES ";
					sInsertQuery += "('"+Member+"','"+ Reservater+"','"+PhoneNumber+"',"+iResevNum+",'"+ Text +"','"+date+"','"+sTomorrow+"',"+PeopleNum+","+Bill+",'"+ Room+"','"+ Pay +"','"+sReservDate +"',"+bBarbecue+","+bGrill+" , '" +Pw+"');";
					/*INSERT INTO ReservationText (ReservationAddress,Reservater,ReservNumber,text,ReservDate,OutDate,AmountPeople,Pay,ReservRoom,DepositWay) 
					VALUES ('penshion','진',35133,null,'2016-11-25','2016-11-26',2,120000 ,'201호','무통장입금');*/
					pst = con.prepareStatement(sInsertQuery);
					InsertRs = pst.executeQuery();
					obj.put("ReservNum", iResevNum);
				}
				
			}
			obj.put("Result",BReserverCheck);
			
		
		}catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
		     if ( rs != null ) try{rs.close();}catch(Exception e){} 
		     if ( pst != null ) try{pst.close();}catch(Exception e){}
		     if ( con != null ) try{con.close();}catch(Exception e){}

		}

		return obj;
	}
	
	@SuppressWarnings("unchecked")
	public JSONObject DaoReserv(int iNum , String sPw, String sMemberAddress){
		
		System.out.println("DaoReserv ReservCancelData");
		JSONObject obj = new JSONObject();
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		String sQuery = null;
		Boolean bResult = true;
		
		try {
			con = dataSource.getConnection();
			sQuery = "SELECT Reservater,ReservPhone,ReservNumber,Text,SelectDate,AmountPeople,Pay,ReservRoom,Grill,Barbecue,DepositWay,DepositCheck,DepositSet FROM Penshion.ReservationText WHERE CancelCheck = 0 AND SkipDate =1 AND ReservNumber ="+iNum+" AND ReservPw = '"+sPw+"' AND ReservationAddress = '"+sMemberAddress +"';";
			pst = con.prepareStatement(sQuery);
			rs = pst.executeQuery();
			rs.last();
			Integer iResult = rs.getRow();
			if(iResult >= 1){
				rs.beforeFirst();
				if(rs.next()){
					obj.put("Reservater",rs.getString("Reservater"));
					obj.put("ReservPhone",rs.getString("ReservPhone"));
					obj.put("ReservNumber",rs.getString("ReservNumber"));
					obj.put("Text",rs.getString("Text"));
					obj.put("SelectDate",rs.getString("SelectDate"));
					obj.put("AmountPeople",rs.getString("AmountPeople"));
					obj.put("Pay",rs.getInt("Pay"));
					obj.put("ReservRoom",rs.getString("ReservRoom"));
					obj.put("Grill",rs.getBoolean("Grill"));
					obj.put("Grill",rs.getBoolean("Barbecue"));
					obj.put("DepositWay",rs.getString("DepositWay"));
					obj.put("DepositCheck",rs.getBoolean("DepositCheck"));
					obj.put("DepositSet",rs.getBoolean("DepositSet"));
				}	
			}else{
				bResult = false;
			}
				obj.put("Result",bResult);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return obj;
	}
	public JSONObject DaoReserv(String sPw, String sMemberAddress, int iReservNum) {
		System.out.println("DaoReserv CancelData");
		JSONObject obj = new JSONObject();
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		String sQuery = null;
		Boolean bResult = true;
		
		try {
			con = dataSource.getConnection();
			sQuery = "UPDATE Penshion.ReservationText SET CancelCheck=1  WHERE ReservNumber ="+iReservNum+" AND ReservPw = '"+sPw+"' AND ReservationAddress = '"+sMemberAddress +"';";
			pst = con.prepareStatement(sQuery);
			rs = pst.executeQuery();
			
			obj.put("Result",bResult);
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return obj;
	}
	

}
