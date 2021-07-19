package org.zerock.board.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Reply_ReplyVO {
	
	private int r_rno;
	private int rno;
	private String r_content;
	private String r_replyer;
	private Date r_replyDate;
	private Date r_updateDate;
}
