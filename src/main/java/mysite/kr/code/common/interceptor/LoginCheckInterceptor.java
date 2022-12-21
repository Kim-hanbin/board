package mysite.kr.code.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginCheckInterceptor implements HandlerInterceptor{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		//세션정보 확인
		HttpSession session = request.getSession();
		boolean isPassed = true;
		
		if(session.getAttribute("userInfo")== null) {
			
			if(isAjaxRequest(request)) {
				response.sendError(401);
			}else {
				response.sendRedirect("/login/error/info.do");
			}
			
			isPassed = false;
			
		}else {
			//세션 지속시간을 30분으로 초기화
			session.setMaxInactiveInterval(60*30);
			isPassed = true;
		}
		
		return isPassed;
	}
	
	private boolean isAjaxRequest(HttpServletRequest request) {
		String header = request.getHeader("AJAX");
		
		if("true".equals(header)) {
			return true;
		}else {
			return false;
		}
		
	}
	
	/**
	 * preHandle: 디스패처서블릿이 컨트롤을 부르기 전에 인터셉터가 실행
	 * postHandle: 디스패처서블릿이 컨트롤을 호출한뒤 view를 호출되기 전에 인터셉터 실행  
	 * afterCompletion: view를 호출된 후에 인터셉터가 실행
	 */
	// interface에 dafault로 구현된 메서드는 오버라이드 해서 쓰면 된다.
	// 필요한 기능만 골라서 쓰게 하기 위해 (인터페이스의 확장성 면이나 코드 수정의 불편함을 줄여줌)
	// 오버라이드: 정의된 메소드의 구현 내용을 바꾸는것. (재정의 뜻)
	// 오버로딩: 파라메터만 다른 같은 이름의 메서드를 만들수 있는 것.
	
	
	
	
}
