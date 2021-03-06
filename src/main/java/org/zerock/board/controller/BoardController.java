package org.zerock.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.board.domain.BoardVO;
import org.zerock.board.domain.Criteria;
import org.zerock.board.domain.PageDTO;
import org.zerock.board.service.BoardService;
import org.zerock.start.service.PointService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")
@PreAuthorize("isAuthenticated()")
@Log4j
public class BoardController {
	
	@Setter(onMethod_ = @Autowired)
	private BoardService service;
	
	@Setter(onMethod_ = @Autowired)
	private PointService pointService;
	
	@GetMapping("/list")
	public void list(@ModelAttribute("cri") Criteria cri, Model model) {
		//파라미터로 들어가있는 Criteria는 @ModelAttribute. 즉, model에 criteria라는 이름으로 들어가있음 
		//타입명이 attribute 명이 됨
		log.info("board/list method.....");
		int total = service.getTotal(cri); //TODO : 나중에 구하는 코드 작성해야 함
		
		// service getList() 실행 결과를
		List<BoardVO> list = service.getList(cri);
		
		// model에 attribute로 넣고
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		// view로 포워드
	}
	
	@GetMapping("/register")
	public void register() {
		log.info("board register");
	}
	
	@PostMapping("/register")
	public String register(BoardVO vo, RedirectAttributes rttr) {
		//글 작성 후 db에 저장
		boolean ok = service.register(vo);
		
		//작성하면 10point증가시킴
		String id = vo.getWriter();
		pointService.addTenPoint(id, 2);
		
		// redirect 목적지로 정보 전달
		rttr.addFlashAttribute("result", vo.getBno());
		rttr.addFlashAttribute("messageTitle", "등록성공");
		rttr.addFlashAttribute("messageBody", vo.getBno()+"번 글이 등록되었습니다.");
		
		if(ok) {
			//잘 저장되면 list로 리다이렉트
			return "redirect:/board/list";
		}else {
			//잘 저장 안되면 원래 페이지로
			return "redirect:/board/register";
		}
	}
	
	@GetMapping("/get")
	public void getDetail(@ModelAttribute("cri") Criteria cri, int bno, Model model) {
		//service에게 일 시켜서 글 내용 가져오기
		BoardVO vo = service.getDetail(bno);
		
		//조회수 업데이트
		int cnt = vo.getCnt() + 1;
		vo.setCnt(cnt);
		
		service.updateCnt(vo);
		
		//조회수당 1점
		String id = vo.getWriter();
		pointService.addOnePoint(id, 4);
		
		//가져온 vo를 넘김
		model.addAttribute("board", vo);
		
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO vo, Criteria cri, RedirectAttributes rttr) {
		log.info("modify");
		
		//service에게 수정하라는 일 시킴
		boolean ok = service.modify(vo);
		
		if(ok) {
			rttr.addFlashAttribute("result", "success");
			rttr.addFlashAttribute("messageTitle", "수정성공");
			rttr.addFlashAttribute("messageBody", "수정되었습니다.");
		}
		
		return "redirect:/board/list";
	}
	
	@PostMapping("/remove")
	public String remove(BoardVO vo, Criteria cri, RedirectAttributes rttr) {
		log.info("board remove");
		
		boolean ok = service.remove(vo);
		
		if(ok) {
			rttr.addFlashAttribute("result", "success");
			rttr.addFlashAttribute("messageTitle", "삭제성공");
			rttr.addFlashAttribute("messageBody", "삭제되었습니다.");
		}
		
		return "redirect:/board/list";
	}
}
