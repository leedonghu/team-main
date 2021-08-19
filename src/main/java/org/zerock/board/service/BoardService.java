package org.zerock.board.service;

import java.util.List;

import org.zerock.board.domain.BoardVO;
import org.zerock.board.domain.Criteria;

public interface BoardService {

	public boolean register(BoardVO vo);

	public List<BoardVO> getList(Criteria cri);

	public int getTotal(Criteria cri);

	public BoardVO getDetail(int bno);

	public void updateCnt(BoardVO vo);

	public boolean modify(BoardVO vo);

	public boolean remove(BoardVO vo);

	public List<BoardVO> mainList();

}
