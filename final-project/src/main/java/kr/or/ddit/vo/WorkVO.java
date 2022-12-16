package kr.or.ddit.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import kr.or.ddit.commons.validate.DeleteGroup;
import kr.or.ddit.commons.validate.UpdateGroup;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@SuppressWarnings("serial")
@Getter
@Setter
@EqualsAndHashCode(of = "wkCode")
@ToString
public class WorkVO implements Serializable {
	
	// 근무코드
	@NotBlank(groups= {UpdateGroup.class, DeleteGroup.class})
	@Size(max = 9)
	private String wkCode;
	// 근무명
	@NotBlank
	@Size(max = 100)
	private String wkNm;
	// 근무설명
	@Size(max = 1000)
	private String wkDescr;
	// 근무삭제
	@Size(max = 30)
	private String wkDel;
	
	// 일정공유
	private String wkScd;
	// 야간허용
	private String wkNight;
	// 휴일허용
	private String wkHd;
	
}
