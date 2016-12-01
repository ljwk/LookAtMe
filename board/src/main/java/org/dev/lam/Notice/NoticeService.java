package org.dev.lam.Notice;

import java.io.*;
import java.util.*;
import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

@Service
public class NoticeService {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List<NoticeVO> getList(int page, int rpp) {
		NoticeDAO dao = sqlSessionTemplate.getMapper(NoticeDAO.class);
		List<NoticeVO> list = dao.list(page, rpp);
		return list;
	}
	
	public boolean boardInsert(NoticeVO board) {
		NoticeDAO dao = sqlSessionTemplate.getMapper(NoticeDAO.class);
		int n = dao.insert(board);
		int num = dao.num1(board.getId());
		board.setNum(num);
		dao.fileadd(board);
		
		return n > 0 ? true : false;
	}
	
	public boolean boardInsert1(NoticeVO board) {
		NoticeDAO dao = sqlSessionTemplate.getMapper(NoticeDAO.class);
		int n = dao.insert(board);
		
		return n > 0 ? true : false;
	}

	public NoticeVO getDesc(int num) {
		NoticeDAO dao = sqlSessionTemplate.getMapper(NoticeDAO.class);
		NoticeVO board = dao.desc(num);
		NoticeVO fBoard = dao.fileDesc(num);
		if(fBoard==null){
			return board;
		}
		fBoard.setEmail(board.getEmail());
		return fBoard;
	}

	public int getNum(String id) {
		NoticeDAO dao = sqlSessionTemplate.getMapper(NoticeDAO.class);
		int num = dao.num1(id);
		return num;
	}

	public void hitCnt(int num) {
		NoticeDAO dao = sqlSessionTemplate.getMapper(NoticeDAO.class);
		dao.hitCnt(num);
	}

	public boolean boardDelete(int num) {
		NoticeDAO dao = sqlSessionTemplate.getMapper(NoticeDAO.class);
		int n = dao.boardDelete(num);
		return n > 0 ? true : false;
	}

	public boolean modi(NoticeVO board) {
		NoticeDAO dao = sqlSessionTemplate.getMapper(NoticeDAO.class);
		int n = dao.modi(board);
		return n > 0 ? true : false;
	}

	public boolean addInsert(NoticeVO board) {
		NoticeDAO dao = sqlSessionTemplate.getMapper(NoticeDAO.class);
		int n = dao.reinsert(board);
		return n > 0 ? true : false;
	}

	public List<NoticeVO> getNumSearchList(int page, int rpp, String searchContents) {
		NoticeDAO dao = sqlSessionTemplate.getMapper(NoticeDAO.class);
		List<NoticeVO> list = dao.numList(page, rpp, searchContents);
		return list;
	}

	public List<NoticeVO> getTitleSearchList(int page, int rpp, String searchContents) {
		NoticeDAO dao = sqlSessionTemplate.getMapper(NoticeDAO.class);
		List<NoticeVO> list = dao.titleList(page, rpp, searchContents);
		return list;
	}

	public List<NoticeVO> getIdSearchList(int page, int rpp, String searchContents) {
		NoticeDAO dao = sqlSessionTemplate.getMapper(NoticeDAO.class);
		List<NoticeVO> list = dao.idList(page, rpp, searchContents);
		return list;
	}

	public List<NoticeVO> getContentsSearchList(int page, int rpp, String searchContents) {
		NoticeDAO dao = sqlSessionTemplate.getMapper(NoticeDAO.class);
		List<NoticeVO> list = dao.ContList(page, rpp, searchContents);
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
