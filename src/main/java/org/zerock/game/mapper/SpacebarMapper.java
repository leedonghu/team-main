package org.zerock.game.mapper;

import java.util.List;

import org.zerock.game.domain.QuizVO;

public interface SpacebarMapper {

	void insertScore(QuizVO vo);

	int firstPride(QuizVO vo);

	List<QuizVO> prideList();

}
