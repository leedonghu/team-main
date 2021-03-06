package org.zerock.album.service;

import java.io.File;
import java.io.InputStream;
import java.nio.file.Path;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.album.domain.AlbumVO;
import org.zerock.album.domain.FileVO;
import org.zerock.album.mapper.AlbumMapper;
import org.zerock.start.domain.MemberVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import software.amazon.awssdk.auth.credentials.ProfileCredentialsProvider;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.profiles.ProfileFile;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service
@Log4j
public class AlbumServiceImpl implements AlbumService {
	
	private String bucketName;
	private String profileName;
	private S3Client s3;
	
	@Setter(onMethod_ = @Autowired)
	private AlbumMapper mapper;
	
	public AlbumServiceImpl() {
		this.bucketName = "choongang-donghu";
		this.profileName = "spring1";
		
		/*  
		 * create
		 *  /home/tomcat/.aws/credentials
		 */
		
		Path contentLocation = new File(System.getProperty("user.home") + "/.aws/credentials").toPath();
		ProfileFile pf = ProfileFile.builder()
				.content(contentLocation)
				.type(ProfileFile.Type.CREDENTIALS)
				.build();
		ProfileCredentialsProvider pcp = ProfileCredentialsProvider.builder()
				.profileFile(pf)
				.profileName(profileName)
				.build();
		
		this.s3 = S3Client.builder()
				.credentialsProvider(pcp)
				.build();
	}

	@Override
	@Transactional
	public void register(AlbumVO vo, MultipartFile[] files) {
		log.info("album register service");
		//계시물 등록
		mapper.registerAlbum(vo);
		
		//파일 업로드
		for(MultipartFile file : files) {
			if(!file.getOriginalFilename().isEmpty()) {
				FileVO fvo = new FileVO();
				fvo.setAno(vo.getAno());
				fvo.setFileName(file.getOriginalFilename());
				
				mapper.registerFile(fvo);
				upload(vo, file);
			}
		}
		
	}
	

	private void upload(AlbumVO vo, MultipartFile file) {
		
		try(InputStream is = file.getInputStream()){
			
			PutObjectRequest objectRequest = PutObjectRequest.builder()
					.bucket(bucketName)
					.key(vo.getAno() + "/" + file.getOriginalFilename())
					.contentType(file.getContentType())
					.acl(ObjectCannedACL.PUBLIC_READ)
					.build();
			
			s3.putObject(objectRequest, 
					RequestBody.fromInputStream(is, file.getSize()));
		
		}catch(Exception e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public List<AlbumVO> getList() {
		log.info("album service list");
		
		return mapper.getList();
		
	}

	@Override
	public AlbumVO get(int ano) {
		
		return mapper.get(ano);
	}

	@Override
	@Transactional
	public void registerProfile(MemberVO vo, MultipartFile file) {
		//s3에 올라가는 이미지의 이름을 profile로 저장
		//확장자부분을 잘라서 fileName에 붙여줌
//		String oriFileName = file.getOriginalFilename();
//		int index = oriFileName.lastIndexOf(".");
//		String extension = oriFileName.substring(index);
		
		log.info("registerprofile!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		
		String fileName = "profile"; // + extension;
		vo.setFileName(fileName);
		
		int exist = mapper.existFile(vo);
		
		if(exist == 0) {
			log.info("사진없어!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
			mapper.registerProfile(vo);
			profileUpload(vo, file);
		}else {
			mapper.updateProfile(vo);
			profileUpload(vo, file);
		}
		
	}
	
	private void profileUpload(MemberVO vo, MultipartFile file) {
		
		try(InputStream is = file.getInputStream()){
			
			PutObjectRequest objectRequest = PutObjectRequest.builder()
					.bucket(bucketName)
					.key(vo.getUserId() + "/" + vo.getFileName())
					.contentType(file.getContentType())
					.acl(ObjectCannedACL.PUBLIC_READ)
					.build();
			
			s3.putObject(objectRequest, 
					RequestBody.fromInputStream(is, file.getSize()));
		
		}catch(Exception e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public List<AlbumVO> getMainList() {
		
		return mapper.getMainList();
	}
}
