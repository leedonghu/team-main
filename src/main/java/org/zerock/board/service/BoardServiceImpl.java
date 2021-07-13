package org.zerock.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.board.domain.BoardVO;
import org.zerock.board.mapper.BoardMapper;

import lombok.Setter;

@Service
public class BoardServiceImpl implements BoardService{
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Override
	public boolean register(BoardVO vo) {
		return mapper.register(vo) == 1;		
	}

	@Override
	public List<BoardVO> getList() {
		
		return mapper.getList();
	}

}
