<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>LoginForm</title>
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="<c:url value="/resources/bower_components/bootstrap/dist/css/bootstrap.min.css"/>">
    <%-- Font Awesome --%>
    <link rel="stylesheet" href="<c:url value="/resources/bower_components/font-awesome/css/font-awesome.min.css"/>">
    <%-- Ionicons --%>	
    <link rel="stylesheet" href="<c:url value="/resources/bower_components/Ionicons/css/ionicons.min.css"/>">
    <%-- Theme style --%>
    <link rel="stylesheet" href="<c:url value="/resources/dist/css/AdminLTE.min.css"/>">
    <%--plugin_js.jsp--%>
    <%@ include file="../include/plugin_js.jsp" %>
</head>
<body class="hold-transition login-page">
   <div class="login-box">
     <div class="login-logo">
       HomePage
     </div>
     <div class="login-box-body">
       <form id="loginFrm" action="/login/proc.do" method="post">
         <input type="hidden" id="securedUserId" name="securedUserId">
         <input type="hidden" id="securedUserPasswd" name="securedUserPasswd">
       </form>
       <form id="rsaFrm">
         <input type="hidden" id="rsaPublicKeyModule" name="rsaPublicKeyModule">
         <input type="hidden" id="rsaPublicKeyExponent" name="rsaPublicKeyExponent">
       </form>
       <form>
         <div class="form-group has-feedback">
           <input type="text" class="form-control" id="userId" name="userId" placeholder="Id">
           <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
         </div>
         <div class="form-group has-feedback">
           <input type="password" class="form-control"  id="userPasswd" name="userPasswd" placeholder="Password">
           <span class="glyphicon glyphicon-lock form-control-feedback"></span>
         </div>
         <div class="row">
           <div class="col-xs-12">
             <button type="button" id="loginBtn" class="btn btn-primary btn-block">Login</button>
           </div>
         </div>
       </form>
     </div>
   </div>
</body>

<script src="<c:url value="/resources/security/jsbn.js"/>"></script>
<script src="<c:url value="/resources/security/rsa.js"/>"></script>
<script src="<c:url value="/resources/security/prng4.js"/>"></script>
<script src="<c:url value="/resources/security/rng.js"/>"></script>

<script>

//enter누르면 로그인 기능
  function btnInit() {
	  $('#loginBtn').on('click', goLogin);
	  $('#userPasswd').on('keydown', function (e) {
		if(e.keyCode === 13){
			goLogin();
		}
	})
	  }
  
  function validate() {
	const userId = $('#userId');
	const userPasswd = $('#userPasswd');
	
	if(typeof userId === 'undefined' || $.trim(userId.val()).length===0){
		alert('사용자 ID를 입력하십시오.');
		userId.focus();
		return false;
	}
	if(typeof userPasswd === 'undefined' || $.trim(userPasswd.val()).length===0){
		alert('사용자 비밀번호를 입력하십시오.');
		userPasswd.focus();
		return false;
	}
	
	return true;
}
  
	function goLogin() {
		if (validate()) {
			getRSAKey();
			dataSecured();
			$("#loginFrm").submit();
		}
	}

	function getRSAKey() {
		$.ajax({
			async : false, // 동기, 비동기 버튼 (false하면 동기)
			url : '/login/get/rsa-key.do',
			type : 'GET',
			dataType : 'json'
		}).done(function(data) {
			console.log('---------RSA공개키 가져오기 완료---------');
			console.log(data);
			$('#rsaPublicKeyModule').val(data.publicKeyModule);
			$('#rsaPublicKeyExponent').val(data.publicKeyExponent);
		}).fail(function(xhr, status, error) {
			console.log(error);
		});
	}

	function dataSecured() {
		const rsaKey = new RSAKey();
		rsaKey.setPublic($('#rsaPublicKeyModule').val(), $('#rsaPublicKeyExponent').val());
		//설정된 공개키로 암호화
		$('#securedUserId').val(rsaKey.encrypt($('#userId').val()));
		$('#securedUserPasswd').val(rsaKey.encrypt($('#userPasswd').val()));
	}

	$(document).ready(function() {
		btnInit();
	})
</script>
</html>