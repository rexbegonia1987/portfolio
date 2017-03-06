package com.portfolio.penshion.utl;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateTurm {
	public String DateTurm(String sDate){
		Calendar Cal = Calendar.getInstance();
		Date dToday = new Date();
		Date dTurm = new Date();
		SimpleDateFormat SDF = new SimpleDateFormat("yyyy-MM-dd");
		String sToday ="";
		String sTurm ="";
		String[] sSetDate = sDate.split(":");
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
		return sTurm;
	}

}
