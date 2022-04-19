package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardLikeVO {

	private Long bno;
	private Long rno;
	private String userid;
	private String replyer;
	private Long likes;

}
