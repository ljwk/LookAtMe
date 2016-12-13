package org.dev.lam.Board;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@Controller
@RequestMapping("/free")
public class BoardController {
	
	@Autowired
	private BoardService svc;
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main(@RequestParam(value = "page", defaultValue = "1") int page, @RequestParam(value = "rpp", defaultValue = "10") int rpp, Model model) {
		HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
				.getRequest();
		String ip = req.getHeader("X-FORWARDED-FOR");
		if (ip == null)
			ip = req.getRemoteAddr();
		int port = req.getRemotePort();

		/*System.out.println(ip + "," + port);*/
		
		model.addAttribute("list", svc.getList(page, rpp));
		model.addAttribute("page", page);
		model.addAttribute("rpp", rpp);
		return "board/main";
	}
	
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public String list(@RequestParam(value = "page", defaultValue = "1") int page, @RequestParam(value = "rpp", defaultValue = "10") int rpp, Model model) {
		model.addAttribute("list", svc.getList(page, rpp));
		model.addAttribute("page", page);
		model.addAttribute("rpp", rpp);
		return "board/list";
	}
	
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(@RequestParam("id") String id, Model model) {
		model.addAttribute("id", id);
		return "board/add";
	}

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> save(BoardVO board, BindingResult result) {
		InputStream inputStream = null;
		OutputStream outputStream = null;
		Map<String, String> map = new HashMap<>();
		boolean ok = false;

		if (!result.hasErrors()) {
			// 파일 이름
			String fileName = board.getFile().getOriginalFilename();
			// 중복검사
			String tmpName = !svc.isValid(fileName) ? fileName + new Date().getTime() : fileName;
			// 파일사이즈
			long filesize = board.getFile().getSize();
			// 확장자 구하기
			String[] sExt = fileName.split("\\.");
			String ext = sExt[1];

			board.setFilename(fileName);
			board.setFilename2(tmpName);
			board.setFilesize(filesize);
			board.setExt(ext);
			// 파일을 서버에 저장
			try {
				inputStream = board.getFile().getInputStream();

				File newFile = new File("E:/test/upload/" + tmpName);
				if (!newFile.exists()) {
					newFile.createNewFile();
				}
				outputStream = new FileOutputStream(newFile);
				int read = 0;
				byte[] bytes = new byte[1024];

				while ((read = inputStream.read(bytes)) != -1) {
					outputStream.write(bytes, 0, read);
				}
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					inputStream.close();
					outputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			ok = svc.boardInsert(board);
		} else {
			ok = svc.boardInsert1(board);
		}
		map.put("num", svc.getNum(board.getId()) + "");
		map.put("success", ok + "");
		svc.hitCnt(board.getNum());
		return map;
	}

	@RequestMapping(value = "/desc", method = RequestMethod.GET)
	public String desc(@RequestParam("num") int num, Model model) {
		model.addAttribute("desc", svc.getDesc(num));
		svc.hitCnt(num);
		return "board/desc";
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Boolean> delete(@RequestParam("num") int num) {
		Map<String, Boolean> map = new HashMap<>();
		boolean ok = svc.boardDelete(num);
		map.put("success", ok);
		return map;
	}

	@RequestMapping(value = "/modi", method = RequestMethod.GET)
	public String modiForm(@RequestParam("num") int num, @RequestParam("id") String id, Model model, Authentication auth) {
		if (auth == null) {
			return "user/login";
		} else if (auth.getName().equals(id)) {
			model.addAttribute("num", num);
			model.addAttribute("id", id);
			return "board/modi";
		} else {
			return "user/warning";
		}
	}	

	@RequestMapping(value = "/modisave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> modisave(BoardVO board, BindingResult result) {
		InputStream inputStream = null;
		OutputStream outputStream = null;
		Map<String, String> map = new HashMap<>();
		boolean ok = false;
		
		if (!result.hasErrors()) {
			// 파일 이름
			String fileName = board.getFile().getOriginalFilename();
			// 중복검사
			String tmpName = !svc.isValid(fileName) ? fileName + new Date().getTime() : fileName;
			// 파일사이즈
			long filesize = board.getFile().getSize();
			// 확장자 구하기
			String[] sExt = fileName.split("\\.");
			String ext = sExt[1];

			board.setFilename(fileName);
			board.setFilename2(tmpName);
			board.setFilesize(filesize);
			board.setExt(ext);
			// 파일을 서버에 저장
			try {
				inputStream = board.getFile().getInputStream();

				File newFile = new File("E:/test/upload/" + tmpName);
				if (!newFile.exists()) {
					newFile.createNewFile();
				}
				outputStream = new FileOutputStream(newFile);
				int read = 0;
				byte[] bytes = new byte[1024];

				while ((read = inputStream.read(bytes)) != -1) {
					outputStream.write(bytes, 0, read);
				}
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					inputStream.close();
					outputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			ok = svc.modi(board);
		} else {
			ok = svc.modi1(board);
		}
		map.put("num", board.getNum() + "");
		map.put("success", ok + "");
		return map;
	}

	@RequestMapping(value = "/readd", method = RequestMethod.GET)
	public String readd(@RequestParam("ref") int ref, Model model) {
		model.addAttribute("ref", ref);
		return "board/readd";
	}

	@RequestMapping(value = "/reple", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> re(BoardVO board, BindingResult result) {		
		InputStream inputStream = null;
		OutputStream outputStream = null;
		Map<String, String> map = new HashMap<>();

		boolean ok = false;
		
		if (!result.hasErrors()) {
			// 파일 이름
			String fileName = board.getFile().getOriginalFilename();
			// 중복검사
			String tmpName = !svc.isValid(fileName) ? fileName + new Date().getTime() : fileName;
			// 파일사이즈
			long filesize = board.getFile().getSize();
			// 확장자 구하기
			String[] sExt = fileName.split("\\.");
			String ext = sExt[1];

			board.setFilename(fileName);
			board.setFilename2(tmpName);
			board.setFilesize(filesize);
			board.setExt(ext);
			// 파일을 서버에 저장
			try {
				inputStream = board.getFile().getInputStream();

				File newFile = new File("E:/test/upload/" + tmpName);
				if (!newFile.exists()) {
					newFile.createNewFile();
				}
				outputStream = new FileOutputStream(newFile);
				int read = 0;
				byte[] bytes = new byte[1024];

				while ((read = inputStream.read(bytes)) != -1) {
					outputStream.write(bytes, 0, read);
				}
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					inputStream.close();
					outputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			ok = svc.addInsert(board);
		} else {
			ok = svc.addInsert1(board);
		}
		
		map.put("success", ok + "");
		map.put("num", svc.getNum(board.getId()) + "");
		svc.hitCnt(board.getNum());
		return map;
		
	}




	
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public String search(@RequestParam(value = "page", defaultValue = "1") int page, @RequestParam(value = "rpp", defaultValue = "10") int rpp, @RequestParam("search") String search, @RequestParam("searchContents") String searchContents, Model model) {
		if (search.equals("번호")) {
			List<BoardVO> list = svc.getNumSearchList(page, rpp, searchContents);
			   if (list.size() == 0) {
			         System.out.println("사이즈 0 ");
			           model.addAttribute("pageNum", page);
			           model.addAttribute("total", 0);
			           model.addAttribute("list", null);
			           return "board/search";
			   }
			model.addAttribute("list", list);
		} else if (search.equals("제목")) {
			model.addAttribute("list", svc.getTitleSearchList(page, rpp, searchContents));
		} else if (search.equals("작성자")) {
			model.addAttribute("list", svc.getIdSearchList(page, rpp, searchContents));
		} else if (search.equals("내용")) {
			model.addAttribute("list", svc.getContentsSearchList(page, rpp, searchContents));
		}
		model.addAttribute("search", search);
		model.addAttribute("searchContents", searchContents);
		model.addAttribute("page", page);
		model.addAttribute("rpp", rpp);
		return "board/search";
	}
	
	@RequestMapping("/download")
	@ResponseBody
	public byte[] getImage(HttpServletResponse response, @RequestParam String filename) throws IOException {
		File file = new File("E:/test/upload/" + filename);
		byte[] bytes = org.springframework.util.FileCopyUtils.copyToByteArray(file);

		// 한글은 http 헤더에 사용할 수 없기때문에 파일명은 영문으로 인코딩하여 헤더에 적용한다
		String fn = new String(file.getName().getBytes(), "iso_8859_1");

		response.setHeader("Content-Disposition", "attachment; filename=\"" + fn + "\"");
		response.setContentLength(bytes.length);
		response.setContentType("image/jpeg");

		return bytes;
	}
	
	@RequestMapping(value = "/mail", method = RequestMethod.GET)
	public String mail(@RequestParam("email") String email, Model model) {
		model.addAttribute("email", email);
		return "board/mail";
	}
	
}
