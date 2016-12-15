package org.dev.lam.CCTV;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.dev.lam.Security.CustomAuthenticationProvider;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CCTVService {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public String getAuthority(String sessionid, String ip) {
		Map<String, String> online = CustomAuthenticationProvider.getOnline();
		System.out.println(sessionid);
		System.out.println(online.keySet());
		System.out.println(ip);
		if (online.containsKey(sessionid)) {
			String id = online.get(sessionid);
			CCTVDAO cctvdao = sqlSessionTemplate.getMapper(CCTVDAO.class);
			CCTVVO vo = new CCTVVO();
			vo.setId(id);
			vo.setCctvip(ip);
			vo = cctvdao.viewAuthority(vo);
			System.out.println(id);
			System.out.println(vo.getAuthority());
			
			if (vo.getAuthority().equals("ADMIN")) {
				return "true:ADMIN";
			} else if (vo.getAuthority().equals("USER")) {
				return "true:USER";
			} else {
				return "false";
			}
		} else {
			return "false";
		}
	}

	public List<CCTVVO> getCCTVList(String id) {
		CCTVDAO cctvdao = sqlSessionTemplate.getMapper(CCTVDAO.class);
		List<CCTVVO> list = cctvdao.getCCTVList(id);
		List<CCTVVO> temp = new ArrayList<>();
		
//		for(int i=0; i<list.size(); i++) {
//			System.out.println(list.get(i).getAuthority());
//			System.out.println(list.get(i).getCctvip());
//			System.out.println(list.get(i).getCctvname());
//			System.out.println(list.get(i).getId());
//			System.out.println(list.get(i).getNum());
//		}
		
		for (CCTVVO e : list) {
//			System.out.println(e.getAuthority());
			if (e.getAuthority().equals("ADMIN")) {
				Map<String, String> map = new HashMap<>();
				map.put("cctvip", e.getCctvip());
				map.put("id", e.getId());
				List<CCTVVO> addList = cctvdao.getAddList(map);
				for (CCTVVO e2 : addList) {
					temp.add(e2);
				}
			}
//			System.out.println(list.size());
		}
		
		for (CCTVVO e : temp) {
			list.add(e);
		}
		return list;
	}

	public CCTVVO getVO(int num) {
		CCTVDAO cctvdao = sqlSessionTemplate.getMapper(CCTVDAO.class);
		CCTVVO vo = cctvdao.authority(num);
		
		System.out.println(vo.getCctvip());
		System.out.println(vo.getAuthority());
		return vo;
	}

	public void getInsert(String[] data) {
		List<CCTVVO> list = convert(data);
		CCTVDAO cctvdao = sqlSessionTemplate.getMapper(CCTVDAO.class);
		System.out.println(list.size());
		for (CCTVVO e : list) {
			cctvdao.cctvInsert(e);
			System.out.println(e.getNum());
		}
	}

	private List<CCTVVO> convert(String[] data) {
		System.out.println("convert");
		List<CCTVVO> list = new ArrayList<>();
		for (String e : data) {
			if (!e.equals("")) {
				e = e.replaceAll("\"", "");
				e = e.replaceAll("\\{", "");
				e = e.replaceAll("\\}", "");

				String[] temp = e.split(",");
				CCTVVO vo = new CCTVVO();

				for (String e2 : temp) {
					String[] temp2 = e2.split(":", 2);
					switch (temp2[0]) {
					case "cctvip":
						vo.setCctvip(temp2[1]);
						break;
					case "num":
						vo.setNum(Integer.parseInt(temp2[1]));
						break;
					case "authority":
						vo.setAuthority(temp2[1]);
						break;
					case "cctvname":
						vo.setCctvname(temp2[1]);
						break;
					case "id":
						vo.setId(temp2[1]);
						break;
					}
				}
				list.add(vo);
			}
		}

		for (CCTVVO e : list) {
			System.out.println(e.getAuthority());
			System.out.println(e.getCctvip());
			System.out.println(e.getCctvname());
			System.out.println(e.getId());
			System.out.println(e.getNum());
		}
		return list;
	}

	public List<CCTVVO> getViewCCTVList(String id) {
		CCTVDAO cctvdao = sqlSessionTemplate.getMapper(CCTVDAO.class);
		List<CCTVVO> list = cctvdao.getCCTVList(id);
		return list;
	}

//	public void connectTest(String ip) {
//		try {
//			System.out.println(ip);
//			URL url = new URL("http://"+ip);
//			HttpURLConnection getconn = (HttpURLConnection)url.openConnection();
//			BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(getconn.getInputStream()));
//			System.out.println("datainputstream");
//			
//				System.out.println(bufferedReader.readLine());
//			
//		} catch (MalformedURLException e) {
//			e.printStackTrace();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//	}
}