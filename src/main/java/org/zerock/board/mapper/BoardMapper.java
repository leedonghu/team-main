package org.zerock.board.mapper;

import java.util.List;

import org.zerock.board.domain.BoardVO;
import org.zerock.board.domain.Criteria;

public interface BoardMapper {

	public int register(BoardVO vo);

	public List<BoardVO> getList();

	public int getTotal(Criteria cri);

	public List<BoardVO> getListWithPaging(Criteria cri);

	public BoardVO getDetail(int bno);

	public void updateCnt(BoardVO vo);

	public int modify(BoardVO vo);

	public int remove(BoardVO vo);

}
