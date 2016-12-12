package org.dev.lam.CCTV;

import java.util.List;
import java.util.Map;

public interface CCTVDAO {

	public List<CCTVVO> getCCTVList(String id);

	public CCTVVO getVO(String name);

	public int save(CCTVVO vo);
	
	public List<CCTVVO> getAddList(Map<String, String> map);
}
