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

	@Override
	public int insert(ReplyVO vo) {
		return mapper.insert(vo);
	}

	@Override
	public int modify(ReplyVO vo) {
		return mapper.update(vo);
	}

	@Override
	public ReplyVO get(int bid) {
		return mapper.read(bid);
	}

	@Override
	public int delete(int bid) {
		return mapper.delete(bid);
	}

}
