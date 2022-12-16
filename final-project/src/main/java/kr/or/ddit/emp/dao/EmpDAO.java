package kr.or.ddit.emp.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.AccaVO;
import kr.or.ddit.vo.AsgmtVO;
import kr.or.ddit.vo.CareerVO;
import kr.or.ddit.vo.CmcodeVO;
import kr.or.ddit.vo.CnthxVO;
import kr.or.ddit.vo.DeptVO;
import kr.or.ddit.vo.EmpFamVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.EmptVO;
import kr.or.ddit.vo.HrnoteVO;
import kr.or.ddit.vo.PagingVO;

/**
 * @author PC-14
 *
 */
@Mapper
public interface EmpDAO {

	/**
	 * 사원 정보 등록
	 * @param emp
	 * @return 성공 : 1 실패 : 0
	 */
	public int insertEmp(EmpVO emp);
	
	/**
	 * 사원 계정 등록
	 * @param emp
	 * @return 성공 : 1 실패 : 0
	 */
	public int insertEmpId(EmpVO emp);

	/**
	 * 사원 상세 조회
	 * @param empNo 조회할 사원의 번호
	 * @return 존재하지 않는다면, null반환
	 */
	public EmpVO selectEmp(String empNo);
	
	/**
	 * 사원 목록 조회
	 * @param 
	 * @return size==0 테이블 empty
	 */
	public List<EmpVO> selectEmpList();
	
	
	/**
	 * 사원 목록 조회 검색 임시용
	 * @param searchParam
	 * @return size==0 테이블 empty
	 */
	public List<EmpVO> selectEmpListSearch(Map<String, Object> searchParam);
	
	/**
	 * 사원 권한 초기화 (최고관리자제외)
	 * @param empNo - 사원번호
	 * @return
	 */
	public int resetIdRoles(String empNo);
	/**
	 * 사원 조직장 권한 부여 (최고관리자제외)
	 * @param empNo - 사원번호
	 * @return
	 */
	public int updateIdRoles(String empNo);
//########################################################################################################
// 인사발령 
	
	/**
	 * 인사발령 등록
	 * @param Asgmt
	 * @return 성공 : 1 실패 : 0
	 */
	public int insertAsgmt(AsgmtVO asgmt);
	
	/**
	 * 인사발령 다중등록
	 * @param paramMap - List<AsgmtVO> asgmtList 인사발령리스트, String writer 작성자
	 * @return 성공 : 1 실패 : 0
	 */
	public int insertAsgmts(Map<String, Object> paramMap);
	
	/**
	 * 인사발령 개인내역 조회
	 * @param empNo
	 * @return
	 */
	public List<AsgmtVO> selectAsgmtList(String empNo);
	
	/**
	 * 인사발령 전체내역 조회
	 * @return
	 */
	public List<AsgmtVO> selectAllAsgmtList();	
	
	
	/**
	 * 인사발령 상세내역 조회
	 * @param asgmtNo - 조회할 인사발령 번호
	 * @return
	 */
	public List<EmpVO> selectAsgmtDetail(String asgmtNo);
	
	/**
	 * 인사발령 취소
	 * 취소상태로 업데이트
	 * @param asgmt
	 * @return 성공 : 1 실패 : 0
	 */
	public int deleteAsgmt(AsgmtVO asgmt);
	

//########################################################################################################
// 사원계약상태조회 
	
	/**
	 * 사원 계약상태 목록 조회
	 * @param paramArr - 계약상태 필터값 파라미터
	 * @return size==0 테이블 empty
	 */
	public List<EmpVO> selectEmpCntStatusList(Map<String, Object> paramArr);
	/**
	 * 사원 계약상태 목록의 임금계약만료예정 Record 조회
	 * @return
	 */
	public int selectEmpCntStatusWageRecord();
	/**
	 * 사원 계약상태 목록의 근로계약만료예정 Record 조회
	 * @return
	 */
	public int selectEmpCntStatusWkRecord();
	/**
	 * 사원 계약상태 목록의 수습중 Record 조회
	 * @return
	 */
	public int selectEmpCntStatusPrRecord();
//######################################################################################################
	
	/**사원 경력 조회
	 * @param empNo
	 * @return
	 */
	public List<CareerVO> selectCareer(String empNo);
	
	/**사원 학력 조회
	 * @param empNo
	 * @return
	 */
	public List<AccaVO> selectAcca(String empNo);
	

	//==================인사노트 메서드 시작==========================================================================
		/**
		 * 인사노트 목록 조회하는 메서드
		 * @param empNo 내가 보고있는 사원의 사원번호
		 * @return
		 */
		public List<HrnoteVO> selectHrnote(String empNo);
		
		/**
		 * @param empNo 리스트에서 조회한 회원의 사원번호
		 * @param model 
		 * @return 인사노트 조회화면jsp주소
		 */
		public EmpVO selectHrInfoList(String empNo);
		
