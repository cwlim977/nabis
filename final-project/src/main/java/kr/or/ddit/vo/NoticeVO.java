package kr.or.ddit.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonIgnore;

import kr.or.ddit.commons.validate.DeleteGroup;
import kr.or.ddit.commons.validate.InsertGroup;
import kr.or.ddit.commons.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@JsonAutoDetect
@EqualsAndHashCode(of="postNo")
@ToString(exclude= {"postCont"}) //, "noticeFiles", "attatchList"
public class NoticeVO implements Serializable{

	@NotNull(groups= {UpdateGroup.class, DeleteGroup.class})
	private Integer postNo;
	@NotBlank
	private String postTitle;
	private String postCont;
	private String wriDate;
	@NotBlank(groups=InsertGroup.class)
	private String wriNo;
	private String attach;
	
	//EMP
	private String empNm;
	
	//1:N 여러개니까 List로 받는다 -- 클라이언트가 업로드하는 첨부파일 받기위해
	@JsonIgnore //없으면 오류뜬다 
	private transient List<MultipartFile> noticeFiles;
	public void setNoticeFiles(List<MultipartFile> noticeFiles) {
		if(noticeFiles==null || noticeFiles.isEmpty()) return;//하나 이상의 첨부파일 업로드
		this.noticeFiles = noticeFiles;
		this.attatchList = new ArrayList<>();
		for(MultipartFile file  : noticeFiles) {
			if(file.isEmpty()) continue;
			//attatchVO list 만들고 vo에 넣어주자 - 굳이 컨트롤러에서 할필요 없이 컨트롤러에서 boardVO 받으니까 여기서 아예 만들어벌임
			attatchList.add(new AttatchVO(file));
		}
	}
	@JsonIgnore 
	private transient int startNo;
	//1:N (has many)
	
	private transient List<AttatchVO> attatchList;
	
//		boardVO가 command object인 동시에 model이기 때문에 글 수정 시 필요한 것도 여기에서 만들어야한다
	@JsonIgnore 
	private transient int[] delAttNos;
	
	private transient String empImg;
}
