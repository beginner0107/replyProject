package org.zerock.mapper;

import java.util.List;
import java.util.ListIterator;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Log4j
public class ReplyMapperTest {
	@Setter(onMethod = @__(@Autowired))
	private ReplyMapper mapper;
	
	@Test
	public void insertTest() {
		log.info("INSERT 테스트 시작.....");
		
		ReplyVO vo = new ReplyVO();
		vo.setBname("스폰지밥");
		vo.setBtitle("안뇽");
		vo.setBcontent("나는 컨텐트");
		vo.setBhit(0);
		vo.setBgroup(1);
		vo.setBstep(1);
		vo.setBindent(1);
		
		int insert = mapper.insert(vo);
		
		if(insert !=0) {
			log.info("성공 : " + insert);
		}
		
		log.info("INSERT 테스트 종료.....");
	}
	
	@Test
	public void replyListTest() {
		log.info("List 테스트 시작.....");
		List<ReplyVO> replyList = mapper.replyList();
		ListIterator<ReplyVO> list = replyList.listIterator();
		
		while(list.hasNext()) {
			ReplyVO vo = list.next();
			System.out.printf("%3d | ",vo.getBid());
			if(vo.getBstep()!=0) {
				System.out.printf("%d번 댓글 %5s | ", vo.getBstep(), vo.getBname());
			}else {
				System.out.printf("%5s | " , vo.getBname());
			}
			if(vo.getBindent()!=0) {
				System.out.print("ㄴ");
				for(int i = 0; i<vo.getBindent(); i++) {
					System.out.print("-");
				}
			}
			
			System.out.println(vo.getBtitle() + " | " + vo.getBcontent() + " | " + vo.getBdate() + " | " + vo.getBgroup() + " | " + vo.getBstep());
		}
		
		log.info("List 테스트 종료.....");
	}
}
