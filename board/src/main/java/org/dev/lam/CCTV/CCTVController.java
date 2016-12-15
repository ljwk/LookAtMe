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
			model.addAttribute("list", service.getCCTVList(authentication.getName()));
			model.addAttribute("sessionid", wad.getSessionId());
		}
		return "cctv/viewList";
	}

	@RequestMapping(value = "/view")
	public String cctvView(Model model, Authentication authentication, @RequestParam("num") String num) {
		if (authentication != null) {
			WebAuthenticationDetails wad = (WebAuthenticationDetails) authentication.getDetails();
			model.addAttribute("sessionid", wad.getSessionId());
			model.addAttribute("vo", service.getVO(Integer.valueOf(num)));
		}
		return "cctv/view";
	}

	@RequestMapping(value = "/authority")
	@ResponseBody
	public String authority(Model model, @RequestParam("id") String sessionid, @RequestParam("ip") String ip) {
		System.out.println("permit");
		return service.getAuthority(sessionid, ip);
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
		service.getInsert(data);
		return "cctv/addCCTV";
	}

}
