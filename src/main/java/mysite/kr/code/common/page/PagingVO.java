package mysite.kr.code.common.page;

public class PagingVO {

	private int totalPage; // 전체 페이지 수
	private int nowPageNumber; // 현재 위치하는 페이지 번호
	private int blockPageCount; // 한블럭당 부여할 페이지 개수 << < 1 2 3 4 5 > >> <>안이 한블럭
	private int pagePerRows = 3; // 한페이지당 보여줄 데이터의 개수
	private int totalRows; // 전체 데이터 개수
	private int nowBlock; // 현재 블럭 위치
	private int totalBlock; // 전체 블럭 개수

	// 생성자
	public PagingVO(int nowPageNumber, int totalRows) {
		this.nowPageNumber = nowPageNumber - 1;
		this.totalRows = totalRows;
		this.blockPageCount = 5; // 하나의 블럭당 10개의 페이지 개수를 보여준다.
	}

	// SQL 에서 출력데이터의 범위 시작 위치 정할 때 사용할 것
	public int getBeginPage() {
		// 한 페이지의 시작위치 번호
		return nowPageNumber * pagePerRows + 1;
	}

	// SQL에서 출력 데이터의 범위 마지막 위치 정할 때 사용할 것
	public int getEndPage() {
		// 한 페이지의 끝위치 번호
		return getBeginPage() + pagePerRows - 1;
	}

	// 전체 페이지 수
	public int totalPage() {
		// 전체 데이터 개수를 실수로 바꾼다.
		double total = (double) totalRows;
		// Math.ceil 소수점 자리가 남아있다면 그대로 올림 해줌
		// 예를 들어 데이터가 12개 있는대 1페이지에 10개를 넣을수 있다 가정했을때
		// 2개의 데이터를 더 넣어주기위해 페이지 하나가 더필요하기에 올림을 해줘서 페이지를 하나 더만들어 준다.
		double result = Math.ceil(total / this.pagePerRows); // 전체 개수를 페이지당 보여줄 목록 수로 나눈다.
		System.out.println("총 페이지 수: " + result);

		return (int) result;
	}

	public int nowBlock() {
		double retVal = ((double) this.nowPageNumber) / this.blockPageCount;
		// 현재 블럭 = 현재 페이지/블럭당 페이지 수
		return (int) (retVal);
	}

	public int totalBlock(int totalPage) {
		double retVal = Math.ceil((double) totalPage / this.blockPageCount);
		System.out.println("토탈 블럭: " + retVal);
		return (int) (retVal);
	}

	public String pageHTML() {

		this.totalPage = this.totalPage();
		this.nowBlock = this.nowBlock();
		this.totalBlock = this.totalBlock(totalPage);
		int pageNumber = 0;
		StringBuilder sb = new StringBuilder();

		// 만약 첫번째 블럭 이후라면~
		// 현재 블럭이 0이면 page 1~10
		// 블럭이 1이면 page 11~20
		if (nowBlock > 0) {
			// 이전 블럭으로 가기 작성하기 위함
			pageNumber = (nowBlock - 1) * blockPageCount;
			sb.append("<li class= 'page-item'>");
			sb.append("<a class='page-link' href=\"javascript:void(0);\" onclick=\"goPage(" + pageNumber + ");\"> ");
			sb.append(" << </a></li>");
		}

		// 이전 페이지 이동 버튼 만들기
		if (nowPageNumber > 0) {
			sb.append("<li class= 'page-item'>");
			sb.append("<a class='page-link' href=\"javascript:void(0);\" ");
			sb.append("onclick=\"goPage(" + (nowPageNumber - 1) + ");\"> ");
			sb.append(" < </a></li>");
		}

		// 페이지 리스트 만들기
		for (int i = 0; i < blockPageCount; i++) {
			pageNumber = (nowBlock * blockPageCount) + i;

			if (pageNumber == nowPageNumber) {
				sb.append("<li class= 'page-item active'>");
				sb.append(
						"<a class='page-link' href=\"javascript:void(0);\" onclick=\"goPage(" + pageNumber + ");\"> ");
				sb.append((pageNumber + 1) + "</a></li>");
			} else {
				sb.append("<li class= 'page-item'>");
				sb.append(
						"<a class='page-link' href=\"javascript:void(0);\" onclick=\"goPage(" + pageNumber + ");\"> ");
				sb.append((pageNumber + 1) + "</a></li>");
			}

			// 마지막 페이지이면 페이지 번호 출력을 종료
			// 페이지를 만드는 루프가 끝나기 전에 마지막 페이지 번호를 만나면 더이상 반복할 필요없음
			if ((nowBlock * blockPageCount) + i + 1 == totalPage) {
				break;
			}
		}

		if(nowPageNumber == totalPage) {
			sb.append("<li class= 'page-item'>");
			sb.append("<a class='page-link' href=\"javascript:void(0);\" ");
			sb.append("onclick=\"goPage(" + nowPageNumber + ");\"> ");
			sb.append(" > </a></li>");
		}
		// 다음 페이지로 이동 버튼 만들기
		if (nowPageNumber + 1 < totalPage) {
			sb.append("<li class= 'page-item'>");
			sb.append("<a class='page-link' href=\"javascript:void(0);\" ");
			sb.append("onclick=\"goPage(" + (nowPageNumber + 1) + ");\"> ");
			sb.append(" > </a></li>");
		}

		// 다음블럭으로 가기 버튼 만들기
		if (nowBlock + 1 < totalBlock) {
			pageNumber = (nowBlock + 1) * blockPageCount;
			sb.append("<li class= 'page-item'>");
			sb.append("<a class='page-link' href=\"javascript:void(0);\" onclick=\"goPage(" + pageNumber + ");\"> ");
			sb.append(" >> </a></li>");
		}

		return sb.toString();

	}

}
