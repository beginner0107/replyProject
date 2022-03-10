package org.zerock.controller;

import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.zerock.service.ReplyService;

import lombok.Setter;

@Controller
public class ReplyController {
	
	@Setter(onMethod = @__(@Autowired))
	private ReplyService service;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		model.addAttribute("list", service.getList());
		
		return "home";
	}
	
}
