package kr.or.ddit.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import lombok.Data;
import lombok.EqualsAndHashCode;

@SuppressWarnings("serial")
@EqualsAndHashCode(of = "asgmtNo")
@Data
public class AsgmtVO implements Serializable {
	// 인사발령번호
	//@NotNull 업데이트시
	@Min(0)
	private Integer asgmtNo;
	
	// 인사발령대상
	@NotBlank
	@Size(max = 9)
	private String asgmtPers;
	
	// 발령구분
	@NotBlank
	@Size(max = 20)
	private String asgmtClf;
	
	// 발령사유
	@Size(max = 1000)
	private String asgmtRsn;
	
	// 발령메모
	@Size(max = 1000)
	private String asgmtMm;
	
	// 발령일자
	@NotBlank
	private String asgmtDate;
	
	// 작성자
	//@NotBlank
	@Size(max = 9)
	private String writer;
	
	// 최초작성일자
	private String fwrDate;
	
	// 최종수정일자
	private String lwrDate;
	
	// 직위코드
	@Size(max = 9)
	private String ptnCode;
	
	// 직급코드
	@Size(max = 9)
	private String grdCode;
	
	// 발령취소
	@Size(max = 20)
	private String asgmtCcst;
	
	// 발령상태
	// { 취소 ,예정 ,완료 }
	private String asgmtStat;
	// 발령 인원수
	private Integer asgmtCnt;
	// 발령전후상태
	private String before;
	
	// 직무코드 배열 (직무 여러개 추가 용도)
	private String[] jcodeList;
	// 담당직무들 has many
	private List<OwnJobVO> jobList;
	// 담당부서들 has many
	private List<BlgDeptVO> deptList;
	
	// 작성자 이름
	private String writerNm;
	// 직위이름
	private String ptnNm;
	// 직급이름
	private String grdNm;
}
