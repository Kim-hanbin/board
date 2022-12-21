package mysite.kr.code.login.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

public class LoginData {

	@Getter
	@AllArgsConstructor
	public static class LoginRequest {
		
		private String securedUserId;
		private String securedUserPasswd;
		
	}
	
	@Getter
	@Setter
	@NoArgsConstructor
	//Serializable 객체 직렬화 
	//(객체를 가지고 통신할때 많이 쓰임, 객체를 전송할때 한줄로 직렬화 해서 받는게 데이터 유실이 적음)
	public static class LoginUserInfo implements Serializable{
		private static final long serialVersionUID = 1L;
		private String userId;
		private String userPasswd;
		private String userName;
		private String userBirth;
		private String userGender;
		private String userAddr1;
		private String userAddr2;
		private String userRoleId;
		private String createTime;
	}
	
}
