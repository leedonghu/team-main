package org.zerock.start.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.WebAttributes;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	@PostMapping("/acc")
	public String register(MemberVO vo) {
		log.info("post acc");
		
		boolean ok = service.registerAcc(vo);
		
		if(ok) {
			return "redirect:/start/login";
		}else {
			return "redirect:/start/acc";
		}
	}
	
	@RequestMapping("/main")
	public void main() {
		log.info("main");
	}
	
	@RequestMapping("/fail")
	public void fail(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
        String errorMessage = null;
        if (session != null) {
            AuthenticationException ex = (AuthenticationException) session
                    .getAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
            if (ex != null) {
                errorMessage = ex.getMessage();
                ex.printStackTrace();
                log.info(ex.getCause());
            }
        }
        model.addAttribute("errorMessage", errorMessage);
        log.info(errorMessage);
        
		
	}
	
	@ResponseBody
	@PostMapping("/checkId")
	public String checkId(String userId) {
		//
		boolean ok = service.checkId(userId);
		String idForm = "^[a-zA-Z0-9]{5,10}$";
		if(ok) {
			return "not ok";
		}else {
			if(userId.matches(idForm)) {
				return "ok";
			}else {
				return "not good";
			}
		}
	}
	
	@ResponseBody
	@PostMapping("/checkPassword")
	public String checkPassword(String userPw) {
		String passwordForm = "^[a-zA-Z0-9]{8,14}$";
		if(userPw.matches(passwordForm)) {
			return "good";
		}else {
			return "";
		}
	}
	
	@GetMapping("/info")
	public void getInfo(String userId, Model model) {
		MemberVO vo = service.getInfo(userId);
		
		model.addAttribute("member", vo);
	}
	
//	@PostMapping("/acc")
//	public String register() {
//		log.info("post acc");
//		return null;
//	}
}
