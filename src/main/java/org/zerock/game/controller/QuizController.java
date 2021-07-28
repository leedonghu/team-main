package org.zerock.game.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.game.domain.QuizVO;
import org.zerock.game.service.QuizService;
import org.zerock.start.service.PointService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/quiz")
@Log4j
public class QuizController {
	
	@Setter(onMethod_ = @Autowired)
	private QuizService service;
	
	@Setter(onMethod_ = @Autowired)
	private PointService pointService;
	
	@GetMapping("/get")
	public String getQuiz(Model model, Principal principal, RedirectAttributes rttr) {
		log.info("get quiz");
		
		//문제를 푸는 사람의 id
		String userId = principal.getName();
		
		//db에서 저장되어있는 문제를 가져옴
		QuizVO vo = service.getQuiz();
		int qid = vo.getQid();
		
		//새로운 vo를 만들고 userId와 qid를 넣어줌
		QuizVO vo2 = new QuizVO();
		
		vo2.setUserId(userId);
		vo2.setQid(qid);
		vo2.setPoint(0);
		
		//퀴즈풀기 창에만 있을때 상태 insert
		service.insertAtt(vo2);
		
		//퀴즈를 시도한적이(문제풀기 버튼 눌름) 있는지 확인
		QuizVO vo3 = service.getQuizAtt(vo2);
		int quizAtt = vo3.getEnabled();
		
		
		if(quizAtt == 1) {
			//시도하지 않았으면 원래 jsp로 forward
			model.addAttribute("quiz", vo);
			return "quiz/get";
		}else {
			
			//service.get
			
			return "quiz/get-1";
		}
	}
	
	@PostMapping("/att")
	@ResponseBody
	public void attQuiz(@RequestBody QuizVO vo) {
		//문제풀기를 도전했을때 enabled를 0으로 바꿈
		vo.setEnabled(0);
		//문제풀기 상태 업데이트
		service.updateAtt(vo);
		
		String id = vo.getUserId();
		pointService.subFivePoint(id);
	}
	
	@PostMapping("/checkAns")
	@ResponseBody
	public boolean checkAns(@RequestBody QuizVO vo, Principal principal) {
		//문제의 답을 받아와서 빈 공백 제거
		QuizVO oriVo = service.getQuiz();
		String ans = oriVo.getAns();
		String result = ans.replaceAll("\\s+", "");
		log.info(result);
		
		//quiz_check에 업데이트 하기 위해(문제를 풀었는지 체크)
		String id = principal.getName();
		vo.setUserId(id);
		
		//입력받은 답
		String userAns = vo.getAns();
		
		
		
		//실제 답과 입력받은 답을 비교
		if(result.equals(userAns)) {
			service.updateQuiz(vo);
			log.info("--------------------chekc------------");
			return true;
		}else {
			log.info("--------------------unchekc------------");
			return false;
		}
	}
}
