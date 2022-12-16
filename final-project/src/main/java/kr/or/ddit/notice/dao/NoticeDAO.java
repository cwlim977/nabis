package kr.or.ddit.notice.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.NoticeVO;

@Mapper
public interface NoticeDAO {
		
	public int insertNotice(NoticeVO noticeVO);
	public NoticeVO selectNotice(@Param("postNo") int postNo);
//	public int incrementBoHit(@Param("postNo") int postNo);

//	public List<NoticeVO> selectNoticeList(PagingVO<NoticeVO> pagingVO);
	public List<NoticeVO> selectNoticeList();
//	public int selectTotalRecord(PagingVO<NoticeVO> pagingVO);
//	public int selectTotalRecord();
	
	public int updateNotice(NoticeVO noticeVO);
	public int deleteNotice(NoticeVO noticeVO);
	public int selectNoticeCnt();
//	public int incrementRec(int boNo);
	

}

//interface xml service testcase완성
// DAO - SERVICE - XML - TESTCASE