package kr.or.ddit.vo;

import java.io.File;
import java.io.IOException;
import java.io.Serializable;
import java.util.List;
import java.util.UUID;

import javax.validation.constraints.Email;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.validation.groups.Default;

import org.springframework.web.multipart.MultipartFile;


import kr.or.ddit.commons.util.annotation.ExcelColumn;
import kr.or.ddit.commons.validate.InsertGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@SuppressWarnings("serial")
@Data
@EqualsAndHashCode(of = "empNo")
@ToString(exclude = {"regno1", "regno2" ,"empPass"})
public class EmpVO implements Serializable {

	private int rnum;

	// 사원번호
	@NotBlank(groups = {Default.class})
	@Size(max = 9, groups = {Default.class} )
	@ExcelColumn(headerName="사원번호")
	private String empNo;
	// 사원이름
	@NotBlank(groups = {InsertGroup.class})
	@Size(max = 100, groups = {Default.class})
	@ExcelColumn(headerName="이름")
	private String empNm;
	// 입사일
	@NotBlank(groups = {InsertGroup.class})
	@ExcelColumn(headerName="입사일")
	private String entDate;
	// 퇴사일
	@ExcelColumn(headerName="퇴사일")
	private String outDate;
	// 입사유형
	@Size(max = 10)
	@ExcelColumn(headerName="입사유형")
	private String entCase;
	// 부서장?
	@Size(max = 10)
	private String dhd;
	// 영어사원이름
	@Size(max = 100)
	@ExcelColumn(headerName="영어이름")
	private String engNm;
	// 사원메모
	@Size(max = 1000)
	private String empMm;
	// 성별
	@Size(max = 30)
	@ExcelColumn(headerName="법적성별")
	private String empGen;
	// 주민번호 앞자리
	@NotNull(groups = {InsertGroup.class}, message="빈칸인지 확인해주세요.")
	@Min(value=100000, message="주민번호 자리수를 확인해주세요.")
	@Max(value=999999, message="주민번호 자리수를 확인해주세요.")
	@ExcelColumn(headerName="주민번호")
	private transient Integer regno1;
	// 주민번호 뒷자리
	@NotNull(groups = {InsertGroup.class}, message="빈칸인지 확인해주세요.")
	@Min(value=1000000, message="주민번호 자리수를 확인해주세요.")
	@Max(value=9999999, message="주민번호 자리수를 확인해주세요.")
	private transient Integer regno2;
	// 휴대전화 번호
	@Size(max = 20)
	@ExcelColumn(headerName="휴대전화번호")
	private String cpNo;
	// 사무실 번호
	@Size(max = 20)
	private String ofcNo;
	// 사원주소
	@Size(max = 1000)
	@ExcelColumn(headerName="주소")
	private String empAddr;
	// 기본근무시간
	@Size(max = 20)
	private String bsWktime;
	// 사원이메일
	@Email
	@Size(max = 300)
	@ExcelColumn(headerName="이메일")
	private String empMail;
	// 은행
	@Size(max = 60)
	private String bank;
	// 계좌번호
	@Size(max = 30)
	private String acctNo;
	// 예금주
	private String ower;
	
	private String empImg;
	
	private MultipartFile empImage;
	
	public void setEmpImage(MultipartFile empImage) {
		if(empImage != null && !empImage.isEmpty()) {
		this.empImage = empImage;
		this.empImg = UUID.randomUUID().toString();
		}
	}
	
	public void saveTo(File saveFolder)throws IOException{
		if(empImage == null) return;
		File saveFile = new File(saveFolder, this.empImg);
		empImage.transferTo(saveFile);
	}

	
	
	
	// 사원정보삭제상태
	@Size(max = 20)
	private String empCcst;

	
	// 직위코드
	@Size(max = 9)
	private String ptnCode;
	// 직위명
	@ExcelColumn(headerName="직위명")
	private String ptnNm;
	// 직급코드
	@Size(max = 9)
	private String grdCode;
	// 직급명
	@ExcelColumn(headerName="직급명")
	private String grdNm;

	// 소속
	@ExcelColumn(headerName="조직흐름도")
	private String deptFlow;
	// 재직상태
	@ExcelColumn(headerName="재직상태")
	private String empSt;
	// 근속기간
	@ExcelColumn(headerName="근속기간")
	private String tneurePeriod;
	
	// 증명서 발급 날짜 
	private String cfDate;
	
	// 증명서 사원 생년월일
	private String empBir;
//================= 계정 =========================================	
	// 비밀번호
	@NotBlank
	@Size(max=300) 
	private String empPass;
	// 로그인횟수제한
	private Integer empCst;
	// 계정권한
	private List<String> idRoles;
//=================================================================	
	// 담당직무들 has many
	private List<OwnJobVO> jobList;
	// 담당부서들 has many
	private List<BlgDeptVO> deptList;
	// 계약변경이력 리스트 has many
	private List<CnthxVO> cnthxList;
	// 인사발령 리스트 has many
	private List<AsgmtVO> asgmtList;
	// 근무기록 리스트 has many
	private List<WkApVO> workApList;
	// 휴가보유 리스트 has many
	private List<VacPosnVO> vacPosnList;
	
	@ExcelColumn(headerName="직무")
	private String jnm;
	@ExcelColumn(headerName="주조직·직책")
	private String deptExcel;
}
