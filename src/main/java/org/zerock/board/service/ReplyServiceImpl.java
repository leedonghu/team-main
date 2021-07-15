package org.zerock.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.board.domain.ReplyVO;
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

}
