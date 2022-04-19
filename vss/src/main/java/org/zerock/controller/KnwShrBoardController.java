package org.zerock.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardLikeVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.KnwShrBoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/knwShrBoard/*")
@AllArgsConstructor
public class KnwShrBoardController {
   
	private KnwShrBoardService service;

	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public void register() {

	} 
     
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {

		String libCls = "";
		
		libCls = cri.getLibCls();
		
		model.addAttribute("list", service.knwShr_getList(cri, libCls));
	
		int total = service.knwShr_getTotal(cri);

		model.addAttribute("pageMaker", new PageDTO(cri, total, libCls));

	}

	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String register(BoardVO board, RedirectAttributes rttr) {

		log.info("==========================controller==========================");
  
		log.info("register: " + board);

		if (board.getAttachList() != null) {

			board.getAttachList().forEach(attach -> log.info(attach));

		}

		log.info("==========================controller==========================");
		
		service.knwShr_register(board);

		rttr.addFlashAttribute("result", board.getBno());

		return "redirect:/knwShrBoard/list?libCls=";
	}

	@GetMapping({ "/get" })    
	public String get(HttpServletRequest request, HttpServletResponse response, @RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		
		
		Cookie cookies[] = request.getCookies();
		Cookie viewCookie = null;
		
		if (cookies != null && cookies.length > 0) {
			for (int i = 0; i < cookies.length; i++) {
				if (cookies[i].getName().equals("cookie" + bno)) {
					viewCookie = cookies[i];
				}
			}
		}
		
		log.info("�ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ� view==>"+viewCookie);
	
		if (viewCookie == null) {
			Cookie newCookie = new Cookie("cookie" + bno, "|" + bno + "|");
			response.addCookie(newCookie);
			service.knwShr_updateViews(bno);
		}

		model.addAttribute("board", service.knwShr_get(bno));
		return "/knwShrBoard/get";
	}
	
	@GetMapping("/modify")
	public void modify(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		
		
		BoardVO board = service.knwShr_get(bno);
		log.info("�ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�modify�ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�");
		String content = board.getContent();
		
		log.info("content =====> "+content);
		
		
		
		
		log.info("�ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�modify�ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�");
		
		
		
		model.addAttribute("board", service.knwShr_getForMod(bno));
	}

	@PreAuthorize("principal.username == #board.writer")
	@PostMapping("/modify")
	public String modify(BoardVO board, Criteria cri, RedirectAttributes rttr) {
		log.info("modify:" + board);

		if (service.knwShr_modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}

		return "redirect:/knwShrBoard/list" + cri.getListLink();
	}


	@PreAuthorize("principal.username == #writer")
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, Criteria cri, RedirectAttributes rttr, String writer) {

		log.info("remove..." + bno);

		List<BoardAttachVO> attachList = service.knwShr_getAttachList(bno);

		if (service.knwShr_remove(bno)) {

			// delete Attach Files
			deleteFiles(attachList);

			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/knwShrBoard/list" + cri.getListLink();
	}

	private void deleteFiles(List<BoardAttachVO> attachList) {

		if (attachList == null || attachList.size() == 0) {
			return;
		}

		log.info("delete attach files...................");
		log.info(attachList);

		attachList.forEach(attach -> {
			try {
				Path file = Paths.get(
						"C:\\upload\\" + attach.getUploadPath() + "\\" + attach.getUuid() + "_" + attach.getFileName());

				Files.deleteIfExists(file);

				if (Files.probeContentType(file).startsWith("image")) {

					Path thumbNail = Paths.get("C:\\upload\\" + attach.getUploadPath() + "\\s_" + attach.getUuid() + "_"
							+ attach.getFileName());

					Files.delete(thumbNail);
				}

			} catch (Exception e) {
				log.error("delete file error" + e.getMessage());
			} // end catch
		});// end foreachd
	}

	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno) {

		log.info("getAttachList " + bno);

		return new ResponseEntity<>(service.knwShr_getAttachList(bno), HttpStatus.OK);

	}
	

}
