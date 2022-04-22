package org.zerock.service;

import java.util.List;

import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface KnwShrBoardService {
	
	public void knwShr_register(BoardVO board);
	public BoardVO knwShr_get(Long bno);
	public BoardVO knwShr_getForMod(Long bno);
	public boolean knwShr_modify(BoardVO board);
	public boolean knwShr_remove(Long bno);    
	public List<BoardVO> knwShr_getList(Criteria cri, String libCls);
	public int knwShr_getTotal(Criteria cri);
	public List<BoardAttachVO> knwShr_getAttachList(Long bno);
	public void knwShr_removeAttach(Long bno);
	public boolean knwShr_updateViews(Long bno);
	public boolean knwShr_deleteSelected(Long bno);
}
