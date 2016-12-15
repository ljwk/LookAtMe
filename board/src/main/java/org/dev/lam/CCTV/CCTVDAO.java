package org.dev.lam.CCTV;

import java.util.List;
import java.util.Map;

public interface CCTVDAO {

	public List<CCTVVO> getCCTVList(String id);

	public CCTVVO authority(int num);

	public int cctvInsert(CCTVVO vo);
	
	public CCTVVO viewAuthority(CCTVVO vo);
	
	public List<CCTVVO> getAddList(Map<String, String> map);
}
