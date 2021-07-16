package org.zerock.board.service;

import java.util.List;

import org.zerock.board.domain.ReplyVO;

public interface ReplyService {
	
	public List<ReplyVO> getList(int bno);

	public void register(ReplyVO vo);

	public void goodUpdate(ReplyVO vo);

	public ReplyVO getReply(int rno);
}
