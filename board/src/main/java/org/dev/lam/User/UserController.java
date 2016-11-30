package org.dev.lam.User;

import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	private UserService svc;
	
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String join1(@RequestParam("email") String email, Model model) {
		model.addAttribute("email", email);
		return "home/join";			
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Boolean> join2(UserVO vo, @RequestParam("email") String email, Model model) {
		model.addAttribute("email", email);
		boolean ok = svc.add(vo);
		Map<String, Boolean> map = new HashMap<>();
		map.put("success", ok);
		return map;	
	}
	
	@RequestMapping(value = "/chk", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Boolean> chk(@RequestParam("id") String id, Model model) {		
		Map<String, Boolean> map = new HashMap<>();
		boolean ok = svc.chkId(id);
		map.put("success", ok);
		return map;		
	}
}
