package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardLikeVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.KnwShrBoardAttachMapper;
import org.zerock.mapper.KnwShrBoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class KnwShrBoardServiceImpl implements KnwShrBoardService {

	@Setter(onMethod_ = @Autowired)
	private KnwShrBoardMapper mapper;

	@Setter(onMethod_ = @Autowired)
	private KnwShrBoardAttachMapper knwShrattachMapper;

	@Transactional
	@Override
	public void knwShr_register(BoardVO board) {

		
		String content = board.getContent();
		

		board.setContent(content);
		
		mapper.knwShr_insertSelectKey(board);
		  
		mapper.knwShr_updateCategory(board);

		if (board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return;
		}

		board.getAttachList().forEach(attach -> {

			attach.setBno(board.getBno());
			knwShrattachMapper.knwShr_insert(attach);
		});
	}

	@Override
	public BoardVO knwShr_get(Long bno) {

		log.info("get......" + bno);

		return mapper.knwShr_read(bno);

	}
	
	@Override
	public BoardVO knwShr_getForMod(Long bno) {

		log.info("get......" + bno);

		return mapper.knwShr_getForMod(bno);

	}

	@Transactional
	@Override
	public boolean knwShr_modify(BoardVO board) {

		log.info("modify......" + board);

		knwShrattachMapper.knwShr_deleteAll(board.getBno());

		boolean modifyResult = mapper.knwShr_update(board) == 1;
		
		if (modifyResult && board.getAttachList() != null) {

			board.getAttachList().forEach(attach -> {

				attach.setBno(board.getBno());
				knwShrattachMapper.knwShr_insert(attach);
			});
		}

		return modifyResult;
	}

	@Transactional
	@Override
	public boolean knwShr_remove(Long bno) {

		log.info("remove...." + bno);

		knwShrattachMapper.knwShr_deleteAll(bno);

		return mapper.knwShr_delete(bno) == 1;
	}

	@Override
	public List<BoardVO> knwShr_getList(Criteria cri, String libCls) {

		log.info("get List with criteria: " + cri);
		cri.setLibCls(libCls);
		
		return mapper.knwShr_getListWithPaging(cri);
	}

	@Override
	public int knwShr_getTotal(Criteria cri) {

		log.info("get total count");
		return mapper.knwShr_getTotalCount(cri);
	}

	@Override   
	public List<BoardAttachVO> knwShr_getAttachList(Long bno) {

		log.info("get Attach list by bno" + bno);

		return knwShrattachMapper.knwShr_findByBno(bno);
	}

	@Override
	public void knwShr_removeAttach(Long bno) {
		log.info("remove all attach files");

		knwShrattachMapper.knwShr_deleteAll(bno);
	}
	

	@Override
	public boolean knwShr_deleteSelected(Long bno) {
		// TODO Auto-generated method stub
		return false;
	}
	
	@Override
	public boolean knwShr_updateViews(Long bno) {

		log.info("updateViews=====>"+bno);
		return mapper.knwShr_updateViews(bno)==1;
	}

}
