package org.zerock.album.mapper;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;
import org.zerock.album.domain.AlbumVO;
import org.zerock.album.domain.FileVO;

public interface AlbumMapper {

	void registerAlbum(AlbumVO vo);

	

	void registerFile(FileVO fvo);



	List<AlbumVO> getList();



	AlbumVO get(int ano);

}
