package org.dev.lam.Notice;

import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String notice(Model model) {
		return "notice/main";
	}
}
