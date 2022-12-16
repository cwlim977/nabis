package kr.or.ddit.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import kr.or.ddit.commons.validate.DeleteGroup;
import kr.or.ddit.commons.validate.UpdateGroup;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@SuppressWarnings("serial")
@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(of = "armNo")
public class ArmVO implements Serializable {

	// 알림번호
	@NotBlank(groups= {UpdateGroup.class ,DeleteGroup.class})
	@Size(max = 30)
	private String armNo;
	
	// 발신자
	@NotBlank
	@Size(max = 9)
	private String armSdr;
	// 발신자 이름
	private String empNm;
	// 발신자 프로필
	private String empImg;
	
	// 수신자
	@NotBlank
	@Size(max = 9)
	private String armRcvr;
	
	// 내용PK
	@Size(max = 30)
	private String armContId;

	// 알림내용
	@Size(max = 1000)
	private String armCont;
	
	// 알림시간
	private String armTime;
	
	// URL
	@Size(max = 1000)
	private String armUrl;
	
	// 알림확인여부
	@Size(max = 3)
	private String armStat;
}
