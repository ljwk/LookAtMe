package org.dev.lam.User;

import java.util.*;

public interface UserDAO {
	public int add(UserVO user);
	public UserVO getUser(String id);
	public int chkId(String id);
	public UserVO getInfo(String id);
	public int drop(String id);
	public int modiPwd(UserVO user);
	public int modiEmail(UserVO user);
	public List<UserVO> searchId(String email);
	public int change(UserVO user);
}