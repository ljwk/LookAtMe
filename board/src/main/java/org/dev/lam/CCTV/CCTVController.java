package org.dev.lam.CCTV;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/cctv")
public class CCTVController {
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String cctv(Model model) {
		return "cctv/cctv";
	}
}
