package mysite.kr.code.board.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

public class BoardData {
	
	@Data
	public static class BoardRequest {
		private int boardId;
		private String boardTitle;
		private String boardContents;
		private MultipartFile file;
	}
	
	@Getter
	@Builder //빌더패턴 사용(클래스를 객체화 해줌)
	@AllArgsConstructor //맴버변수 전체가 매개변수로 있는 생성자
	@NoArgsConstructor //기본생성자
	public static class BoardCreate {
		private int boardId;
		private String boardTitle;
		private String boardContents;
		private String boardWriter;
		@Setter
		private String originFileName;
		@Setter
		private String storedFileName;
	}

}
