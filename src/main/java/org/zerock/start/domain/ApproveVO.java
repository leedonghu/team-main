package org.zerock.start.domain;

import lombok.Data;

@Data
public class ApproveVO {
	
	private int state;
	private String reqId;
	private String appId;
	
	private int size;
}
