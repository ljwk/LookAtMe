package org.dev.lam.User;

public interface UserDAO {
	public int add(UserVO user);
	public UserVO getUser(String id);
	public int chkId(String id);
}