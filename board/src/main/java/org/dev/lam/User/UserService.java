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
	BCryptPasswordEncoder passwordEncoder; // ���� �������Ͽ� ������ ���

	public boolean add(UserVO user) {
		UserDAO dao = sqlSessionTemplate.getMapper(UserDAO.class);
		// �̿����� ��й�ȣ�� bcrypt �˰������� ��ȣȭ�Ͽ� DB�� �����Ѵ�
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

		// �̿��ڰ� �α����� �� �� ��й�ȣ�� ��ȣȭ�� ��й�ȣ�� �̿��Ͽ� ���Ѵ�
		boolean found = passwordEncoder.matches(user.getPwd(), db.getPwd());

		return found;
	}

	public boolean chkId(String id) {
		UserDAO dao = sqlSessionTemplate.getMapper(UserDAO.class);
		int n = dao.chkId(id);	

		return n == 0 ? true : false;
	}
}
