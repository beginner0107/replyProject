package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.ReplyMapper;

import lombok.Setter;

@Service
public class ReplyServiceImpl implements ReplyService{

	@Setter(onMethod = @__(@Autowired))
	private ReplyMapper mapper;
	
	@Override
	public List<ReplyVO> getList() {
		return mapper.replyList();
	}

}
