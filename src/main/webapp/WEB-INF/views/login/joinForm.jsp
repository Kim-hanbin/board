<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8" session="false"%> <!-- 세션이 필요없으니까 session을 꺼둔다 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>JoinForm</title>
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
	integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
	crossorigin="anonymous">
<%-- Font Awesome --%>
<link rel="stylesheet" href="<c:url value="/resources/bower_components/font-awesome/css/font-awesome.min.css"/>">
<%-- Ionicons --%>
<link rel="stylesheet" href="<c:url value="/resources/bower_components/Ionicons/css/ionicons.min.css"/>">
<%-- Theme style --%>
<link rel="stylesheet" href="<c:url value="/resources/dist/css/AdminLTE.min.css"/>">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
<!-- AdminLTE App -->
<script src="<c:url value="/resources/dist/js/adminlte.min.js"/>"></script>
<!-- Daum adress API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/validate.js/0.13.1/validate.min.js"></script>
<style>

.bg-light {
 height: 1100px;
 padding-top: 15px;
}

.container.py-4 {
 margin: 0 auto;
 width: 503px;
}

</style>

</head>
<body>
  <section class="bg-light">
    <div class="container py-4">
      <div align="center" style="margin: 50px auto">
        <span class="text-dark h4">회원가입</span>
      </div>
      <!--  onsubmit="return false;" 엔터를 치면 자동적으로 formsubmit이 날라가는걸 막아줌 -->
      <!-- 우리는 formSubmit을 날리지 않고 ajax통신을 통해서 데이터를 주고받는 기능을 만들었기 때문 -->
      <form action="/login/join.do" method="post" id="frm" onsubmit="return false;">
        <div class="form-group">
          <label for="userId" class="form-label-mt-4">아이디</label>
          </div>
          <div class="row" style="margin-bottom: 1rem">
            <div class="col-md-8" align="left">
              <input type="text" class="form-control" id="userId" name="userId">
            </div>
            <div>
              <label></label>
              <button type="button" class="btn btn-secondary" onclick="checkId();">중복확인</button>
            </div>
          </div>
        <div class="form-group">
          <label for="userPasswd" class="form-label-mt-4">비밀번호</label>
          <input type="text" class="form-control" id="userPasswd" name="userPasswd">
        </div>
        <div class="form-group">
          <label for="userName" class="form-label-mt-4">이름</label>
          <input type="text" class="form-control" id="userName" name="userName">
        </div>
        <div class="form-group">
          <label for="userBirth" class="form-label-mt-4">생년월일(6자)</label>
          <input type="text" class="form-control" id="userBirth" name="userBirth" placeholder="예) 980425">
        </div>
        <div class="form-group">
          <label for="userGender" class="form-label-mt-4">성별</label>
          <select id="userGender" name="userGender" class="form-control">
            <option value="남자" selected="selected">남자</option>
            <option value="여자">여자</option>
          </select>
        </div>
          <div class="form-group" style="margin-bottom: 5px">
            <label class="col-md-4" style="padding-left: 0px; margin-bottom: 0px">주소</label>
          </div>
          <div class=row>
            <div class="col-md-8" align="left">
              <input type="text" readonly="readonly"  style="width: 80px;" id="postCode" name="postCode" placeholder="우편번호">
            </div>
            <div class="col-md-4" align="right">
              <button type="button" class="btn btn-info btn-sm" onclick="searchPostCode()">우편번호 찾기</button>
            </div>
          </div>
          <div class="row" style="margin-top: 5px">
            <div class="col-md-12">
              <input type="text" style="width:100%" readonly="readonly" id="userAddr1" name="addr1" placeholder="주소">
            </div>
          </div>
          <div class="row" style="margin-top: 5px; margin-bottom: 1rem">
            <div class="col-md-12">
              <input type="text" style="width:100%" id="userAddr2" name="addr2" placeholder="상세주소">
            </div>
          </div>
          <div class="form-group">
          <label for="userRole" class="form-label-mt-4">권한</label>
          <select id="userRoleId" name="userRoleId" class="form-control">
            <option value="admin" selected="selected">슈퍼관리자</option>
            <option value="superUser">중간관리자</option>
            <option value="user">사용자</option>
          </select>
        </div>
        <div class="row" style="margin-top: 5rem" align="center">
          <div class="col-md-12">
            <button type="button" class="btn btn-primary" style="margin-right: 5px" onclick="register()">회원가입</button>
            <button type="button" class="btn btn-secondary" onclick="cancel()">취소</button>
          </div>
        </div>
        
      </form>
    </div>
  </section>


