package org.kosta.momsbay.model.service;

import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.annotation.Resource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.ibatis.io.Resources;
import org.kosta.momsbay.model.exception.LoginException;
import org.kosta.momsbay.model.exception.NoMemberFoundException;
import org.kosta.momsbay.model.mapper.ChildrenMapper;
import org.kosta.momsbay.model.mapper.MemberMapper;
import org.kosta.momsbay.model.vo.ChildrenStatisticsVO;
import org.kosta.momsbay.model.vo.ChildrenVO;
import org.kosta.momsbay.model.vo.MemberVO;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 회원관련 서비스 제공. 관련Mapper: MemberMapper
 * 
 * @author 개발제발
 */
@Service
public class MemberService {
	@Resource
	private MemberMapper memberMapper;
	@Resource
	private ChildrenMapper childrenMapper;

	/**
	 * 로그인 비즈니스로직. 1.파라미터의 id로 Member를 검색, 존재하지 않을 시에 "아이디 존재하지 않음" 메시지 throw 2.id가
	 * 존재하면 password를 비교 일치하지 않으면, "비밀번호가 다름" 메시지 throw 3.두 조건 모두 만족시, 자녀정보를 회원 id로
	 * 검색 MemberVO에 SET하여 Return
	 * 
	 * refactoring : 암호화 된 비밀번호와 받아온 비밀번호를 비교한다.
	 * 사용 암호화방법 : bCrypt
	 * @param id
	 * @param password
	 * @return 자녀정보가 포함된 MemberVO
	 * @throws LoginException
	 * @author Hwang
	 */
	public MemberVO login(String id, String password) throws LoginException {
		MemberVO memberVO = memberMapper.findMemberById(id);
		if (memberVO == null)
			throw new LoginException("아이디가 존재하지 않습니다");
		else if (password == null || !BCrypt.checkpw(password, memberVO.getPassword() ))
			throw new LoginException("비밀번호가 다릅니다");

		List<ChildrenVO> children = memberMapper.findChildrenByMemberId(id);
		memberVO.setList(children);
		return memberVO;
	}

	/**
	 * 아이디가 존재할 경우 false return, 사용가능 할 경우 true return.
	 * 
	 * @param id
	 * @return flag
	 */
	public boolean findMemberExsitById(String id) {
		// TODO Auto-generated method stub
		return memberMapper.findMemberExsitById(id);
	}

	/**
	 * 이메일이 존재할 경우 false return, 사용가능 할 경우 true return.
	 * 
	 * @param email
	 * @return flag
	 */
	public boolean findMemberByEmail(String email) {
		// TODO Auto-generated method stub
		String tempEmail = memberMapper.findMemberByEmail(email);
		if (tempEmail == null) {
			return false;
		} else
			return true;
	}

	/**
	 * member와 children을 Insert. 별도의 처리임으로 트랜젝션 처리. children은 여럿임으로 한명씩 insert 해주되,
	 * 부모 아이디가 별도로 추가되어야 해서 map 형태로 전송.
	 * 
	 * @param member
	 * @param children
	 * @author Hwang
	 */
	@Transactional
	public void addMember(MemberVO member, List<ChildrenVO> children) {
		// TODO Auto-generated method stub
		 String hashPassword = BCrypt.hashpw(member.getPassword(), BCrypt.gensalt());
		 member.setPassword(hashPassword);
		memberMapper.addMember(member);
		/*
		 * 암호화 하여 저장
		 */
		if (children.size() > 0) {
			for (int i = 0; i < children.size(); i++) {
				Map<String, String> tempMap = new HashMap<String, String>();
				tempMap.put("id", member.getId());
				tempMap.put("gender", children.get(i).getGender());
				tempMap.put("birth", children.get(i).getBirth());
				childrenMapper.addChildren(tempMap);
			}
		}
	}

	/**
	 * 회원정보 수정 메소드.
	 * 
	 * @param member
	 * @author hwang
	 */
	public void updateMember(MemberVO member) {
		String hashPassword = BCrypt.hashpw(member.getPassword(), BCrypt.gensalt());
		 member.setPassword(hashPassword);
		 /*
			 * 암호화 하여 저장
			 */
		memberMapper.updateMember(member);
	}

	/**
	 * 포인트 환전시 비밀번호 일치하는지 확인하는 메소드.
	 * 
	 * @param id
	 * @param password
	 * @return flag
	 * @author hwang
	 */
	public boolean findMemberByPasswordAndId(String id, String password) {
		Map<String, String> temp_map = new HashMap<String, String>();
		temp_map.put("id", id);
		temp_map.put("password", password);
		int count = memberMapper.findMemberByPasswordAndId(temp_map);
		if (count == 0) {
			return false;
		} else {
			return true;
		}
	}

	/**
	 * 회원 리스트를 등급별로 출력하는 메소드.
	 * 
	 * @param i
	 * @return 회원 리스트.
	 * @author hwang
	 */
	public List<String> getMemberList(int i) {
		List<String> list = new ArrayList<String>();
		list = memberMapper.getMemberList(i);
		return list;
	}

