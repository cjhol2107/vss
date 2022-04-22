package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface KnwShrBoardMapper {

	public List<BoardVO> knwShr_getList();   

	public List<BoardVO> knwShr_getListWithPaging(Criteria cri);

	public void knwShr_insert(BoardVO board);      

	public void knwShr_updateCategory(BoardVO board);      
   
	public Integer knwShr_insertSelectKey(BoardVO board);  
      
	public BoardVO knwShr_read(Long bno);   
	
	public BoardVO knwShr_getForMod(Long bno);   

	public int knwShr_delete(Long bno);      
   
	public int knwShr_update(BoardVO board);

	public int knwShr_getTotalCount(Criteria cri);

	public void knwShr_updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
	
	public List<BoardAttachVO> knwShr_findByBno(Long bno);     

	public int knwShr_updateViews(Long bno);
}
 