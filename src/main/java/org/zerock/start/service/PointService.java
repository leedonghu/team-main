package org.zerock.start.service;

public interface PointService {

	void checkLogin(String id);

	void addTenPoint(String id);

	void addOnePoint(String id);

	void addPercentPoint(String id);

	void subPercentPoint(String id);

}
