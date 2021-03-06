package org.zerock.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.board.domain.ReplyVO;
import org.zerock.board.domain.Reply_ReplyVO;
import org.zerock.board.mapper.ReplyMapper;

import lombok.Setter;

@Service
public class ReplyServiceImpl implements ReplyService{
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Override
	public List<ReplyVO> getList(int bno) {
		return mapper.getList(bno);
		 
	}

	@Override
	public void register(ReplyVO vo) {
		mapper.register(vo);
		
	}

	@Override
	public void goodUpdate(ReplyVO vo) {
		mapper.goodUpdate(vo);
		
	}

	@Override
	public ReplyVO getReply(int rno) {
		return mapper.getReply(rno);
		
	}

	@Override
	public void badUpdate(ReplyVO vo) {
		mapper.badUpdate(vo);
		
	}

	@Override
	public List<Reply_ReplyVO> getReply_ReplyList(int rno) {
		
		return mapper.getReply_ReplyList(rno);
	}

	@Override
	public void reply_register(Reply_ReplyVO vo) {
		mapper.reply_register(vo);
		
	}

}
