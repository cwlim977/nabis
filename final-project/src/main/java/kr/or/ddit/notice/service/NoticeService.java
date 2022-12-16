package kr.or.ddit.notice.service;

import java.util.List;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.vo.AttatchVO;
import kr.or.ddit.vo.NoticeVO;


public interface NoticeService {
	
	public ServiceResult createNotice(NoticeVO notice);
	public NoticeVO retrieveNotice(int postNo);
//	public List<NoticeVO> retrieveBoardList(PagingVO<NoticeVO> pagingVO);
//	public int retrieveBoardCount(PagingVO<NoticeVO> pagingVO);
	public List<NoticeVO> retrieveNoticeList();
//	public int retrieveNoticeCount();
	/**
	 * 게시글 수정(인증 필요)
	 * @param board
	 * @return RuntimeException(글존재x), INVALIDPASSWORD, OK, FAIL
	 */
	public ServiceResult modifyNotice(NoticeVO notice);
	/**
	 * 게시글 삭제(인증 필요)
	 * @param board
	 * @return RuntimeException, INVALIDPASSWORD, OK, FAIL
	 */
	public ServiceResult removeNotice(NoticeVO notice);
	
	/**
	 * @param boNo
	 * @return 갱신된 추천 수
	 */
//	public int recommend(int postNo);

	/**
	 * @param attNo
	 * @return 존재 여부에 따라 RuntimeException 발생
	 */
	public AttatchVO retrieveAttatch(int attNo);
}