		/**
		 * 인사노트 목록 조회하는 메서드
		 * @param empNo 내가 보고있는 사원의 사원번호
		 * @return
		 */
		public List<HrnoteVO> selectHrNoteList(String empNo);
		
		/**
		 * 인사노트 신규작성하는 메서드
		 * @param empNo 조회한 대상자의 사원번호. 인사노트를 작성하는 대상을 뜻함
		 * @return 
		 */
		
		public int insertHrnote(HrnoteVO hrnote);
		/**
		 * 작성한 인사노트를 삭제상태로 update 하는 메서드 삭제상태를 Y(es)로 바꾸어주어 list에 출력되지 않게 한다.
		 * @param noteNo 인사노트 번호
		 * @return update성공시 1, 실패시 0
		 */
		public int deleteHrnote(String noteNo);
		
		/**
		 * 작성되어있는 인사노트를 수정하는 메서드. 수정된 내용만 바뀌며, 날짜는 업데이트되지 않는다. 
		 * 작성자 본인이 작성한 것이 아니면 수정할 수 없다.
		 * @param hrnote (수정한 노트의 내용인 noteCont와 수정된 글의 번호는 noteNo, 작성자 번호인 writer를 받는다.)
		 * @return update 성공시 1, 실패시 0
		 */
		public int updateHrnote(HrnoteVO hrnote);
		
	//==================인사노트 메서드 종료==========================================================================
		
	//==================계약정보 메서드 시작==========================================================================
		/**
		 * 근로계약 - 최근의 계약정보를 출력하는 메서드
		 * @param empNo 조회하고자 하는 사원번호
		 * @return
		 */
		public CnthxVO selectRecentWkList(String empNo);
		
		/**
		 * 근로계약 신규추가 메서드
		 * @param lcntInfo 근로계약 정보를 담은 VO타입 변수
		 * @return insert 성공시 1, 실패시 0 반환
		 */
		public int insertLaborCrt(CnthxVO lcntInfo);
		
		/**
		 * 근로계약 수정 메서드
		 * @param lcntInfo 수정할 근로계약정보를 담은 CnthxVO타입 변수
		 * @return 성공시 1, 실패시 0 반환
		 */
		public int updateRctWkList(CnthxVO lcntInfo);
		
		/**
		 * 근로계약 삭제 메서드
		 * @param cnthxNo 삭제할 계약번호
		 * @return 성공시1, 실패시 0 반환
		 */
		public int deleteRctWkList(String cnthxNo);
		
		/**
		 * 임금계약 - 최근의 계약정보를 출력하는 메서드
		 * @param empNo 조회하고자 하는 사원번호
		 * @return
		 */
		public CnthxVO selectRecentWageList(String empNo);
		
		/**
		 * 임금계약 신규추가 메서드
		 * @param lcntInfo 근로계약 정보를 담은 VO타입 변수
		 * @return insert 성공시 1, 실패시 0 반환
		 */
		public int insertWageCrt(CnthxVO wcntInfo);
		
		/**
		 * 임금계약 수정 메서드
		 * @param lcntInfo 수정할 근로계약정보를 담은 CnthxVO타입 변수
		 * @return 성공시 1, 실패시 0 반환
		 */
		public int updateRctWgList(CnthxVO wcntInfo);
		
		/**
		 * 사원의 임금계약 목록을 출력하는 메서드
		 * @param empNo 목록을 출력할 사원의 사원번호
		 * @return 사원의 임금계약 내용이 담긴 CnthxVO객체 List
		 */
		public List<CnthxVO> WageCntRetrieve(String empNo);
		
		/**
		 * 사원의 근로계약 목록을 출력하는 메서드
		 * @param empNo 목록을 출력할 사원의 사원번호
		 * @return 사원의 근로계약 내용이 담긴 cnthxVO객체 List
		 */
		public List<CnthxVO> WorkCntRetrieve(String empNo);
		
		/**
		 * 근로,임금계약 목록에서 개별 상세정보를 조회하는 메서드
		 * @param empNo 사원번호
		 * @param cnthxNo 계약번호
		 * @return 계약정보가 담신 cnthxVO객체
		 */
		public CnthxVO choosenCntRetrieve(String cnthxNo);

		
	//==================계약정보 메서드 종료==========================================================================
		
	//==================재직정보 메서드 시작==========================================================================
		/**
		 * 퇴직상태를 입력하기 위한 메서드
		 * @param emptVo 퇴직처리하기 위한 사원번호, 퇴직일자 등을 가진 VO객체
		 * @return 성공시 1, 실패시 0 반환
		 */
		public int insertOutToEmptst(EmptVO emptVo);
		
		/**
		 * 휴직상태를 입력하기 위한 메서드
		 * @param emptVo 퇴직처리하기 위한 사원번호, 퇴직일자 등을 가진 VO객체
		 * @return 성공시 1, 실패시 0 반환
		 */
		public int insertBkToEmptst(EmptVO emptVo);
		
