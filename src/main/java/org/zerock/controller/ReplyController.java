package org.zerock.controller;

import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zerock.domain.ReplyVO;
import org.zerock.service.ReplyService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class ReplyController {
	
	@Setter(onMethod = @__(@Autowired))
	private ReplyService service;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		model.addAttribute("list", service.getList());
		
		return "home";
	}
	
	@RequestMapping(value="/register", method = RequestMethod.POST)
	public String register(ReplyVO vo) {
		log.info("vo : " + vo);
		int insert = service.insert(vo);
		if(insert == 1) {
			return "redirect:/";
		}else {
			return "/";
		}
	}
	
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	@ResponseBody
	public ReplyVO read(int bid) {
		ReplyVO vo = service.read(bid);
		return vo;
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(ReplyVO vo) {
		log.info("update VO : " + vo);
		int modify = service.modify(vo);
		return modify==1?"redirect:/" : "/";
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public void delete(int bid) {
		service.delete(bid);
	}
	
}
