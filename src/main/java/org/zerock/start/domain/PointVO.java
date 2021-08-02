package org.zerock.start.domain;

import java.util.Date;
import java.util.List;
import java.util.Map;

import lombok.Data;

@Data
public class PointVO {
	private int pid;
	private String userId;
	private double point;
	private List<String> pointInOut;
	
	private List<Double> pointList;
	private Date regdate;
	
	private List<Map<String, Double>> pointMap;
}
