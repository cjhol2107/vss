package org.zerock.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {

	private Long bno;
	private String title;
	private String content;
	private String writer;
	private String category;
	private String category1;
	private String category2;
	private String category3;
	private String adoptionYn;
	private Date regdate;
	private Date updateDate;
	private int likes;
	private int views;
	

	private int replyCnt;

	private List<BoardAttachVO> attachList;
}
