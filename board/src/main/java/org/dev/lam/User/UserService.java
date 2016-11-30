package org.dev.lam.User;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.security.crypto.bcrypt.*;
import org.springframework.stereotype.*;

@Service
public class UserService {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder; // 서블릿 설정파일에 빈으로 등록

	public boolean add(UserVO user) {
		UserDAO dao = sqlSessionTemplate.getMapper(UserDAO.class);
		// 이용자의 비밀번호를 bcrypt 알고리듬으로 암호화하여 DB에 저장한다
		String encodedPwd = passwordEncoder.encode(user.getPwd());

		user.setId(user.getId());
		user.setPwd(encodedPwd);
		user.setEnabled("1");
		user.setAuthority("USER");
		int n = dao.add(user);

		return n > 0 ? true : false;
	}

	public boolean login(UserVO user) {
		UserDAO dao = sqlSessionTemplate.getMapper(UserDAO.class);
		UserVO db = dao.getUser(user.getId());

		// 이용자가 로그인할 때 평문 비밀번호와 암호화된 비밀번호를 이용하여 비교한다
		boolean found = passwordEncoder.matches(user.getPwd(), db.getPwd());

		return found;
	}

	public boolean chkId(String id) {
		UserDAO dao = sqlSessionTemplate.getMapper(UserDAO.class);
		int n = dao.chkId(id);	

		return n == 0 ? true : false;
	}
}
