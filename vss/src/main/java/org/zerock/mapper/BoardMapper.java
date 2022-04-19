package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardLikeVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardMapper {

	public List<BoardVO> getList();   

	public List<BoardVO> getListWithPaging(Criteria cri);

	public void insert(BoardVO board);      

	public void updateCategory(BoardVO board);      
   
	public Integer insertSelectKey(BoardVO board);  
      
	public BoardVO read(Long bno);   
	
	public BoardVO getForMod(Long bno);   

	public int delete(Long bno);      
   
	public int update(BoardVO board);

	public int getTotalCount(Criteria cri);

	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
	
	public List<BoardAttachVO> findByBno(Long bno);     
	
	public int checkLike(BoardLikeVO vo);
	
	public int insertBoardLike(BoardLikeVO vo);
	
	public void createBoardLike(BoardLikeVO vo);
	
	public int deleteBoardLike(BoardLikeVO vo);
	
	public int getBoardLike(Long bno);
	
	public void updateBoardLike(Long bno);

	public int updateViews(Long bno);
}
 