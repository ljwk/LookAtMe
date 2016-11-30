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
			// ���� �̸�
			String fileName = board.getFile().getOriginalFilename();
			// �ߺ��˻�
			String tmpName = !svc.isValid(fileName) ? fileName + new Date().getTime() : fileName;
			// ���ϻ�����
			long filesize = board.getFile().getSize();
			// Ȯ���� ���ϱ�
			String[] sExt = fileName.split("\\.");
			String ext = sExt[1];

			board.setFilename(fileName);
			board.setFilename2(tmpName);
			board.setFilesize(filesize);
			board.setExt(ext);
			// ������ ������ ����
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
		if (search.equals("��ȣ")) {
			model.addAttribute("list", svc.getNumSearchList(page, rpp, searchContents));
		} else if (search.equals("����")) {
			model.addAttribute("list", svc.getTitleSearchList(page, rpp, searchContents));
		} else if (search.equals("�ۼ���")) {
			model.addAttribute("list", svc.getIdSearchList(page, rpp, searchContents));
		} else if (search.equals("����")) {
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

		// �ѱ��� http ����� ����� �� ���⶧���� ���ϸ��� �������� ���ڵ��Ͽ� ����� �����Ѵ�
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
