package kr.or.ddit.notice.service;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import javax.annotation.PostConstruct;

import org.apache.commons.io.FileUtils;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.commons.attatch.dao.AttatchDAO;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.notice.dao.NoticeDAO;
import kr.or.ddit.vo.AttatchVO;
import kr.or.ddit.vo.NoticeVO;
import lombok.RequiredArgsConstructor;
//import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor //알아서 final 붙은애들 injection 해준다
@Service
public class NoticeServiceImpl implements NoticeService {
	
	private final NoticeDAO noticeDAO;
	private final AttatchDAO attatchDAO;
	
	@Value("#{appInfo.attatchFolder}")
	private Resource attatchFolder; //resource형태 loader로 이용
	
	private File saveFolder;
	
	@PostConstruct
	public void init() throws IOException { //lifecycle callback
		saveFolder = attatchFolder.getFile();
	}
	
	//글 등록시 첨부파일 등록
	private int processAttatchList(NoticeVO notice) {
		int rowcnt = 0;
		List<AttatchVO> attatchList = notice.getAttatchList();
		if(attatchList!=null && !attatchList.isEmpty()) {	
//			if(1==1) throw new RuntimeException("트랜잭션 관리 여부 확인용 강제 예외 발생");
		// 메타데이터 저장(문제 생겼을 때 돌릴 수 있는 데이터부터 저장해야한다.)
			rowcnt = attatchDAO.insertAttatches(notice);
		// 2진 데이터 저장 (롤백 불가넝)
			for(AttatchVO attatch : attatchList) { //저장해야하는 파일 하나하나
				try {
					attatch.saveTo(saveFolder);//로딩한건 리소스지만 파일로..
				} catch (IOException e) {
					throw new RuntimeException(e); //signature 건들지 않고도 호출자에게 정보 넘기기위해 런타임쓴다..
				} 
			}
		}
		return rowcnt;
	}
	
