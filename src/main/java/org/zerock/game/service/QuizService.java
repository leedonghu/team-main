package org.zerock.game.service;

import org.zerock.game.domain.QuizVO;

public interface QuizService {

	QuizVO getQuiz();

	void insertAtt(QuizVO vo);

	QuizVO getQuizAtt(QuizVO vo);

	void updateAtt(QuizVO vo);

	void updateQuiz(QuizVO vo);

}
