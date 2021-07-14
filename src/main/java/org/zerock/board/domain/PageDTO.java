package org.zerock.board.domain;

import lombok.Data;

@Data
public class PageDTO {
	
	private Criteria cri;
	
	private int startPage;  //현재 페이지 기준 시작 페이지
	private int endPage;    //현재 페이지 기준 마지막 페이지
	
	private boolean prev;   //이전페이지 버튼 표시 유무
	private boolean next;   //다음페이지 버튼 표시 유무
	
	private int total; //총 게시물 수
	
	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		
		int current = cri.getPageNum();//현재 페이지 
		int numPerPage = cri.getAmount();//한 페이지에 보여지는 수
		
		//현재페이지 1~10이면 시작은1, 종료는 10
		this.endPage = ((current - 1) / 10 + 1)*10;
		this.startPage = endPage - 9;
		
		//실제 마지막 페이지 번호
		int realEnd = total / numPerPage;
		
		if(total % numPerPage != 0) {
			realEnd = realEnd + 1;
		}
		
		//더 작은 값이 실제 마지막 페이지번호가 되어야 함
		this.endPage = Math.min(endPage, realEnd);
		
		//이전, 다음 버튼 표시 여부
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	}
}
