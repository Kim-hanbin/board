<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<section class="content-header">
	<h1>게시글 수정</h1>
</section>

<section class="content">
	<div class="container">
		<form id="updateFrm">
		    <input type="hidden" id="boardId" name="boardId" value="${board.boardId}">
			<div class="form-group">
				<label for="boardTitle">제목</label> 
				<input type="text" class="form-control" id="boardTitle" name="boardTitle" value="${board.boardTitle}">
			</div>
			<div class="form-group">
				<label for="file">첨부파일</label> <input type="file"
					class="form-control" id="file" name="file">
			</div>
			<div class="form-group">
				<label for="boardContents">내용</label>
				<textarea cols="70" rows="20" class="form-control" id="boardContents"
					name="boardContents">${board.boardContents}</textarea>
			</div>
		</form>
		<div style="margin-top: 10px">
			<button type="button" id="saveBtn" class="btn btn-primary pull-right">수정</button>
			<button type="button" id="listBtn" class="btn btn-primary pull-right"
				style="margin-right: 3px">취소</button>
		</div>
	</div>

	<script>
		function validated() {
			const boardTitle = $('#boardTitle');
			const boardContents = $('#boardContents');
			
			if($.trim(boardTitle.val()).length === 0) {
				alert('제목을 입력하십시오.');
				boardTitle.focus();
				return false;
			}
			if($.trim(boardContents.val()).length === 0){
				alert('내용을 입력하십시오.');
				boardContents.focus();
				return false;
			}
			
			const file = $('#file').val();
			
			if(file) {
				const isConfirm = confirm('기존에 첨부파일이 있다면 삭제됩니다. 진행하시겠습니까?');
				if(!isConfirm) {
					$("file").val(""); //선택된 파일 삭제
					return false;
				}
			}
			
			return true;
		}

		function initBtn() {

			//자바 스크립트
			const saveBtn = document.querySelector('#saveBtn'); //javascript객체(돈객체?)
			const listBtn = $('#listBtn'); //Jquery객체

			if (typeof saveBtn !== 'undefined') {
				saveBtn.addEventListener('click', function(e) {
					e.preventDefault(); 
					// 이벤트 동작 방지 (여러번 눌리는것을 방지)
					// addEventListener는 데이터를 받아오는 화면 전환일때 데이터 중복 처리를 막기 위함
					if(validated()) {
						//폼을 jquery 객체로 바꾸면 배열값이 0임
						const updateFrm = $('#updateFrm')[0];
						
						//폼 전체를 데이터 객채화 해줌
						const formData = new FormData(updateFrm);
						
						//ajax로 파일 데이터 전송하기
						
						$.ajax({
							url: '/board/update.do',
							type: "post",
							data: formData,
							dataType: 'json',
							enctype : 'multipart/form-data',
							contentType: false, //전송되는 문서의 양식(false면 enctype으로 데이터가 날아감)
							processData: false, //ajax 넘길 때 전송되는 데이터 파라메터(별도의 데이터 x)
						}).done(function(data){
							
							if(data.resultCode === 200) {
								alert('게시글이 수정되었습니다.')
							}else {
								alert('게시글 수정이 실패했습니다.');
							}
							$('#contents').load('/board/list.do',null);
							
						}).fail(function (xhr, error, status){
							console.log(error);
						})
					}
				});
			}
			if (typeof listBtn !== 'undefined') {

				listBtn.on('click', function(e) {
					$('#contents').load('/board/list.do', null);
				});

			}

		}

		$(document).ready(function() {
			initBtn();
		});
	</script>

</section>