package mysite.kr.code.board.vo;

import lombok.Getter;
import lombok.Setter;

/* 
   @Data 어노테이션을 사용하면 getter setter가 자동적으로 생성 됨(컴파일시)
   toString도 자동적으로 생성해주는대 오버라이드 해서 사용해야함
   (toString이 재대로 생성이 안될 가능성이 있는대 toString을 안쓴다면 @Getter 와 @Setter를 따로 선언)
   @RequiredArgsConstructor란? 설정한 멤버변수를 매개변수로 가지는 생성자를 만들어라.
   필요한 파라메터 위에 @NonNull 해주면 이변수를 파라메터로 지정하라는 뜻
   @AllArgsConstructor 모든 멤버변수를 매개변수로 가지는 생성자를 만들어라.
   @NoArgsConstructor //파라메터가 없는 기본 생성자를 두어라.
   (lombok 사용시 이 모든 어노테이션 사용가능)
*/
@Getter
@Setter
public class BoardVO {

	private int rn;
	private int boardId;
	private String boardTitle;
	private String boardContents;
	private String boardWriter;
	private int boardCount;
	private String originFileName;
	private String storedFileName;
	private String createTime;
	private String updateTime;
}
