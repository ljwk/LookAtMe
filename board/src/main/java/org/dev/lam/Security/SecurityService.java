package org.dev.lam.Security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class SecurityService implements UserDetailsService {
	@Autowired
	private SecurityDAO securityDAO;

	@Override
	public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
		// �����ͺ��̽����� ������ �̿��� ����
		UserDetails userDetails = securityDAO.getUserDetails(userId);
		if (userDetails == null)
			throw new UsernameNotFoundException("������ ������ ã�� �� �����ϴ�.");
		return userDetails;
	}
}