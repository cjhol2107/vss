package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.BoardLikeVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

public interface KnwShrReplyMapper {

	public int insert(ReplyVO vo);

	public ReplyVO read(Long bno);

	public int delete(Long bno);

	public int update(ReplyVO reply);

	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") Long bno);

	public int getCountByBno(Long bno);
	
	public int checkReplyLike(BoardLikeVO vo);
	
    public int insertReplyLike(BoardLikeVO vo);
	
	public int deleteReplyLike(BoardLikeVO vo);
	
	public int getReplyLike(BoardLikeVO vo);
	
	public int updateReplyLikes(BoardLikeVO vo);
	
	public int updateSelectedAns(ReplyVO vo);
}
