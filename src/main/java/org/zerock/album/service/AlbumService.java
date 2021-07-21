package org.zerock.album.service;

import org.springframework.web.multipart.MultipartFile;
import org.zerock.album.domain.AlbumVO;

public interface AlbumService {

	void register(AlbumVO vo, MultipartFile[] files);

}
