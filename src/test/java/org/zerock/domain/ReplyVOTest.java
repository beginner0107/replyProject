package org.zerock.domain;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyVOTest {
	@Setter(onMethod = @__(@Autowired))
	private ReplyVO vo;
	
	@Test
	public void replyVOTest() {
		log.info("replyVOTest...... 시작");
		
		log.info(vo);
		
		log.info("replyVOTest......  끝");
	}
}
