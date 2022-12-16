package kr.or.ddit.vo;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(of="attNo")
@NoArgsConstructor //not only client , db데이터도 받아야해서 넣어줌
public class AttatchVO {
	
	@JsonIgnore
	private MultipartFile adaptee; //adaptee는 adapter없이 작동x - adapter pattern
	
	public AttatchVO(MultipartFile adaptee) { //이미 결정
		super();
		this.adaptee = adaptee;
		this.attFilename = adaptee.getOriginalFilename();
		this.attSavename = UUID.randomUUID().toString();
		this.attMime = adaptee.getContentType();
		this.attFilesize = adaptee.getSize();
		this.attFancysize = FileUtils.byteCountToDisplaySize(attFilesize);
	}

	@NotNull
	private Integer attNo; //insert할때 결정
	private Integer postNo; //insert할때 결정
	private String vaapCode; // 휴가신청코드
	@NotBlank
	private String attFilename;
	@NotBlank
	private String attSavename;
	private String attMime;
	@NotNull
	private Long attFilesize;
	@NotBlank
	private String attFancysize;
	private Integer attDownload;
	
	public void saveTo(File saveFolder) throws IOException {
		if(adaptee==null) return; //저장할 거 없음
		//저장해야할 이진데이터 있음
		File saveFile = new File(saveFolder, attSavename);
		adaptee.transferTo(saveFile);
	}
	
}
