package org.zerock.board.service;

import java.util.List;

import org.zerock.board.domain.BoardVO;

public interface BoardService {

	public boolean register(BoardVO vo);

	public List<BoardVO> getList();

}
