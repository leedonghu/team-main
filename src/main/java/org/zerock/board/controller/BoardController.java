package org.zerock.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.board.domain.BoardVO;
import org.zerock.board.service.BoardService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")
@Log4j
public class BoardController {
	
	@Setter(onMethod_ = @Autowired)
	private BoardService service;
	
	@GetMapping("/list")
	public void list(Model model) {
		log.info("list");
		//게시판 리스트 가져오기
		List<BoardVO> list = service.getList();
		//리스트를 모델에 담아서 보내기
		model.addAttribute("list", list);
	}
	
	@GetMapping("/register")
	public void register() {
		log.info("board register");
	}
	
	@PostMapping("/register")
	public String register(BoardVO vo) {
		//글 작성 후 db에 저장
		boolean ok = service.register(vo);
		
		if(ok) {
			//잘 저장되면 list로 리다이렉트
			return "redirect:/board/list";
		}else {
			//잘 저장 안되면 원래 페이지로
			return "redirect:/board/register";
		}
	}
}
