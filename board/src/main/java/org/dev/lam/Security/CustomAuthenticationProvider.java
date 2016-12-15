package org.dev.lam.Security;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;

public class CustomAuthenticationProvider implements AuthenticationProvider {
	@Autowired
	private SecurityService securityService;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	private static Map<String,String> online = new HashMap<>();
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		String username = authentication.getName();

		String password = (String) authentication.getCredentials();

		User user = null;
		Collection<GrantedAuthority> authorities = null;

		try {
			user = (User) securityService.loadUserByUsername(username);

			// 이용자가 로그인 폼에서 입력한 비밀번호와 DB로부터 가져온 암호화된 비밀번호를 비교한다
			if (!passwordEncoder.matches(password, user.getPassword())) {
				throw new BadCredentialsException("비밀번호 불일치");
			} else {
				WebAuthenticationDetails wad = (WebAuthenticationDetails) authentication.getDetails();
				online.put(wad.getSessionId(), username);
			}

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
	
	public static Map<String,String> getOnline() {
		return online;
	}
	
}