package org.zerock.service;

import java.util.List;

import org.zerock.domain.BoardLikeVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;

public interface KnwShrReplyService {

	public int register(ReplyVO vo);

	public ReplyVO get(Long rno);

	public int modify(ReplyVO vo);

	public int remove(Long rno);

	public List<ReplyVO> getList(Criteria cri, Long bno);
	
	public ReplyPageDTO getListPage(Criteria cri, Long bno);
	
	public int checkReplyLike(BoardLikeVO vo);

	public int insertReplyLike(BoardLikeVO vo);
	
	public int deleteReplyLike(BoardLikeVO vo);
	
	public int getReplyLike(BoardLikeVO vo);
	
	public int updateReplyLikes(BoardLikeVO vo);
	
	public int updateSelectedAns(ReplyVO vo);
	
	

}
