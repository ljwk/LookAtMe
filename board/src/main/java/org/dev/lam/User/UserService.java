package org.dev.lam.User;

import javax.mail.internet.*;
import javax.mail.internet.MimeMessage.*;
import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.*;
import org.springframework.stereotype.*;

@Service
public class UserService {
	@Autowired
	protected JavaMailSender mailSender;
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
	
    public boolean joinSendMail(EmailVO email) throws Exception {
        try{
           MimeMessage msg = mailSender.createMimeMessage();
           
           InternetAddress addr = new InternetAddress("tjsgud1993@naver.com");
           msg.setFrom(addr);
           msg.setSubject(email.getSubject());
           msg.setContent(email.getContent(), "text/html;charset=utf-8");
           msg.setRecipient(RecipientType.TO , new InternetAddress(email.getReceiver()));
            
           mailSender.send(msg);
           return true;
        }catch(Exception ex) {
           ex.printStackTrace();
        }
        return false;
    }
    
    public boolean sendMail(EmailVO email, String send) throws Exception {
        try{
	        MimeMessage msg = mailSender.createMimeMessage();
	        InternetAddress addr = new InternetAddress(send);
	        msg.setFrom(addr); // 송신자를 설정해도 소용없지만 없으면 오류가 발생한다
	        //msg.setFrom("someone@paran.com");
	        msg.setSubject(email.getSubject());

	        // 일반 텍스트만 전송하려는 경우
	        msg.setText(email.getContent());  

	        msg.setRecipient(RecipientType.TO , new InternetAddress(email.getReceiver()));
	         
	        mailSender.send(msg);
	        return true;
        }catch(Exception ex) {
        	ex.printStackTrace();
        }
        return false;
    }

	public UserVO getInfo(String id) {
		UserDAO dao = sqlSessionTemplate.getMapper(UserDAO.class);
		UserVO info = dao.getInfo(id);
		return info;
	} 
}
