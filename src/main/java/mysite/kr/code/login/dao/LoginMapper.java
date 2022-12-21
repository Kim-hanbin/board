package mysite.kr.code.login.dao;

import java.sql.SQLException;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import mysite.kr.code.login.vo.LoginData;

@Mapper
public interface LoginMapper {

	/**
	 * 사용자 확인
	 * @param param
	 * @return
	 * @throws SQLException
	 */
	LoginData.LoginUserInfo getUserInfo(Map<String, Object> param)throws SQLException;
	/**
	 * 아이디 중복 체크
	 * @param param
	 * @return
	 * @throws SQLException
	 */
	int userIdCheck(Map<String, Object> param)throws SQLException;
	/**
	 * 회원가입
	 * @param userInfo
	 * @return
	 * @throws SQLException
	 */
	int insertUserInfo(LoginData.LoginUserInfo userInfo)throws SQLException;
}