	// 글 등록
	@Transactional // 선언적 프로그래밍 기법(AOP)
	@Override
	public ServiceResult createNotice(NoticeVO notice) {
		int rowcnt = noticeDAO.insertNotice(notice); //1
		rowcnt += processAttatchList(notice); //▲ 부모먼저 부르고 호출해야(boardNo가 없기 때문에) , 첨부파일처리
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public NoticeVO retrieveNotice(int postNo) {
		NoticeVO notice = noticeDAO.selectNotice(postNo);
		if(notice==null)
			throw new RuntimeException(String.format("%d 글번호의 글이 없음",postNo));
//		noticeDAO.incrementBoHit(postNo);
		//log.info("noticeView.do 호출 확인 {}", postNo);
		return notice;
		
	}
//------------------------------------------------------------------------------------
//	@Override
//	public List<NoticeVO> retrieveNoticeList(PagingVO<noticeVO> pagingVO) {
//		return noticeDAO.selectBoardList(pagingVO);
//	}
//
//	@Override
//	public int retrieveBoardCount(PagingVO<noticeVO> pagingVO) {
//		return noticeDAO.selectTotalRecord(pagingVO);
//	}
	@Override
	public List<NoticeVO> retrieveNoticeList() {
		return noticeDAO.selectNoticeList();
	}
	
//	@Override
//	public int retrieveNoticeCount() {
//		return noticeDAO.selectTotalRecord();
//	}

	
//------------------------------------------------------------------------------------
	//글 수정
	@Transactional
	@Override
	public ServiceResult modifyNotice(NoticeVO notice) {
		ServiceResult result = null;
//		if(boardAuthenticate(notice)) {
			int rowcnt = noticeDAO.updateNotice(notice);
			// 1. 신규파일등록 2진데이터, 메타데이터
			rowcnt += processAttatchList(notice);
			// 2. 기존파일 삭제 -- 가능한 최대한 모듈화... 일부파일에 대한 삭제처리 필요 : 2진데이터, 메타데이터 삭제 처리
			processDeleteAttatch(notice);
			
			result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
//		}else {
//			result = ServiceResult.INVALIDPASSWORD;
//		}
		return result;
	}
	
//	private boolean boardAuthenticate(NoticeVO notice) {
//		NoticeVO saved = retrieveNotice(notice.getPostNo()); //runtimeexception
//		String inputPass = notice.getBoPass();
//		String savedPass = saved.getBoPass();
//		return savedPass.equals(inputPass);
//	}
	
	
	
	//글 수정시 첨부파일 삭제
	private int processDeleteAttatch(NoticeVO notice) {
		int[] delAttNos = notice.getDelAttNos();
		if(delAttNos==null || delAttNos.length==0) return 0;
		Arrays.sort(delAttNos); // for binarySearch 정렬해준다
		List<AttatchVO> attatchList = noticeDAO.selectNotice(notice.getPostNo()).getAttatchList(); //기존파일들 boad.getAttatchList()로 부르면 새로운 파일들이어서 삭제의 대상이 아님
		
		// 메타 > 2진 삭제해야 복구 가능
		// 메타 데이터 삭제
		List<String> saveNames = attatchList.stream() //이름들 모아있음
								.filter(attatch->{
									return Arrays.binarySearch(delAttNos, attatch.getAttNo())>=0; //2진탐색 정렬먼저, 필터에 걸리는 조건
								}).map(attatch->{
									return attatch.getAttSavename();
								}).collect(Collectors.toList());
		int rowcnt = attatchDAO.deleteAttatches(delAttNos);
		
		if(!saveNames.isEmpty()) {
			for(String attSavename : saveNames ) {
				//지울 파일이 어떤놈인가요
				File deleteFile = new File(saveFolder, attSavename);
				FileUtils.deleteQuietly(deleteFile);
			}
		}
		return rowcnt;
	};
//------------------------------------------------------------------------------------
	// 글 삭제
	@Transactional
	@Override
	public ServiceResult removeNotice(NoticeVO notice) { //board에는 비번이랑 boNo만 들어있음 attatch없음
		ServiceResult result = null;
		log.info("removeNotice 호출");
//		if(noticeAuthenticate(notice)) {
			processDeleteAttatches(notice); //부모 정리하기전에 자식 삭제
			int rowcnt = noticeDAO.deleteNotice(notice);
			result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
//		}else {
//			result = ServiceResult.INVALIDPASSWORD;
//		}
		return result;
	}
	
	//글 삭제시 첨부파일 삭제
		private int processDeleteAttatches(NoticeVO notice) {
			log.info("processDeleteAttatches 호출");
			//removeBoard 에는 attatchList없으니까 한번 가져가야함
			List<AttatchVO> attatchList = noticeDAO.selectNotice(notice.getPostNo()).getAttatchList(); 
			log.info("attatchList 확인 {} ", attatchList);
			
			if(attatchList==null || attatchList.isEmpty()) return 0;
			
			List<String> saveNames = attatchList.stream() //이름들 모아있음
									.map(attatch->{
							return attatch.getAttSavename();
						}).collect(Collectors.toList());
			
			int rowcnt = 0; //몇번삭제할건지? - 몇개있냐에따라
			
			// 메타데이터 삭제
			rowcnt = attatchDAO.deleteAttathes(notice.getPostNo());
			log.info("rowcnt 몇개  확인 ", rowcnt);
			// 2진데이터 삭제
			if(!saveNames.isEmpty()) {
				for(String attSavename : saveNames ) {
					//지울 파일이 어떤놈인가요
					File deleteFile = new File(saveFolder, attSavename);
					FileUtils.deleteQuietly(deleteFile);
				}
			}
			
			return rowcnt;
		}

//	@Override
//	public int recommend(int boNo) {
//		noticeDAO.incrementRec(boNo);
//		return noticeDAO.selectNotice(boNo).getBoRec();
//	}

	@Override
	public AttatchVO retrieveAttatch(int attNo) {
		log.info("retrieveAttatch 호출");
		AttatchVO attatch = attatchDAO.selectAttatch(attNo);
		log.info("attatch 확인", attatch);
		if(attatch == null)
			throw new RuntimeException("해당 파일 없음.");
		return attatch;
	}

}
