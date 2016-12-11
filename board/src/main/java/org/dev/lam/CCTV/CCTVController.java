package org.dev.lam.CCTV;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
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
			model.addAttribute("vo",service.getVO(authentication.getName()));
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
		return "cctv/addCCTV";
	}
	
	@RequestMapping(value = "/addCCTV", method = RequestMethod.POST)
	public String cctvInsert(Authentication authentication, @RequestParam(value = "arr[]") String[] data) {
		service.save(data);
		return "";
	}

	// @RequestMapping(value = "/test")
	// public void image() {
	// DataInputStream input = null;
	// Socket socket = null;
	// ServerSocket serverSocket = null;
	//
	// try {
	// serverSocket = new ServerSocket(8088);
	// serverSocket.setSoTimeout(1000 /* milliseconds */);
	// while (true) {
	// do {
	// try {
	// System.out.println("¥Î±‚");
	// socket = serverSocket.accept();
	// } catch (final SocketTimeoutException e) {
	// System.out.println("è≥");
	// }
	// } while (socket == null);
	//
	// System.out.println(socket);
	//
	// URL url = new URL("http://192.168.2.26:8083/");
	// URLConnection getconn = url.openConnection();
	// input = new DataInputStream(getconn.getInputStream());
	//
	// imageThread(socket, input);
	// socket = null;
	// // serverSocket.close();
	// }
	// } catch (MalformedURLException e) {
	// e.printStackTrace();
	// } catch (IOException e) {
	// e.printStackTrace();
	// }
	// }
	//
	// private void imageThread(Socket socket, DataInputStream input) {
	// new Thread(new Runnable() {
	// @Override
	// public void run() {
	// try {
	// DataOutputStream output = null;
	// output = new DataOutputStream(socket.getOutputStream());
	//
	// while (true) {
	// byte by= input.readByte();
	// System.out.println(input.readByte());
	// output.write(by);
	// output.flush();
	// }
	// } catch (IOException e) {
	// e.printStackTrace();
	// } finally {
	// try {
	// socket.close();
	// input.close();
	// } catch (IOException e) {
	// e.printStackTrace();
	// }
	// }
	// }
	// }).start();
	// }
	//
}
