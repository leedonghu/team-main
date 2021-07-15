package org.zerock.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.board.domain.BoardVO;
import org.zerock.board.domain.Criteria;
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
	public List<BoardVO> getList(Criteria cri) {
		
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		
		return mapper.getTotal(cri);
		
	}

	@Override
	public BoardVO getDetail(int bno) {
		
		return mapper.getDetail(bno);
	}

	@Override
	public void updateCnt(BoardVO vo) {
		mapper.updateCnt(vo);
		
	}

	@Override
	public boolean modify(BoardVO vo) {
		
		return mapper.modify(vo) == 1;
		
	}
	

}
