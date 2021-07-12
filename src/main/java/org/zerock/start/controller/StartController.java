package org.zerock.start.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.start.domain.MemberVO;
import org.zerock.start.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/start/*")
@Log4j
public class StartController {
	
	@Setter(onMethod_ = @Autowired)
	private MemberService service;
	
	@GetMapping("/login")
	public void login() {
		log.info("loginpage");
	}
	
	@GetMapping("/acc")
	public void acc() {
		log.info("accpage");
	}
	
	@PostMapping("acc")
	public String register(MemberVO vo, RedirectAttributes rttr) {
		boolean ok = service.registerAcc(vo);
		
		if(ok) {
			return "redirect:/start/login";
		}else {
			return "redirect:/start/acc?error";
		}
	}
}
