package org.zerock.game.mapper;

import org.zerock.game.domain.QuizVO;

public interface QuizMapper {

	QuizVO getQuiz(String today);



	int countQuizState(QuizVO vo);

	void insertState(QuizVO vo);

	void updateContact(QuizVO vo);

	void updateClick(QuizVO vo);

	QuizVO getQuizState(QuizVO vo);

	void updateSolve(QuizVO vo);

}
