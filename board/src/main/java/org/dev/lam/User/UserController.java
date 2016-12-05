package org.dev.lam.User;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.*;
import javax.servlet.http.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	private UserService svc;

	@RequestMapping(value = "/joinForm", method = RequestMethod.GET)
	public String join(@RequestParam(value = "auth", defaultValue = "") String auth, Model model, HttpSession session) {
		ServletContext application = session.getServletContext();
		model.addAttribute("email", application.getAttribute(auth));
		application.removeAttribute(auth);
		return "user/join";
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

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login1(Model model) {
		return "user/login";
	}

	@RequestMapping(value = "/chkResult", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Boolean> chk(@RequestParam(value = "email") String email1, HttpSession session, Model model) {
		ServletContext application = session.getServletContext();

		EmailVO email = new EmailVO();
		String receiver = email1;
		String subject = "Email 인증용 메일";

		String sId = session.getId();
		application.setAttribute(sId, email1);
		String content = "<a href='http://192.168.2.20:8081/board/user/joinForm?auth=" + sId + "'>회원가입 계속하기</a>";
		email.setReceiver(receiver);
		email.setSubject(subject);
		email.setContent(content);
		boolean result = false;
		try {
			result = svc.joinSendMail(email);
		} catch (Exception e) {
			e.printStackTrace();
		}

		Map<String, Boolean> map = new HashMap<>();
		map.put("result", result);
		return map;
	}

	@RequestMapping(value = "/send", method = RequestMethod.POST)
	public String sendMail(@RequestParam(value = "send") String sender,
			@RequestParam(value = "receiver1") String receiver1, @RequestParam(value = "title") String title,
			@RequestParam(value = "contents") String contents) throws Exception {

		EmailVO email = new EmailVO();

		String receiver = receiver1; // Receiver.
		String subject = title;
		String content = contents;

		email.setReceiver(receiver);
		email.setSubject(subject);
		email.setContent(content);
		svc.sendMail(email, sender);

		return "redirect:/free/main";
	}

	@RequestMapping(value = "/info", method = RequestMethod.GET)
	public String info(@RequestParam("id") String id, Model model) {
		model.addAttribute("info", svc.getInfo(id));
		return "user/info";
	}

	@RequestMapping(value = "/drop", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Boolean> drop(@RequestParam("id") String id, Model model) {
		boolean ok = svc.drop(id);
		Map<String, Boolean> map = new HashMap<>();
		map.put("success", ok);
		return map;
	}

	@RequestMapping(value = "/modi", method = RequestMethod.GET)
	public String modi() {
		return "user/modi";
	}

	@RequestMapping(value = "/modiLogin", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Boolean> modiLogin(UserVO user) {
		Map<String, Boolean> map = new HashMap<>();
		boolean ok = svc.modiChk(user);
		map.put("success", ok);
		return map;
	}

	@RequestMapping(value = "/modiForm", method = RequestMethod.GET)
	public String modiForm(@RequestParam("id") String id, Model model) {
		model.addAttribute("info", svc.getInfo(id));
		return "user/modiForm";
	}

	@RequestMapping(value = "/pwdModi", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Boolean> pwdModi(UserVO user) {
		Map<String, Boolean> map = new HashMap<>();
		boolean ok = svc.modiPwd(user);
		map.put("success", ok);
		return map;
	}

	@RequestMapping(value = "/emailModi", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Boolean> emailModi(UserVO user) {
		Map<String, Boolean> map = new HashMap<>();
		boolean ok = svc.modiEmail(user);
		map.put("success", ok);
		return map;
	}

	@RequestMapping(value = "/findID", method = RequestMethod.GET)
	public String findID(Model model) {
		return "user/findId";
	}

	@RequestMapping(value = "/findPWD", method = RequestMethod.GET)
	public String findPWD(Model model) {
		return "user/findPwd";
	}

	@RequestMapping(value = "/searchId", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, List<String>> searchId(@RequestParam("email") String email) {
		Map<String, List<String>> map = new HashMap<>();
		List<UserVO> list = svc.searchId(email);
		List<String> idList = new ArrayList<>();
		for (int i = 0; i < list.size(); i++) {
			idList.add(list.get(i).getId());
		}
		map.put("list", idList);
		return map;
	}

	@RequestMapping(value = "/searchPwd", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Boolean> searchPwd(@RequestParam("email") String email1, @RequestParam(value = "id") String id, HttpSession session) {
		ServletContext application = session.getServletContext();

		EmailVO email = new EmailVO();
		String receiver = email1;
		String subject = "비밀번호 변경 메일";

		String sId = session.getId();
		application.setAttribute(sId, id);
		String content = "<a href='http://192.168.2.20:8081/board/user/pwdForm?auth=" + sId + "'>비밀번호변경 계속하기</a>";
		email.setReceiver(receiver);
		email.setSubject(subject);
		email.setContent(content);
		boolean ok = false;
		try {
			ok = svc.searchPwd(email);
		} catch (Exception e) {
			e.printStackTrace();
		}

		Map<String, Boolean> map = new HashMap<>();
		map.put("success", ok);
		return map;
	}

	@RequestMapping(value = "/pwdForm", method = RequestMethod.GET)
	public String pwdForm(@RequestParam(value = "auth", defaultValue = "") String auth, Model model,
			HttpSession session) {
		ServletContext application = session.getServletContext();
		model.addAttribute("id", application.getAttribute(auth));
		application.removeAttribute(auth);
		return "user/pwdForm";
	}
	
	@RequestMapping(value = "/change", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Boolean> change(UserVO user) {
		Map<String, Boolean> map = new HashMap<>();
		boolean ok = svc.change(user);
		map.put("success", ok);
		return map;
	}

}
