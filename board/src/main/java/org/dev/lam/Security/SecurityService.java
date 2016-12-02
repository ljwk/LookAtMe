package org.dev.lam.Security;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.security.core.userdetails.*;
import org.springframework.stereotype.*;
import java.util.*;
import org.springframework.security.core.*;
import org.springframework.security.core.authority.*;

@Service
public class SecurityService implements UserDetailsService {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
		
	@Override
	public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
		// �����ͺ��̽����� ������ �̿��� ����
		SecurityDAO dao = sqlSessionTemplate.getMapper(SecurityDAO.class);
		SecurityVO security = dao.getUserDetails(userId);
		
		if (security == null)
			throw new UsernameNotFoundException("������ ������ ã�� �� �����ϴ�.");
				
		String id = security.getId();
		String pwd = security.getPwd();
		String role = security.getAuthority();
		
		List<GrantedAuthority> roles = new ArrayList<>();
		roles.add(new SimpleGrantedAuthority(role));
		User user = new User(id, pwd, roles);
		
		UserDetails userDetails = user;
		
		return userDetails;
	}
}