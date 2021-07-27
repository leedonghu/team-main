package org.zerock.album.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.album.domain.AlbumVO;
import org.zerock.album.domain.FileVO;
import org.zerock.album.service.AlbumService;
import org.zerock.start.service.PointService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/album")
@Log4j
public class AlbumController {
	
	
	@Setter(onMethod_ = @Autowired)
	private AlbumService service;
	
	@Setter(onMethod_ = @Autowired)
	private PointService pointService;
	
	@GetMapping("/list")
	public void getList(Model model) {
		log.info("album list");
		
		List<AlbumVO> list = service.getList();
		
		model.addAttribute("list", list);
	}
	
	@GetMapping("/register")
	public void register() {
		log.info("album register");
	}
	
	@PostMapping("/register")
	public void albumRegister(AlbumVO vo, @RequestParam("files") MultipartFile[] files) {
		log.info("album post register");
		
		service.register(vo, files);
		for(MultipartFile file : files) {
			log.info(file.getOriginalFilename());
		}
		
		//album 등록시 10point
		String id = vo.getWriter();
		pointService.addTenPoint(id);
	}
	
	@PostMapping("/get/{ano}")
	@ResponseBody
	public List<String> getFile(@PathVariable("ano") int ano) {
		log.info("album get method");
		
		List<FileVO> lists = service.get(ano).getFileName();
		List<String> list = new ArrayList<>();
		
		for(FileVO vo : lists) {
			list.add(vo.getFileName());
		}
		
		return list;
				
	}
	
	@PostMapping("/getAlbum/{ano}")
	@ResponseBody
	public AlbumVO getAlbum(@PathVariable("ano") int ano) {
		log.info("album get album method");
		
		return service.get(ano);
	}
	
//	@PostMapping("/getFileName")
//	@ResponseBody
//	public void 
}