</body>
<script>
  let isCheckId = false;
  
  function searchPostCode() {
	daum.postcode.load(function(){ //팝업을 띄워라 아래 실행됌
		new daum.Postcode({ //팝업이 시작되면 객체를 띄워라(주소검색 객체)
			oncomplete:function(data){ // 클릭을 하면 아래 옵션 실행
				let fullAddr = '';
			    let extraAddr = '';
			    console.log(data);
			    //사용자가 도로명 주소를 선택했을 경우
			    if(data.userSelectedType === 'R'){
			    	fullAddr = data.roadAddress;
			    	//도로명주소일때 동을 표시해줌
			    	if($.trim(data.bname).length > 0){
			    		console.log("동: "+data.bname);
			    		extraAddr += data.bname;
			    	}
			    	
			    }else {
			    	fullAddr = data.jibunAddress;
			    }
			    //건물이름이 있을 경우
			    if(data.buildingName !== ''){
			    	console.log("건물이름: "+data.buildingName);
			    	extraAddr += (extraAddr !== ''?','+data.buildingName : data.buildingName);
			    }
			    
			  //조합형주소의 유무에 따라 양쪽에 괄호를 추가해서 최종주소를 만든다.
			  fullAddr +=(extraAddr !== ''?'('+extraAddr+')':'');
			  //우편번호
			  $('#postCode').val(data.zonecode);
			  //총 주소
			  $('#userAddr1').val(fullAddr);
			}
		}).open();
	})
}
  
  function register() {
 
	  if(validated()){
		  const param = getParam();
		  
		  console.log(param);
		  // param을 json타입으로 날려보자
		  // json은 스트링 타입으로 데이터를 주고받기 때문에
		  // param을 스트링 화해줘야한다.
		  $.ajax({
			 url: '/login/join.do',
			 type: 'post',
			 contentType: 'application/json;charset=utf-8',
			 data: JSON.stringify(param),
			 dataType: 'json'
		  }).done(function (data){
			  if(data.resultCode==200){
				  alert('사용자 등록이 완료되었습니다.');
				  location.href="/login/form.do";
			  }else{
				  alert('사용자 등록이 실패하였습니다. 다시 시도해주십시오.');
				  return false;
			  }
		  }).fail(function(xhr, status, error){
			  console.log(error);
		  });
	  }
  }
  
  
	function getParam() {
		let param = {}; //빈 자바스크립트 객체
		const inputAll = document.querySelectorAll('input');
		$.each(inputAll, function(index, obj) {
			const inputId = $(obj).attr('id');
			checkObj = $('#' + inputId);
			//아이디 양끝에 띄워쓰기 없애주기
			param[inputId] = $.trim(checkObj.val());
		});
		//slectBox의 값은 아래와 같이 두가지로 가져올수 있는대 아래꺼가 더 자세함
		param['userGender'] = $('#userGender').val();
		param['userRoleId'] = $('#userRoleId > option:selected').val();
		
		return param;
	}

	
	function validated() {
		//모든input에 대한 정보를 다 가져옴
		const inputAll = document.querySelectorAll('input');
		//유효성 결과 담을 변수 (let은 값 바꾸기 가능, const는 값 못바꿈(java의 final))
		let isValid = true;
		//모든 input 반복돌리기
		$.each(inputAll, function(index, obj) {
			//input의id값 가져오기
			const inputId = $(obj).attr('id');
			//가져온 input의 id값을 jquery 객체로 변환
			checkObj = $('#' + inputId);
			//각각 input값에 따라 에러 발생시 각각 다른 메세지 가져오기
			const message = getMessage(inputId);
			//validation 체크

			//상세주소는 유효성 제외
			if (inputId !== 'userAddr2') {
				if (typeof checkObj === 'undefined'
						|| $.trim(checkObj.val()).length === 0) {
					alert(message);
					checkObj.focus();
					isValid = false; //결과 변경
					return false; //break문
				}
			}

		});

		if (!isCheckId) {
			alert('아이디 중복체크를 해주십시오.');
			return false;
		}

		return isValid;
	}

	function getMessage(id) {

		let message = '';
		if (id === 'userId') {
			message = "아이디를 입력하십시오.";
		} else if (id === 'userPasswd') {
			message = "비밀번호를 입력하십시오.";
		} else if (id === 'userName') {
			message = "이름을 입력하십시오.";
		} else if (id === 'userBirth') {
			message = "생년월일을 입력하십시오.";
		} else if (id === 'userAddr1' || id === 'userAddr2'
				|| id === 'postCode') {
			message = "우편번호 검색을 해주십시오.";
		}
		return message;
	}

	function checkId() {
		const userId = $('#userId').val();

		isCheckId = false;

		if ($.trim(userId).length === 0) {
			alert('아이디를 입력해 주십시오.');
		} else {
			$.ajax({
				url : '/login/check/id.do',
				type : 'get',
				dataType : 'json',
				data : {
					userId : userId
				}
			}).done(function(data) {

				if (data.resultCode === 200) {
					isCheckId = true;
					alert('사용가능한 아이디 입니다.');
				} else if (data.resultCode === 300) {
					alert('이미 가입된 아이디 입니다.');
				} else {
					alert('중복검사 과정에 문제가 있습니다. 다시 실행 해 주세요');
				}
			}).fail(function(xhr, status, error) {
				console.log(error);
			});
		}
	}

	function cancel() {
		location.href = "/main/main.do";
	}
</script>
</html>