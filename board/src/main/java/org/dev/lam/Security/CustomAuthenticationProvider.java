package org.dev.lam.Security;

import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.*;
import org.springframework.security.core.*;
import org.springframework.security.core.userdetails.*;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class CustomAuthenticationProvider implements AuthenticationProvider {
	@Autowired
	private SecurityService securityService;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		
		
		String username = authentication.getName();
				
		String password = (String) authentication.getCredentials();

		User user = null;
		Collection<GrantedAuthority> authorities = null;

		try {
			user = (User) securityService.loadUserByUsername(username);

			// 이용자가 로그인 폼에서 입력한 비밀번호와 DB로부터 가져온 암호화된 비밀번호를 비교한다
			if (!passwordEncoder.matches(password, user.getPassword()))
				throw new BadCredentialsException("비밀번호 불일치");

			authorities = user.getAuthorities();
		} catch (UsernameNotFoundException e) {
			e.printStackTrace();
			throw new UsernameNotFoundException(e.getMessage());
		} catch (BadCredentialsException e) {
			e.printStackTrace();
			throw new BadCredentialsException(e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e.getMessage());
		}

		return new UsernamePasswordAuthenticationToken(username, password, authorities);
	}

	@Override
	public boolean supports(Class<?> arg0) {
		return true;
	}

}