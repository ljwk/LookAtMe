package org.dev.lam.Board;

import java.util.*;
import org.apache.ibatis.annotations.*;

public interface BoardDAO {
	public List<BoardVO> list(@Param("page")int page,@Param("rpp")int rpp);
	public int insert(BoardVO board);
	public BoardVO desc(int num);
	public int num1(String id);
	public void hitCnt(int num);
	public int boardDelete(int num);
	public int modi(BoardVO board);
	public int reinsert(BoardVO board);
	public List<BoardVO> numList(@Param("page")int page,@Param("rpp")int rpp, @Param("searchContents")String searchContents);
	public List<BoardVO> titleList(@Param("page")int page,@Param("rpp")int rpp, @Param("searchContents")String searchContents);
	public List<BoardVO> idList(@Param("page")int page,@Param("rpp")int rpp, @Param("searchContents")String searchContents);
	public List<BoardVO> ContList(@Param("page")int page,@Param("rpp")int rpp, @Param("searchContents")String searchContents);
	public int fileadd(BoardVO board);
	public BoardVO fileDesc(int num);	
}