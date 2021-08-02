package org.zerock.start.service;

import org.zerock.game.domain.QuizVO;
import org.zerock.start.domain.MemberVO;
import org.zerock.start.domain.PointVO;

public interface PointService {

	void checkLogin(String id);

	void addTenPoint(String id, int pointCode);

	void addOnePoint(String id, int pointCode);

	void addPercentPoint(String id);

	void subPercentPoint(String id);

	void subFivePoint(String id);

	void addQuizPoint(QuizVO vo);

	void subPoint(MemberVO vo, int pointCode);

	void addPoint(MemberVO vo, int pointCode);

	PointVO getPointInfo(String id);

}
