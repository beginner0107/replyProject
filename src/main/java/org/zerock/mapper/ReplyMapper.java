package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.ReplyVO;

public interface ReplyMapper {
	public int insert(ReplyVO vo);
	public List<ReplyVO> replyList(); 
}
