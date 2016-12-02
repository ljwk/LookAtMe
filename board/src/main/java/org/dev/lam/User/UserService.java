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
	        msg.setFrom(addr); // �۽��ڸ� �����ص� �ҿ������ ������ ������ �߻��Ѵ�
	        //msg.setFrom("someone@paran.com");
	        msg.setSubject(email.getSubject());

	        // �Ϲ� �ؽ�Ʈ�� �����Ϸ��� ���
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
