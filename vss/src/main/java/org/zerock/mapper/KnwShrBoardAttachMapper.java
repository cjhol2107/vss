package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.BoardAttachVO;

public interface KnwShrBoardAttachMapper {

	public void knwShr_insert(BoardAttachVO vo);

	public void knwShr_delete(String uuid);

	public List<BoardAttachVO> knwShr_findByBno(Long bno);

	public void knwShr_deleteAll(Long bno);

	public List<BoardAttachVO> knwShr_getOldFiles();

}