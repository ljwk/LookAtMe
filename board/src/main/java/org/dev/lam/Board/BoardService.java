package org.dev.lam.Board;

import java.io.*;
import java.util.*;
import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

@Service
public class BoardService {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public List<BoardVO> getList(int page, int rpp) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		List<BoardVO> list = dao.list(page, rpp);
		return list;
	}

	public boolean boardInsert(BoardVO board) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		int n = dao.insert(board);
		int num = dao.num1(board.getId());
		board.setNum(num);
		dao.fileadd(board);
		
		return n > 0 ? true : false;
	}
	
	public boolean boardInsert1(BoardVO board) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		int n = dao.insert(board);
		
		return n > 0 ? true : false;
	}

	public BoardVO getDesc(int num) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		BoardVO board = dao.desc(num);
		BoardVO fBoard = dao.fileDesc(num);
		if(fBoard==null){
			return board;
		}
		fBoard.setEmail(board.getEmail());
		return fBoard;
	}

	public int getNum(String id) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		int num = dao.num1(id);
		return num;
	}

	public void hitCnt(int num) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		dao.hitCnt(num);
	}

	public boolean boardDelete(int num) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		int n = dao.boardDelete(num);
		return n > 0 ? true : false;
	}
	
	public boolean modi(BoardVO board) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		int n = dao.modi(board);
		int num = dao.num1(board.getId());
		board.setNum(num);
		dao.fileupdate(board);
		return n > 0 ? true : false;
	}

	public boolean modi1(BoardVO board) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		int n = dao.modi(board);
		return n > 0 ? true : false;
	}
	
	public boolean addInsert(BoardVO board) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		int n = dao.reinsert(board);
		int num = dao.num1(board.getId());
		board.setNum(num);
		dao.fileadd(board);
		
		return n > 0 ? true : false;
	}
	
	public boolean addInsert1(BoardVO board) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		int n = dao.reinsert(board);
		return n > 0 ? true : false;
	}	

	public List<BoardVO> getNumSearchList(int page, int rpp, String searchContents) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		List<BoardVO> list = dao.numList(page, rpp, searchContents);
		return list;
	}

	public List<BoardVO> getTitleSearchList(int page, int rpp, String searchContents) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		List<BoardVO> list = dao.titleList(page, rpp, searchContents);
		return list;
	}

	public List<BoardVO> getIdSearchList(int page, int rpp, String searchContents) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		List<BoardVO> list = dao.idList(page, rpp, searchContents);
		return list;
	}

	public List<BoardVO> getContentsSearchList(int page, int rpp, String searchContents) {
		BoardDAO dao = sqlSessionTemplate.getMapper(BoardDAO.class);
		List<BoardVO> list = dao.ContList(page, rpp, searchContents);
		return list;
	}

	public boolean isValid(String fname){
		File dir = new File("F:/test/upload");
		//경로에 있는 모든 파일을 불러옴
		String[] names = dir.list();
		if(names==null || names.length==0){
			return true;
		}
		for(int i=0;i<names.length;i++){
			if(names[i].equals(fname)){
				return false;
			}
		}
		return true;
	}
	
}
