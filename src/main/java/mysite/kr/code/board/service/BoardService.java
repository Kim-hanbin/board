package mysite.kr.code.board.service;


import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;
import mysite.kr.code.board.dao.BoardMapper;
import mysite.kr.code.board.vo.BoardData;
import mysite.kr.code.board.vo.BoardVO;
import mysite.kr.code.common.CommonUtils;
import mysite.kr.code.common.page.PagingVO;

@Service
@RequiredArgsConstructor // 생성자를 통한 의존성 주입
public class BoardService {

	// @RequiredArgsConstructor를 통한 의존성 주입을 
	// 하기위해 final을 붙혀줘야함 그래야 인식해서 생성자로 DI해줌
	
	final private BoardMapper mapper;
	
	public Map<String, Object> getBoardList(Map<String, Object> param) throws Exception {
		
		//이동할 페이지
		int nowPageNumber = (int)param.get("nowPageNumber");
		//전체 게시판 글 개수
		int totalCount = mapper.totalBoardCount(param);
		
		//결과를 담을 객체 선언
		Map<String, Object> resultMap = new HashMap<>();
		
		//현재 페이지와 전체 개수를 가지고 계산하는 페이지 객체를 선언
		PagingVO page = new PagingVO(nowPageNumber, totalCount);
		
		//가져올 데이터의 범위를 저장
		param.put("start", page.getBeginPage());
		param.put("end", page.getEndPage());
		
		//한 페이지에 보여줄 데이터를 가져옴
		List<BoardVO> list = mapper.getBoardList(param);
		
		resultMap.put("dataList", list);
		resultMap.put("nowPageNumber", nowPageNumber);
		resultMap.put("pageHtml", page.pageHTML());
		
		return resultMap;
	}
	
	public BoardVO getBoardDetail(Map<String, Object> param) throws Exception {
		//조회수 증가
		mapper.updateBoardCount(param);
		return mapper.getBoardDetail(param);
	}
	
	
	
	public void writeBoard(BoardData.BoardRequest boardRequest) throws Exception {
		BoardData.BoardCreate boardCreate = BoardData.BoardCreate
                                                     .builder()
                                                     .boardTitle(boardRequest.getBoardTitle())
                                                     .boardContents(boardRequest.getBoardContents())
                                                     .build();
		this.uploadFile(boardRequest, boardCreate);
		this.mapper.writeBoard(boardCreate);
	}
	
	
	public void updateBoard(BoardData.BoardRequest boardRequest) throws Exception {
		BoardData.BoardCreate boardCreate = BoardData.BoardCreate
				                                     .builder()
				                                     .boardTitle(boardRequest.getBoardTitle())
				                                     .boardContents(boardRequest.getBoardContents())
				                                     .boardId(boardRequest.getBoardId())
				                                     .build();
		
		Map<String, Object> param = new HashMap<>();
		param.put("boardId", boardRequest.getBoardId());
		
		BoardVO vo = this.getBoardDetail(param);
		
		if(boardRequest.getFile() != null && !boardRequest.getFile().isEmpty()) {
			String fullPath = CommonUtils.uploadPath + vo.getStoredFileName();
			File file = new File(fullPath);
			//해당경로에 진짜 존재한다면
			if(file.exists()) {
				//지운다.
				file.delete();
			}
			this.uploadFile(boardRequest, boardCreate);
		}
		
		this.mapper.updateBoard(boardCreate);
	}
	
	public int deleteBoard(int boardId) throws Exception {
		
		Map<String, Object> param = new HashMap<>();
		param.put("boardId", boardId);
		
		BoardVO vo = this.getBoardDetail(param);
		
		if(vo.getStoredFileName() != null && !vo.getStoredFileName().isEmpty()) {
			String fullPath = CommonUtils.uploadPath + vo.getStoredFileName();
			File file = new File(fullPath);
			//해당경로에 진짜 존재한다면
			if(file.exists()) {
				//지운다.
				file.delete();
			}
		}
		
		return this.mapper.deleteBoard(param);
	}
	
	
	/**
	 * 파일 업로드 하기
	 * @param boardRequest
	 * @throws Exception
	 */
	public void uploadFile(BoardData.BoardRequest boardRequest, BoardData.BoardCreate boardCreate) throws Exception{
		MultipartFile file = boardRequest.getFile();
		
		//파일 객체가 존재 할 경우
		if(file!=null && !file.isEmpty()){
			String originFileName = file.getOriginalFilename();
			
			//확장자
			String ext = originFileName.substring(originFileName.lastIndexOf(".")+1);
			
			//파일에 부여할 랜덤이름
			String randomName = CommonUtils.getUUID();
			
			//저장할 파일명 만들기
			String storedFileName = randomName+ "."+ ext;
			
			//저장할 파일의 전체 경로
			String fullPath = CommonUtils.uploadPath + storedFileName;
			
			//파일 객체 만들기 - 파일을 컨트롤 하기위함.(생성,삭제 등)
			File newFile = new File(fullPath);
			
			//저장할 경로가 없다면?
			if(!newFile.getParentFile().exists()) {
				//전체 폴더 경로를 생성해줌 (여기서 전체경로란? 우리가 설정한 fullPath)
				newFile.getParentFile().mkdirs();
			}
			
			//기존파일을 복사할 빈파일 만들기
			newFile.createNewFile();
			//기존파일을 생성 된 새로운 빈파일로 복사한다.
			file.transferTo(newFile);
			
			//등록할 파일 이름들을 객체에 저장
			boardCreate.setOriginFileName(originFileName);
			boardCreate.setStoredFileName(storedFileName);
			
			
		}
	}
	
	
}
