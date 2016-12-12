package org.dev.lam.CCTV;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/cctv")
public class CCTVController {

	@Autowired
	private CCTVService service;

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String cctvForm(Model model, Authentication authentication) {
		if (authentication != null) {
			WebAuthenticationDetails wad = (WebAuthenticationDetails) authentication.getDetails();
			model.addAttribute("sessionid", wad.getSessionId());
		}
		return "cctv/cctv";
	}

	@RequestMapping(value = "/view")
	public String cctvView(Model model, Authentication authentication) {
		if (authentication != null) {
			WebAuthenticationDetails wad = (WebAuthenticationDetails) authentication.getDetails();
			model.addAttribute("sessionid", wad.getSessionId());
			model.addAttribute("vo", service.getVO(authentication.getName()));
		}
		return "cctv/view";
	}

	@RequestMapping(value = "/authority")
	@ResponseBody
	public boolean authority(Model model, @RequestParam("id") String sessionid) {
		System.out.println("permit");
		return service.viewPermit(sessionid);
	}

	@RequestMapping(value = "/addCCTV", method = RequestMethod.GET)
	public String cctvInsert(Model model, Authentication authentication) {
		System.out.println("naaaame" + authentication.getName());
		model.addAttribute("list", service.getCCTVList(authentication.getName()));
		model.addAttribute("id", authentication.getName());
		return "cctv/addCCTV";
	}

	@RequestMapping(value = "/addCCTV", method = RequestMethod.POST)
	public String cctvInsert(Authentication authentication, @RequestParam(value = "arr[]") String[] data) {
		service.save(data);
		return "";
	}

}
