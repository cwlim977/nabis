package kr.or.ddit.insight.controller;


import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.insight.dao.InsightDAO;
import kr.or.ddit.vo.CnthxVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/insight")
public class InsightController {
	
	@Inject
	private InsightDAO insightDAO;
	
	@GetMapping("main.do")
	public String settingMain() {
		return "insight/main";
	}

	//근로유형비율을 조회하는 메서드
	@GetMapping(value = "chart.do",  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> getChartList(){
		Map<String, Object> chartMap = new HashMap<>();
		
		List<CnthxVO> laborCaseList = insightDAO.cntCaseList();
		
		chartMap.put("laborCaseList", laborCaseList);
		log.info("chartMap:{}",chartMap);
		return chartMap;
	}
	
	
	//기간 조회해서 현재 재직중인 구성원등을 조회하는 메서드
	@PostMapping(value = "memcnt.do",  produces="application/json;charset=utf-8")
	@ResponseBody
	public Map<String, String> memberCount(String selectedDate){
		HashMap<String,String> memCnt = insightDAO.memberCount(selectedDate);
		Map<String, String> memCount = new HashMap<>(); 
			
			String thisEmp = memCnt.get("THIS_EMP");
			String lastEmp = memCnt.get("LAST_EMP");
			String grwRate = memCnt.get("GRW_RATE");
		
			memCount.put("thisEmp", thisEmp);
			memCount.put("lastEmp", lastEmp);
			memCount.put("grwRate", grwRate);
			
		log.info("memCount:{}",memCount);
		
		return memCount;
	}
	
	//기간 조회해서 수습완료율 얻는 메서드
	@PostMapping(value = "prRate.do",  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> prEndRate(String prSdate, String prEdate){
		Map<String, Object> prEndRateMap = new HashMap<>();
		
		String prEndRate = insightDAO.prEndRate(prSdate, prEdate);
		
		prEndRateMap.put("prEndRate", prEndRate);
		log.info("prEndRate:{}",prEndRate);
		
		return prEndRateMap;
	}
	
	//조회기간 설정해서 퇴직률얻는 메서드
	@PostMapping(value = "outRate.do",  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> outRateRetrieve(String outDate){
		Map<String, Object> outRateMap = new HashMap<>();
		
		String outRate = insightDAO.outRateRetrieve(outDate);
		
		outRateMap.put("outRate", outRate);
		log.info("outRate:{}",outRate);
		log.info("outDate:{}",outDate);
		
		return outRateMap;
	}
	
	//구성원 성비를 조회하는 메서드
	@GetMapping(value = "sexratio.do",  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> sexRatioRetrieve(){
		Map<String, Object> sexRatioMap = insightDAO.sexRatioRetrieve();
		log.info("sexRatioMap:{}",sexRatioMap);
		
		return sexRatioMap;
	}
	
	//근속기간을 조회하는 메서드
	@GetMapping(value = "serviceyear.do",  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public LinkedHashMap<String, Integer> serviceYearRetrieve(){
//		Map<String, Integer> yearCntMap = new HashMap<>();
		LinkedHashMap<String, Integer> yearCntMap = new LinkedHashMap<>();		//순서대로 값을 꺼내기 위해서 LinkedHashMap으로 선언해서 사용
		
		Map<String, Object> serviceyearMap = new HashMap<>();
		List<HashMap<String, String>> serviceyearList = insightDAO.serviceYearRetrieve();
		Collection<String> servYearValue;
		
		//값을 담을 변수선언
		int cntOver20y=0;
		int cnt20yto2y=0;	//y
		int cnt24to12 =0;	//n
		int cnt12to6 =0;	//o
		int cntUnder6 =0;	//m
		int cntUnder1=0;
		int cntBeforeEnter = 0;
		
		//구성원 근속연수에 따라서 숫자 카운트
		for(int i=0; i < serviceyearList.size(); i++) {
			servYearValue = serviceyearList.get(i).values();
			
			if(servYearValue.toString().contains("입사예정")) {		//입사예정
				cntBeforeEnter++;
			}else if(servYearValue.toString().contains("1개월미만")) {	//1개월 미만
				cntUnder1++;
			}else if(servYearValue.toString().contains("M")) { 		//6개월 미만
				cntUnder6++;
			}else if(servYearValue.toString().contains("O")) {		//6개월~12개월
				cnt12to6++;
			}else if(servYearValue.toString().contains("N")) {		//12개월~24개월
				cnt24to12++;
			}else if(servYearValue.toString().contains("Y")) {	//2년 ~ 20년
				cnt20yto2y++;
			}else {
				cntOver20y++;										//20년 이상
			}
		};
	
		if(cntOver20y == 0) {}else { yearCntMap.put("20년 이상", cntOver20y);	};
		if(cnt20yto2y == 0) {}else { yearCntMap.put("2년 이상 20년 미만", cnt20yto2y);	};
		if(cnt24to12 == 0) {}else { yearCntMap.put("12개월 이상 24개월 미만", cnt24to12);	};
		if(cnt12to6 == 0) {}else { yearCntMap.put("6개월 이상 12개월 미만", cnt12to6);	};
		if(cntUnder6 == 0) {}else { yearCntMap.put("6개월 미만", cntUnder6);	};
		if(cntUnder1 == 0) {}else { yearCntMap.put("1개월 미만", cntUnder1);	};
		if(cntBeforeEnter == 0) {}else { yearCntMap.put("입사예정", cntBeforeEnter);	};
		
		log.info("serviceyearMap:{}",serviceyearMap);
		log.info("serviceyearList:{}",serviceyearList);
		log.info("yearCntMap:{}",yearCntMap);
		
		return yearCntMap;
	}
	
//나이를 조회하여 나이수를 반환하는 메서드
	@GetMapping(value = "ageRetrieve.do",  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public LinkedHashMap<String, Integer> ageRetrieve(){
		int memAge = 0;
		int age00 = 0;
		int age10 = 0;
		int age20 = 0;
		int age30 = 0;
		int age40 = 0;
		int age50 = 0;
		int age60 = 0;
		int age70 = 0;
		
		List<Integer> age = insightDAO.ageRetrieve();		//db에서 조회
//		Map<String, Integer> ageInfo = new HashMap<>();		//조회해서 담을 map객체 선언
		LinkedHashMap<String, Integer> ageInfo = new LinkedHashMap<>();		//조회해서 담을 map객체 선언, 순서대로 꺼낼 것이기에 linkedHashMap사용
			log.info("age {}",age);
			
		//인원의 나이에 따라서 카운트한다.
		for(int i=0; i < age.size(); i++ ) {
			memAge = age.get(i);
			
			if(memAge < 10) {age00++;}
			else if(memAge < 20) {age10++;}
			else if(memAge < 30) {age20++;}
			else if(memAge < 40) {age30++;}
			else if(memAge < 50) {age40++;}
			else if (memAge < 60) {age50++;}
			else if (memAge < 70) {age60++;}
			else if (memAge < 80) {age70++;}
			else {age00++;};
		};

		//값, 즉 카운트 된 인원수가 0인 경우는 배열에 담지 아니한다. 
		if(age00 == 0) {}else {	ageInfo.put("기타", age00);	};
		if(age10 == 0) {}else {	ageInfo.put("10대", age10);	};
		if(age20 == 0) {}else {	ageInfo.put("20대", age20);	};
		if(age30 == 0) {}else {	ageInfo.put("30대", age30);	};
		if(age40 == 0) {}else {	ageInfo.put("40대", age40);	};
		if(age50 == 0) {}else {	ageInfo.put("50대", age50);	};
		if(age60 == 0) {}else {	ageInfo.put("60대", age60);	};
		if(age70 == 0) {}else {	ageInfo.put("70대", age70);	};

		log.info("age:{}",age);
		log.info("ageInfo:{}",ageInfo);
		
		return ageInfo;
	};
	
//구성원 연봉정보 가져오기
	@GetMapping(value = "salaryretrieve.do",  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public LinkedHashMap<String, Integer> avgSalaryRetrieve(){
		int vSal = 0;	    //연봉정보인 sal을 분류하기 위해서 임시로 담아두려 선언한 변수
		int sal0 = 0;		//1000만원 이하
		int sal1 = 0;	    //1000만원
		int sal2 = 0;       //2000만원
		int sal3 = 0;       //3000만원
		int sal4 = 0;       //4000만원
		int sal5 = 0;       //5000만원
		int sal6 = 0;       //6000만원
		int sal7 = 0;       //7000만원
		int sal8 = 0;       //8000만원
		int sal9 = 0;       //9000만원
		int sal10 = 0;      //10000만원
		int othersal = 0;	//기타금액
			
		List<Integer> sal = insightDAO.avgSalaryRetrieve();		//db에서 조회
				
		LinkedHashMap<String, Integer> salInfo = new LinkedHashMap<>();		//조회해서 담을 map객체 선언, 순서대로 꺼낼 것이기에 linkedHashMap사용
			log.info("sal {}",sal);
			
		//연봉에 따라서 카운트한다.
		for(int i=0; i < sal.size(); i++ ) {
			vSal = sal.get(i);
			
			if(vSal < 10000000) {sal0++;}
			else if(vSal < 20000000) {sal1++;}
			else if(vSal < 30000000) {sal2++;}
			else if(vSal < 40000000) {sal3++;}
			else if(vSal < 50000000) {sal4++;}
			else if (vSal < 60000000) {sal5++;}
			else if (vSal < 70000000) {sal6++;}
			else if (vSal < 80000000) {sal7++;}
			else if (vSal < 90000000) {sal8++;}
			else if (vSal < 100000000) {sal9++;}
			else if (vSal < 110000000) {sal10++;}
			else {othersal++;};
		};
		
		salInfo.put("1000만원 이하", sal0);	
		salInfo.put("1000 만원대", sal1);	
		salInfo.put("2000  만원대", sal2);	
		salInfo.put("3000  만원대", sal3);	
		salInfo.put("4000  만원대", sal4);	
		salInfo.put("5000  만원대", sal5);	
		salInfo.put("6000  만원대", sal6);	
		salInfo.put("7000  만원대", sal7);	
		salInfo.put("8000  만원대", sal8);	
		salInfo.put("9000  만원대", sal9);	
		salInfo.put("1억원 대 ", sal10);	
		salInfo.put("기타", othersal);	

		log.info("salInfo:{}",salInfo);
		
		return salInfo;
	};
	
	//일자별 평균 근무시간, 최대 근무시간, 최소근무시간을 조회하는 메서드
	@GetMapping(value = "worktimeaverage.do",  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public LinkedHashMap<String, List<Object>> workTimeRetrieve(){
		Map<String, String> workTimeMap = new HashMap<>();							//for문에서 맵을 하나씩 담아두기 위한 변수
		LinkedHashMap<String, List<Object>> workchartMap = new LinkedHashMap<>();	//순서대로 값을 꺼내기 위해서 LinkedHashMap으로 선언해서 사용
		
		List<HashMap<String, String>> workTimeList = insightDAO.workTimeRetrieve();	//db에서 값을 꺼내옴
		
		//값을 담을 변수선언
		List<Object> waDate = new ArrayList<>(); 
		List<Object> wkAvg = new ArrayList<>(); 
		List<Object> minTime = new ArrayList<>(); 
		List<Object> maxTime = new ArrayList<>(); 
		
		for(int i=0; i < workTimeList.size(); i++) {
			workTimeMap = workTimeList.get(i);
			
			waDate.add(workTimeMap.get("WA_DATE"));
			wkAvg.add(workTimeMap.get("WKAVG"));
			minTime.add(workTimeMap.get("MINTIME"));
			maxTime.add(workTimeMap.get("MAXTIME"));
		};
		
		workchartMap.put("waDate", waDate);
		workchartMap.put("wkAvg", wkAvg);
		workchartMap.put("minTime", minTime);
		workchartMap.put("maxTime", maxTime);
		
		log.info("workTimeList:{}",workTimeList);
		log.info("workchartMap:{}",workchartMap);
		
		return workchartMap;
	};
	
	//부서별 남성, 여성의 숫자를 조회하는 메서드
		@GetMapping(value = "sexperdept.do",  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
		@ResponseBody
		public LinkedHashMap<String, List<Object>> sexPerDeptRetrieve(){
			
			Map<String, String> sexPerDeptMap = new HashMap<>();							//for문에서 맵을 하나씩 담아두기 위한 변수
			LinkedHashMap<String, List<Object>> deptgenchartMap = new LinkedHashMap<>();	//순서대로 값을 꺼내기 위해서 LinkedHashMap으로 선언해서 사용
			
			List<HashMap<String, String>> sexPerDeptList = insightDAO.sexPerDeptRetrieve();	//db에서 값을 꺼내옴

			//값을 담을 변수선언
			List<Object> dnm = new ArrayList<>(); 
			List<Object> total = new ArrayList<>(); 
			List<Object> mcnt = new ArrayList<>(); 
			List<Object> fcnt = new ArrayList<>(); 
			
			for(int i=0; i < sexPerDeptList.size(); i++) {
				sexPerDeptMap = sexPerDeptList.get(i);
				
				dnm.add(sexPerDeptMap.get("DNM"));
				total.add(sexPerDeptMap.get("TOTAL"));
				mcnt.add(sexPerDeptMap.get("MCNT"));
				fcnt.add(sexPerDeptMap.get("FCNT"));
			};
			
			deptgenchartMap.put("dnm", dnm);
			deptgenchartMap.put("total", total);
			deptgenchartMap.put("mcnt", mcnt);
			deptgenchartMap.put("fcnt", fcnt);
			
			log.info("sexPerDeptList:{}",sexPerDeptList);
			log.info("deptgenchartMap:{}",deptgenchartMap);
			
			return deptgenchartMap;
		};
	
	//부서별 평균임금, 최저임금, 최고임금 조회하는 메서드, 상위부서순으로 정렬
	@GetMapping(value = "wageperdept.do",  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public LinkedHashMap<String, List<Object>> deptPerWageRetrieve(){
		Map<String, Object> wagePerDeptMap = new HashMap<>();							//for문에서 맵을 하나씩 담아두기 위한 변수
		LinkedHashMap<String, List<Object>> deptwagechartMap = new LinkedHashMap<>();	//순서대로 값을 꺼내기 위해서 LinkedHashMap으로 선언해서 사용
		List<HashMap<String, Object>> wagePerDeptList = insightDAO.deptPerWageRetrieve();	//db에서 값을 꺼내옴
		
		//값을 담을 변수선언
		List<Object> dnm = new ArrayList<>(); 		//부서이름
		List<Object> avgAmt = new ArrayList<>(); 	//부서평귬임금
		List<Object> minAmt = new ArrayList<>(); 	//부서최소임금
		List<Object> maxAmt = new ArrayList<>(); 	//부서최고임금
		List<Object> totalAvg = new ArrayList<>(); 	//전체평균임금

		//평균금액 전체의 평균 산출 변수선언
		int sum = 0;
		List<Integer> intAvgAmt = new ArrayList<>(); 
		
		for(int i=0; i < wagePerDeptList.size(); i++) {
			wagePerDeptMap = wagePerDeptList.get(i);
			
			dnm.add(wagePerDeptMap.get("DNM"));
			//계약금액은 백만원단위로 바꿔주기
			avgAmt.add( Integer.parseInt(String.valueOf(wagePerDeptMap.get("AVG_AMT")))/1000000 );		
			intAvgAmt.add( Integer.parseInt(String.valueOf(wagePerDeptMap.get("AVG_AMT")))/1000000 );		
			minAmt.add( Integer.parseInt(String.valueOf(wagePerDeptMap.get("MIN_AMT")))/1000000 );
			maxAmt.add( Integer.parseInt(String.valueOf(wagePerDeptMap.get("MAX_AMT")))/1000000 );
		};
		
		//전체 평균임금을 구해서 list에 담아주기
		for(int num : intAvgAmt) {
			sum +=num;
		};
		double totalamtAvg = (double)sum / intAvgAmt.size();
		totalAvg.add(Math.floor(totalamtAvg));		//소수점 버림
		
		deptwagechartMap.put("dnm", dnm);
		deptwagechartMap.put("avgAmt", avgAmt);
		deptwagechartMap.put("minAmt", minAmt);
		deptwagechartMap.put("maxAmt", maxAmt);
		deptwagechartMap.put("totalAvg", totalAvg);
		
		log.info("wagePerDeptList:{}",wagePerDeptList);
		log.info("deptwagechartMap:{}",deptwagechartMap);
		
		return deptwagechartMap;
	};
		
	//현재 재직중인 구성원 중 수습중인 사원의 수를  조회하는 메서드
		@PostMapping(value = "prmember.do",  produces="application/json;charset=utf-8")
		@ResponseBody
		public List<HashMap<String,String>> prMemberRetieve(){
			List<HashMap<String,String>> prMem = insightDAO.prMemberRetieve();
				
			log.info("prMem:{}",prMem);
			
			return prMem;
		}
	
	//퇴사자의 퇴사기간 정보를 조회하는 메서드
		@GetMapping(value = "outperiodinfo.do",  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
		@ResponseBody
		public LinkedHashMap<String, Object> outPeriodInfo(){
			
			Map<String, String> outprdMap = new HashMap<>();							//for문에서 맵을 하나씩 담아두기 위한 변수
//			LinkedHashMap<String, List<String>> outPeriodInfoMap = new LinkedHashMap<>();	//순서대로 값을 꺼내기 위해서 LinkedHashMap으로 선언해서 사용
			
			List<HashMap<String, String>> outPeriodList = insightDAO.outPeriodTotal();	//db에서 값을 꺼내옴
			String avgOutPeriod = insightDAO.avgOutPeriod();	//db에서 값을 꺼내옴
			
			LinkedHashMap<String,Object> outperCnt = new LinkedHashMap<>(); 
			
			//값을 담을 변수선언
			List<String> empNo = new ArrayList<>(); 
			List<String> entDate = new ArrayList<>(); 
			List<String> outDate = new ArrayList<>(); 
			List<Integer> totalDays = new ArrayList<>(); 
			List<String> years = new ArrayList<>(); 
			List<String> months = new ArrayList<>(); 
			List<String> days = new ArrayList<>(); 
			
			int month3 = 0;		//3개월 미만
			int month6 = 0;		//6개월 미만
			int month12 = 0;	//12개월 미만
			int month24 = 0;	//24개월 미만
			int year10 =0;		//10년 미만
			int longwork = 0;	//10년이상
			
			for(int i=0; i < outPeriodList.size(); i++) {
				outprdMap = outPeriodList.get(i);
				
				empNo.add(outprdMap.get("EMP_NO"));
				entDate.add(outprdMap.get("ENT_DATE"));
				outDate.add(outprdMap.get("OUT_DATE"));
				totalDays.add(Integer.parseInt(outprdMap.get("TOTAL_DAYS")));
				years.add(outprdMap.get("YEARS"));
				months.add(outprdMap.get("MONTHS"));
				days.add(outprdMap.get("DAYS"));
			};
			
			for(int j=0; j <totalDays.size(); j++) {
				int num = totalDays.get(j);
				if (num < 90) {
					month3++;
				}else if(num < 180) {
					month6++;
				}else if(num < 365) {
					month12++;
				}else if(num < 730) {
					month24++;
				}else if(num < 3650) {
					year10++;
				}else{
					longwork++;
				};
			};
			outperCnt.put("month3", month3);
			outperCnt.put("month6", month6);
			outperCnt.put("month12", month12);
			outperCnt.put("month24", month24);
			outperCnt.put("year10", year10);
			outperCnt.put("longwork", longwork);
			outperCnt.put("avgOutPeriod", avgOutPeriod);
			
//			outPeriodInfoMap.put("empNo",empNo);
//			outPeriodInfoMap.put("entDate",entDate);
//			outPeriodInfoMap.put("outDate",outDate);
//			outPeriodInfoMap.put("totalDays",totalDays);
//			outPeriodInfoMap.put("years",years);
//			outPeriodInfoMap.put("months",months);
//			outPeriodInfoMap.put("days",days);
			
			log.info("outperCnt:{}",outperCnt);
			
			return outperCnt;
		};
		
	
}