	/**
	 * 회원 등급 업데이트하는 메서드.
	 * 
	 * @param id
	 * @return 업데이트 현황.
	 */
	public String updateMemberStatus(String id) {
		int grade_no = memberMapper.findMemberGradeById(id);
		if (grade_no == 1) {
			memberMapper.updateMemberToBlackList(id);
			return "toBlackList";
		} else if (grade_no == 3) {
			memberMapper.updateBlackListToMember(id);
			return "toMemberList";
		} else {
			return "admin";
		}
	}

	/**
	 * 관리자모드에서 회원검색시 자동완성 기능을 위한 메소드.
	 * 입력받은 id로 시작하는 모든 아이디를 반환한다.
	 * @param id
	 * @return 아이디리스트
	 * @author Hwang
	 */
	public List<String> findMemberIdByPart(String id) {
		String temp_id = id + "%";
		return memberMapper.findMemberIdByPart(temp_id);
	}

	/**
	 * 아이디로 멤버의 정보를 찾아온다.
	 * @param id
	 * @return 멤버vo
	 * @author Hwang
	 */
	public MemberVO findMemberById(String id) {
		return memberMapper.findMemberById(id);
	}

	/**
	 * 구글차트를 이용한 자녀 통계를 뽑는 메소드.
	 * 남/여로 구분하여 추출.
	 * @return JSON
	 * @author Hwang
	 */
	public StringBuilder getMemberChildStatistics() {
		StringBuilder children = new StringBuilder();
		children.append("['여아',");
		children.append(memberMapper.getMemberChildStatistics("female") + "],");
		children.append("['남아',");
		children.append(memberMapper.getMemberChildStatistics("male") + "]");
		return children;
	}

	/**
	 * 구글차트를 이용한 회원등급통계를 뽑는 메소드.
	 * 회원등급별로 map에담아 return
	 * @return map
	 * @author Hwang
	 */
	public Map<String, Integer> getMemberGradeStatistics() {
		Map<String, Integer> list = new HashMap<>();
		list.put("member", memberMapper.getMemberCountByGrade("member"));
		list.put("blacklist", memberMapper.getMemberCountByGrade("blacklist"));
		list.put("admin", memberMapper.getMemberCountByGrade("admin"));
		return list;
	}

	/**
	 *  구글차트를 이용한 자녀 통계를 뽑는 메소드.
	 * 남/여+나이대별로 구분하여 추출.
	 * @return 자녀 나이+성별 통계
	 * @author Hwang
	 */
	public List<ChildrenStatisticsVO> getChildrenAgeStatistics() {
		List<ChildrenStatisticsVO> list = new ArrayList<>();
		ChildrenStatisticsVO ch = new ChildrenStatisticsVO();
		Map<String, Object> map = new HashMap<>();
		map.put("gender", "male");
		ch = childrenMapper.getChildrenAgeStatistics(0);
		ch.setAge("2세 미만");
		list.add(ch);

		for (int i = 1; i < 10; i++) {
			ChildrenStatisticsVO temp_ch = new ChildrenStatisticsVO();
			temp_ch = childrenMapper.getChildrenAgeStatistics(i);
			temp_ch.setAge(i + 1 + "세");
			list.add(temp_ch);
		}
		return list;
	}

	/**
	 * 비밀번호 찾기 메소드.
	 * 입력한 값과 비교하여 모두 일치하면 등록된 이메일로 임시비밀번호를 전송한 후, 
	 * 임시비밀번호를 db에 업데이트한다.
	 * @param member
	 * @throws NoMemberFoundException
	 * @throws SQLException
	 * @throws IOException
	 * @author Hwang
	 */
	public void findPasswordByNameAndEmail(MemberVO member) throws NoMemberFoundException, SQLException, IOException {
		String email = memberMapper.findMemberExsitByName(member.getName());
		Random rnd = new Random();
		StringBuilder tempPwd = new StringBuilder();

		if (email == null || email.equals("")) {
			throw new NoMemberFoundException("입력한 이름의 계정이 존재하지 않습니다");
		} else {
			email = memberMapper.findMemberByEmail(member.getEmail());
			if (email == null || email.equals("")) {
				throw new NoMemberFoundException("입력한 이메일의 계정이 존재하지 않습니다");
			} else {
				for (int i = 0; i < 7; i++)
					if (i % 2 == 0)
						tempPwd.append(String.valueOf((char) ((int) (rnd.nextInt(26)) + 65)));
					else
						tempPwd.append(String.valueOf(rnd.nextInt(10)));
				/*
				 * 비밀번호 변경
				 */
				Map<String, String> map = new HashMap<>();
				map.put("email", email);
				map.put("pwd", tempPwd.toString());
				memberMapper.updateMemberPassword(map);
			}

		}
		/*
		 * mail method
		 */
		
		Properties props = new Properties();
		String resource="/mail.properties";
		Reader reader;
			reader = Resources.getResourceAsReader(resource);
			props.load(reader);
		
		String user =props.getProperty("user") ;
		String password = props.getProperty("password");
		String to = email;

		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});
		try {
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(user));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
			
			String htmlContent = "당신의 임시 비밀번호는 <Strong>" + tempPwd 
					+ "</Strong> 입니다. 사이트에 접속해서 로그인 후 비밀번호를 변경하세요.<br>";

			// Subject
			message.setSubject("Mom's Bay 비밀번호 찾기 입니다");
			// Text
			message.setText(htmlContent, "UTF-8", "html");
			// send the message
			Transport.send(message);			
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
}
