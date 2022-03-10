package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {
	private int bid;
	private String bname;
	private String btitle;
	private String bcontent;
	private Date bdate;
	private int bhit;
	private int bgroup;
	private int bstep;
	private int bindent;
}
