package org.zerock.game.mapper;

import org.zerock.game.domain.QuizVO;

public interface QuizMapper {

	QuizVO getQuiz(String today);

	void insertAtt(QuizVO vo);

	QuizVO getQuizAtt(QuizVO vo);

	void updateAtt(QuizVO vo);

	int countQuizAtt(QuizVO vo);

	void insertQuizCheck(QuizVO vo);

	void updateQuizCheck(QuizVO vo);

}
