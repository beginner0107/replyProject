package org.zerock.service;

import java.util.List;

import org.zerock.domain.ReplyVO;

public interface ReplyService {
	public int insert(ReplyVO vo);
	public List<ReplyVO> getList();
	public int modify(ReplyVO vo);
	public ReplyVO read(int bid);
	public int delete(int bid);
}
