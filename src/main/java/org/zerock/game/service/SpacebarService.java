package org.zerock.game.service;

import java.util.List;

import org.zerock.game.domain.QuizVO;

public interface SpacebarService {

	void insertScore(QuizVO vo);

	int firstPride(QuizVO vo);

	List<QuizVO> prideList();

}
