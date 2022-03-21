package org.zerock.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.ReplyVO;
import org.zerock.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies/")
@RestController
@AllArgsConstructor
@Log4j
public class RestReplyController {
	private ReplyService service;
	
	// INSERT
	@PostMapping(value="/new",
				 consumes = "application/json",
				 produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String>create(@RequestBody ReplyVO vo){
		log.info("ReplyVO : " + vo);
		
		int insertCount = service.insert(vo);
		
		log.info("Reply Insert Count : " + insertCount);
		
		return insertCount == 1
		? new ResponseEntity<>("success", HttpStatus.OK)
		: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		// 삼항 연산자 처리
	}
	
	// READ
	@GetMapping(value="/comment",
			produces = {
				MediaType.APPLICATION_XML_VALUE,
				MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<ReplyVO>>getList(){
		log.info("getList............");
		return new ResponseEntity<>(service.getList(), HttpStatus.OK);
	}
	
	// Read 개별 댓글 확인
	@GetMapping(value="/{bid}",
			produces = {MediaType.APPLICATION_XML_VALUE,
						MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyVO> get(@PathVariable("bid") int bid){
		log.info("get : " + bid);
		
		return new ResponseEntity<>(service.get(bid), HttpStatus.OK);
	}
	
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
			value = "/{bid}",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(
					@RequestBody ReplyVO vo,
					@PathVariable("bid") int bid){
		vo.setBid(bid);
		
		log.info("bid : " + bid);
		
		log.info("modify : " + vo);
		
		return service.modify(vo) == 1
					? new ResponseEntity<>("success", HttpStatus.OK)
					: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@DeleteMapping(value="/{bid}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("bid") int bid){
		log.info("remove: " + bid);
		
		return service.delete(bid) == 1
		  ? new ResponseEntity<>("success", HttpStatus.OK)
		  : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