		/**
		 * 사원의 휴직이력을 조회하기 위한 메서드
		 * @param empNo 휴직이력을 조회하고 싶은 사원의 사원번호
		 * @return 사원의 휴직이력이 담긴 VO객체 리스트
		 */
		public List<EmptVO> bkStateRetrieve(String empNo);

		/**
		 * 사원의 휴직기록을 삭제상태로 바꾸기 위한 메서드
		 * @param emptNo 사원의 휴직이력 번호
		 * @return 성공시 1, 실패시 0 반환
		 */
		public int deleteBkState(String emptNo);
		
		/**
		 * 사원의 휴직기록을 수정하기 위한 메서드
		 * @param emptVo 사원의 휴직이력을 수정하기 위해 입력한 데이터를 담은 EmptVO객체
		 * @return 성공시 1, 실패시 0 반환
		 */
		public int modifyBkState(EmptVO emptVo);
		
	//==================재직정보 메서드 종료==========================================================================
	
	
	
	/** 라벨 유형 조회
	 * @return 실패 null
	 */
	public List<CmcodeVO> selectLabel(); 
	
	
	
	/** 
	 * 인사 정보-기본정보 변경
	 * @param emp
	 * @return 성공 1, 실패 0
	 */
	public int updateEmp(EmpVO emp);
	
	
	
	/**
	 * 은행명 List 조회
	 * @return 실패 null
	 */
	public List<CmcodeVO> bankNmList();
	
	
	/** 
	 * 기본정보 변경
	 * @param emp
	 * @return 성공 1, 실패 0
	 */
	public int updateBasicInfo(EmpVO emp);


	
	
	
	
	/**
	 * 가족정보 추가 
	 * @param fam
	 * @return 성공1, 실패 0
	 */
	public int insertEmpFam(EmpFamVO fam);
	
	/**
	 * 가족정보 List 조회
	 * @param empNo
	 * @return
	 */
	public List<EmpFamVO> selectFamList(@Param("efamEmpno")String empNo);

	
	
	/**
	 * 기본공제 인원수, 자녀세액 공제 인원수
	 * @param empNo
	 * @return
	 */
	public EmpFamVO selectFamCount(@Param("efamEmpno")String empNo);
	
	
	/**
	 * 수정할 가족 정보 조회
	 * @param famEmpNo
	 * @return
	 */
	public EmpFamVO selectFamView(String efamNo);
	
	
	
	/**
	 * 가족정보 수정
	 * @param fam
	 * @return 성공1, 실패 0
	 */
	public int updateEmpFam(EmpFamVO fam);
	
	
	
	/**
	 * 가족 정보 삭제
	 * @param efamNo
	 * @return
	 */
	public int deleteEmpFam(String efamNo);
	
	
	/**
	 * 경력 추가
	 * @param carrer
	 * @return 성공 1 실패 0
	 */
	public int insertCareerInfo(CareerVO career);
	
	
	/**
	 * 하나의 경력에대한 정보 조회 
	 * @param caNo
	 * @return
	 */
	public CareerVO selectCareerView(String caNo);
	
	

	/**
	 * 계약 유형 List
	 * @return
	 */
	public List<CmcodeVO> selectCaCntCaseList();
	
	/**
	 * 졸업 구분 List
	 * @return
	 */
	public List<CmcodeVO> selectGradeClfList();
	
	
	/**
	 * 학교 구분 List
	 * @return
	 */
	public List<CmcodeVO> selectAcClfList();
	
	
	/**
	 * 경력 수정 
	 * @return
	 */
	public int careerInfoUpdate(CareerVO career);
	
	/**
	 * 경력 삭제
	 * @param caNo
	 * @return
	 */
	public int careerInfoDelete(String caNo);
	
	
	
	/**
	 * 학력 정보 추가 
	 * @param acca
	 * @return
	 */
	public int accInfoInsert(AccaVO acca);
	
	
	
	/**
	 * 사원에 대한 학력 List
	 * @param empNo
	 * @return
	 */
	public List<AccaVO> selectAccaList(String empNo);
	
	
	/**
	 * 학력 수정
	 * @param acca
	 * @return
	 */
	public int updateAccaInfo(AccaVO acca);
	
	/**
	 * 학력 삭제 
	 * @param accaNo
	 * @return
	 */
	public int deleteAccaInfo(String accaNo);

	
	/**
	 * 프로필 이미지 변경
	 * @param empNo
	 * @return 성공 1 , 실패 0
	 */
	public int updateEmpImg(EmpVO emp);
	
	
	
	/**
	 * 프로필 이미지 삭제
	 * @param empNo
	 * @return성공 1 , 실패 0
	 */
	public int deleteEmpImg(String empNo);
	
	
	
	/**
	 * 빠른 검색 -구성원 
	 * 사원 정보 List 
	 * @param empNm
	 * @return
	 */
	public List<EmpVO> quickSerchEmp(String empNm);

	public List<EmpVO> selectEmpListPaging(PagingVO<EmpVO> pagingVO);

	public int selectTotalRecord(PagingVO<EmpVO> pagingVO);
}
