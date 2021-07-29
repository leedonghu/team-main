package org.zerock.game.service;

import org.zerock.game.domain.QuizVO;

public interface QuizService {

	QuizVO getQuiz();



	void insertState(QuizVO vo);

	void updateClick(QuizVO vo);

	QuizVO getQuizState(QuizVO vo);

	void updateSolve(QuizVO vo);

}
