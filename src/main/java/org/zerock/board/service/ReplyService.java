package org.zerock.board.service;

import java.util.List;

import org.zerock.board.domain.ReplyVO;
import org.zerock.board.domain.Reply_ReplyVO;

public interface ReplyService {
	
	public List<ReplyVO> getList(int bno);

	public void register(ReplyVO vo);

	public void goodUpdate(ReplyVO vo);

	public ReplyVO getReply(int rno);

	public void badUpdate(ReplyVO vo);

	public List<Reply_ReplyVO> getReply_ReplyList(int rno);

	public void reply_register(Reply_ReplyVO vo);
}
