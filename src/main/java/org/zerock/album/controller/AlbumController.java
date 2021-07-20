package org.zerock.album.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.album.domain.AlbumVO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/album")
@Log4j
public class AlbumController {
	
	
	@GetMapping("/list")
	public void getList() {
		log.info("album list");
	}
	
	@GetMapping("/register")
	public void register() {
		log.info("album register");
	}
	
	@PostMapping("/register")
	public void albumRegister(AlbumVO vo, MultipartFile[] file) {
		log.info("album post register");
		
		for(MultipartFile files : file) {
			log.info(files.getOriginalFilename());
		}
	}
}
