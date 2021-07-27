package org.zerock.game.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.game.domain.QuizVO;
import org.zerock.game.service.QuizService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/quiz")
@Log4j
public class QuizController {
	
	@Setter(onMethod_ = @Autowired)
	private QuizService service;
	
	@GetMapping("/get")
	public void getQuiz(Model model) {
		log.info("get quiz");
		
		QuizVO vo = service.getQuiz();
		model.addAttribute("quiz", vo);
	}
}
