package org.zerock.start.service;

import org.zerock.game.domain.QuizVO;
import org.zerock.start.domain.MemberVO;

public interface PointService {

	void checkLogin(String id);

	void addTenPoint(String id);

	void addOnePoint(String id);

	void addPercentPoint(String id);

	void subPercentPoint(String id);

	void subFivePoint(String id);

	void addQuizPoint(QuizVO vo);

	void subPoint(MemberVO vo);

	void addPoint(MemberVO vo);

}
