package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardLikeVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardAttachMapper;
import org.zerock.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardServiceImpl implements BoardService {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;

	@Setter(onMethod_ = @Autowired)
	private BoardAttachMapper attachMapper;

	@Transactional
	@Override
	public void register(BoardVO board) {

		log.info("register......" + board);

		log.info("==========================serviceimpl==========================");
		
		String content = board.getContent();
		
		
		log.info("before4 ========> "+content);
		
		/*content = content.replaceAll("<", "&lt;");
		content = content.replaceAll(">", "&gt;");
		content = content.replaceAll("\"", "&#034;");
		content = content.replaceAll("\\(", "&#40;");
		content = content.replaceAll("\\)", "&#41;");*/
		
		/*content = content.replaceAll("&lt;", "<");
		content = content.replaceAll("&gt;", ">");*/
		
		log.info("after4 =========> " + content);
	
		board.setContent(content);
		
		log.info("==========================serviceimpl==========================");
		mapper.insertSelectKey(board);
		  
		mapper.updateCategory(board);

		if (board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return;
		}

		board.getAttachList().forEach(attach -> {

			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
	}

	@Override
	public BoardVO get(Long bno) {

		log.info("get......" + bno);

		return mapper.read(bno);

	}
	
	@Override
	public BoardVO getForMod(Long bno) {

		log.info("get......" + bno);

		return mapper.getForMod(bno);

	}

	@Transactional
	@Override
	public boolean modify(BoardVO board) {

		log.info("modify......" + board);

		attachMapper.deleteAll(board.getBno());

		boolean modifyResult = mapper.update(board) == 1;
		
		if (modifyResult && board.getAttachList() != null) {

			board.getAttachList().forEach(attach -> {

				attach.setBno(board.getBno());
				attachMapper.insert(attach);
			});
		}

		return modifyResult;
	}

	// @Override
	// public boolean modify(BoardVO board) {
	//
	// log.info("modify......" + board);
	//
	// return mapper.update(board) == 1;
	// }

	// @Override
	// public boolean remove(Long bno) {
	//
	// log.info("remove...." + bno);
	//
	// return mapper.delete(bno) == 1;
	// }

	@Transactional
	@Override
	public boolean remove(Long bno) {

		log.info("remove...." + bno);

		attachMapper.deleteAll(bno);

		return mapper.delete(bno) == 1;
	}

	@Override
	public List<BoardVO> getList(Criteria cri, String libCls) {

		log.info("get List with criteria: " + cri);
		cri.setLibCls(libCls);
		
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {

		log.info("get total count");
		return mapper.getTotalCount(cri);
	}

	@Override   
	public List<BoardAttachVO> getAttachList(Long bno) {

		log.info("get Attach list by bno" + bno);

		return attachMapper.findByBno(bno);
	}

	@Override
	public void removeAttach(Long bno) {

		log.info("remove all attach files");

		attachMapper.deleteAll(bno);
	}
	
	@Override
	public int getBoardLike(Long bno) {

		return mapper.getBoardLike(bno);
	}

	@Override
	public void insertBoardLike(BoardLikeVO vo) {
  
		mapper.createBoardLike(vo);
		mapper.updateBoardLike(vo.getBno());
	}

	@Override
	public void deleteBoardLike(BoardLikeVO vo) {

		mapper.deleteBoardLike(vo);
		mapper.updateBoardLike(vo.getBno());
	}


	@Override
	public int checkBoardLike(BoardLikeVO vo) {

		return mapper.checkLike(vo);
	}

	@Override
	public boolean deleteSelected(Long bno) {
		// TODO Auto-generated method stub
		return false;
	}
	
	@Override
	public boolean updateViews(Long bno) {

		log.info("updateViews=====>"+bno);
		return mapper.updateViews(bno)==1;
	}

}
