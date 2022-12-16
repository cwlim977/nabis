package kr.or.ddit.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import javax.validation.groups.Default;

import kr.or.ddit.commons.validate.DeleteGroup;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@SuppressWarnings("serial")
@Getter
@Setter
@EqualsAndHashCode(of = "waNo")
@ToString
public class WkApVO implements Serializable {

	// 근무신청 번호
	@NotBlank(groups= {DeleteGroup.class})
	@Size(max = 30)
	private String waNo;
	// 근무코드
	@NotBlank
	@Size(max = 9)
	private String wkCode;
	
	// 근무명
	private String wkNm;
	
	// 신청자
	@NotBlank
	@Size(max = 9)
	private String waAper;
	// 결재자
	@Size(max = 9)
	private String waRver;
	// 신청일자
	private String waApdate;
	// 시작시간
	@Size(max = 20)
	private String waStime;
	// 종료시간
	@Size(max = 20)
	private String waEtime;
	// 신청사유
	@Size(max = 1000)
	private String waArsn;
	// 결재상태
	//@NotBlank
	@Size(max = 20)
	private String ewApst;
	// 결재일자
	private String ewAdate;
	// 반려사유
	@Size(max = 1000)
	private String ewRejrsn;
	// 연장근무시간
	private Double waExtime;
	// 야간근무시간
	private Double waNigtime;
	// 휴일근무시간
	private Double waHdtime;
	// 근무신청삭제
	@Size(max = 20)
	private String waDel;
	// 총근무시간
	private Double waTltime;
	// 근무일자
	@NotBlank(groups= {Default.class,DeleteGroup.class})
	private String waDate;
	
	private String empNm;
	private String empNo;
	private String empImg;
}
