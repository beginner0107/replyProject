package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.ReplyVO;

public interface ReplyMapper {
	public int insert(ReplyVO vo);
	public List<ReplyVO> replyList(); 
	public ReplyVO read(int bid);
	public int update(ReplyVO vo);
	public int delete(int bid);
}
