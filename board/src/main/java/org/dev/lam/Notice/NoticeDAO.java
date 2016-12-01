package org.dev.lam.Notice;

import java.util.*;
import org.apache.ibatis.annotations.*;

public interface NoticeDAO {
	public List<NoticeVO> list(@Param("page")int page,@Param("rpp")int rpp);
	public int insert(NoticeVO board);
	public NoticeVO desc(int num);
	public int num1(String id);
	public void hitCnt(int num);
	public int boardDelete(int num);
	public int modi(NoticeVO board);
	public int reinsert(NoticeVO board);
	public List<NoticeVO> numList(@Param("page")int page,@Param("rpp")int rpp, @Param("searchContents")String searchContents);
	public List<NoticeVO> titleList(@Param("page")int page,@Param("rpp")int rpp, @Param("searchContents")String searchContents);
	public List<NoticeVO> idList(@Param("page")int page,@Param("rpp")int rpp, @Param("searchContents")String searchContents);
	public List<NoticeVO> ContList(@Param("page")int page,@Param("rpp")int rpp, @Param("searchContents")String searchContents);
	public int fileadd(NoticeVO board);
	public NoticeVO fileDesc(int num);	
}
