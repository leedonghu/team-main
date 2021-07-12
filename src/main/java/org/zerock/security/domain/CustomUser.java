package org.zerock.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.zerock.start.domain.MemberVO;

import lombok.Getter;
import lombok.Setter;

public class CustomUser extends User {
	
	//CustomUserDetailsService에서 건내준 정보를 받아서 씀
	@Getter
	@Setter
	private MemberVO member;
	
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
		
	}
	
	public CustomUser(MemberVO vo) {
		super(vo.getUserId(), vo.getUserPw(), vo.getAuthList().stream()
				.map(auth -> new SimpleGrantedAuthority(auth.getAuth()))
				.collect(Collectors.toList()));
		
		member = vo;
		
	}
}
