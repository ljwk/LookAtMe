package org.dev.lam.Board;

import java.io.*;
import java.util.*;
import javax.servlet.http.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/free")
public class BoardController {

	@Autowired
	private BoardService svc;

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main(@RequestParam(value = "page", defaultValue = "1") int page, @RequestParam(value = "rpp", defaultValue = "10") int rpp, Model model) {
		model.addAttribute("list", svc.getList(page, rpp));
		model.addAttribute("page", page);
		model.addAttribute("rpp", rpp);
		return "board/main";
	}
	
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public String getList2(@RequestParam(value = "page", defaultValue = "1") int page, @RequestParam(value = "rpp", defaultValue = "10") int rpp, Model model) {
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
	public Map<String, String> add(BoardVO board, BindingResult result) {
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

				File newFile = new File("F:/test/upload/" + tmpName);
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
	public Map<String, Boolean> delete(@RequestParam("num") int num, Model model) {
		Map<String, Boolean> map = new HashMap<>();
		boolean ok = svc.boardDelete(num);
		map.put("success", ok);
		return map;
	}

	@RequestMapping(value = "/modi", method = RequestMethod.GET)
	public String modi(@RequestParam("num") int num, Model model) {
		model.addAttribute("num", num);
		return "board/modi";
	}

	@RequestMapping(value = "/modisave", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> modisave(BoardVO board) {
		Map<String, String> map = new HashMap<>();
		boolean ok = svc.modi(board);
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
	public Map<String, String> re(BoardVO board) {
		Map<String, String> map = new HashMap<>();
		boolean ok = svc.addInsert(board);
		map.put("success", ok + "");
		map.put("num", svc.getNum(board.getId()) + "");
		svc.hitCnt(board.getNum());
		return map;
	}

	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public String search(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "rpp", defaultValue = "10") int rpp, @RequestParam("search") String search,
			@RequestParam("searchContents") String searchContents, Model model) {
		if (search.equals("번호")) {
			model.addAttribute("list", svc.getNumSearchList(page, rpp, searchContents));
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
		File file = new File("F:/test/upload/" + filename);
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
