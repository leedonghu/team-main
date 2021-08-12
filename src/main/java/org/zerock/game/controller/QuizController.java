package org.zerock.game.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
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
@PreAuthorize("isAuthenticated()")
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
		
		
		//퀴즈풀기 창에만 있을때 상태 insert
		//contact를 1로 업데이트
		service.insertState(vo2);
		
		QuizVO vo3 = service.getQuizState(vo2);
		vo3.setAns(vo.getAns());
		vo3.setDate(vo.getDate());
		vo3.setQue(vo.getQue());
		if(vo3.getState() == 1) {
			
			model.addAttribute("state", vo3);
			model.addAttribute("quiz", vo);
			return "quiz/get";
		}else if(vo3.getState() == 2) {
			model.addAttribute("quiz", vo3);
			return "quiz/get-1";
		}else {
			model.addAttribute("quiz", vo3);
			return "quiz/get-2";
		}
		
	}
	
	@PostMapping("/att")
	@ResponseBody
	public void attQuiz(@RequestBody QuizVO vo) {
		//문제풀기를 도전했을때 enabled를 0으로 바꿈
		vo.setClick(1);
		//문제풀기 상태 업데이트
		service.updateClick(vo);
		
		log.info("attQuiz--------------------------");
		
		
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
			vo.setSolve(1);
			service.updateSolve(vo);
			log.info("--------------------chekc------------");
			return true;
		}else {
			log.info("--------------------unchekc------------");
			return false;
		}
	}
	
	@PostMapping("/prac")
	@ResponseBody
	public int prac(@RequestBody QuizVO vo) {
		int point = vo.getPoint();
		return point + 1;
	}
	
}
