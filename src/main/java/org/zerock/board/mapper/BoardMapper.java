package org.zerock.board.mapper;

import java.util.List;

import org.zerock.board.domain.BoardVO;

public interface BoardMapper {

	public int register(BoardVO vo);

	public List<BoardVO> getList();

}
