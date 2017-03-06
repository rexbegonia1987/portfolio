package com.portfolio.penshion.utl;

public class PeakCheckSwtich {
	public PeakCheckSwtich() {
		// TODO Auto-generated constructor stub
	}
public int PeakCheckSwtich (int CheckNum){
		
		int iCheck = 0;
		switch(CheckNum){
		case 0:
			iCheck = 1;
			break;
		case 1:
			iCheck =2;
			break;
		case 2:
			iCheck = 1;
			break;
		case 3:
			iCheck =2;
			break;
		}	
		return iCheck;
	}
}
