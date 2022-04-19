package org.zerock.service;

import java.util.List;

import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardLikeVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardService {
	
	public void register(BoardVO board);
	public BoardVO get(Long bno);
	public BoardVO getForMod(Long bno);
	public boolean modify(BoardVO board);
	public boolean remove(Long bno);    
	public List<BoardVO> getList(Criteria cri, String libCls);
	public int getTotal(Criteria cri);
	public List<BoardAttachVO> getAttachList(Long bno);
	public void removeAttach(Long bno);
	public boolean updateViews(Long bno);
	public int getBoardLike(Long bno);
	public int checkBoardLike(BoardLikeVO vo);
	public void insertBoardLike(BoardLikeVO vo);
	public void deleteBoardLike(BoardLikeVO vo);
	public boolean deleteSelected(Long bno);
}
