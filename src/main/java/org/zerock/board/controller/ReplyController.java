package org.zerock.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.board.domain.ReplyVO;
import org.zerock.board.domain.Reply_ReplyVO;
import org.zerock.board.service.ReplyService;
import org.zerock.start.service.PointService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/reply")
@PreAuthorize("isAuthenticated()")
@Log4j
public class ReplyController {
	
	@Setter(onMethod_ = @Autowired)
	private ReplyService service;
	
	@Setter(onMethod_ = @Autowired)
	private PointService pointService;
	
	@GetMapping("/list/{bno}")
	public List<ReplyVO> getList(@PathVariable("bno") int bno) {
		return service.getList(bno);
		
		
	}
	
	@GetMapping("/list-list/{rno}")
	public List<Reply_ReplyVO> getReplyList(@PathVariable("rno") int rno){
		return service.getReply_ReplyList(rno);
	}
	
	@PostMapping("/register")
	public void register(@RequestBody ReplyVO vo) {
		log.info("reply register");
		
		service.register(vo);
		//댓글 입력시
		String id = vo.getReplyer();
		pointService.addOnePoint(id, 5);
	}
	
	@PostMapping("/reply-register")
	public void reply_register(@RequestBody Reply_ReplyVO vo) {
		log.info("reply reply-register");
		
		service.reply_register(vo);
		
		//대댓글 입력시 1point
		String id = vo.getR_replyer();
		pointService.addOnePoint(id, 6);
	}
	
	@PostMapping("/good/{rno}")
	public void good(@PathVariable("rno") int rno) {
		log.info("reply good");
		log.info(rno);
		
		ReplyVO vo = service.getReply(rno);
		int good = vo.getGood() + 1;
		vo.setGood(good);
		
		service.goodUpdate(vo);
		
		//좋아요 하나당 0.1point
		String id = vo.getReplyer();
		pointService.addPercentPoint(id);
	}
	
	@PostMapping("/bad/{rno}")
	public void bad(@PathVariable("rno") int rno) {
		log.info("reply bad");
		log.info(rno);
		
		ReplyVO vo = service.getReply(rno);
		int good = vo.getBad() + 1;
		vo.setBad(good);
		
		service.badUpdate(vo);
		
		//싫어요 하나당 -0.1 point
		String id = vo.getReplyer();
		pointService.subPercentPoint(id);
	}
}
