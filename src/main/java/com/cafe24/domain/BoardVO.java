package com.cafe24.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {

	private Long bno;
	private String title;
	private String id;
	private Date reg_date;
	private int cnt;
	private int good;
	
}
