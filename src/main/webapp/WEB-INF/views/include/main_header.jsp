<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%--main_header.jsp--%>
<%-- Main Header --%>
<header class="main-header">
	<%-- Logo --%>
	<a href="/" class="logo"> <%-- mini logo for sidebar mini 50x50 pixels --%>
		<span class="logo-mini"><b>S</b>E</span> <%-- logo for regular state and mobile devices --%>
		<span class="logo-lg"><b>Spring</b> - Examples</span>
	</a>

	<%-- Header Navbar --%>
	<nav class="navbar navbar-static-top" role="navigation">
		<%-- Sidebar toggle button--%>
		<a href="#" class="sidebar-toggle" data-toggle="push-menu"
			role="button"> <span class="sr-only">Toggle navigation</span>
		</a>
		<%-- Navbar Right Menu --%>
		<div class="navbar-custom-menu">
			<ul class="nav navbar-nav">
				<%-- Messages: style can be found in dropdown.less--%>
				<li class="dropdown messages-menu">
					<%-- Menu toggle button --%> <a href="#" class="dropdown-toggle"
					data-toggle="dropdown"> <i class="fa fa-envelope-o"></i> <span
						class="label label-success">4</span>
				</a>
					<ul class="dropdown-menu">
						<li class="header">You have 4 messages</li>
						<li>
							<%-- inner menu: contains the messages --%>
							<ul class="menu">
								<li>
									<%-- start message --%> <a href="#">
										<div class="pull-left">
											<%-- User Image --%>
											<img
												src="<c:url value="/resources/dist/img/default-user-image.jpg"/>"
												class="img-circle" alt="User Image">
										</div> <%-- Message title and timestamp --%>
										<h4>
											Support Team <small><i class="fa fa-clock-o"></i> 5
												mins</small>
										</h4> <%-- The message --%>
										<p>Why not buy a new awesome theme?</p>
								</a>
								</li>
								<%-- end message --%>
							</ul> <%-- /.menu --%>
						</li>
						<li class="footer"><a href="#">See All Messages</a></li>
					</ul>
				</li>
				<%-- /.messages-menu --%>

				<%-- Notifications Menu --%>
				<li class="dropdown notifications-menu">
					<%-- Menu toggle button --%> <a href="#" class="dropdown-toggle"
					data-toggle="dropdown"> <i class="fa fa-bell-o"></i> <span
						class="label label-warning">10</span>
				</a>
					<ul class="dropdown-menu">
						<li class="header">You have 10 notifications</li>
						<li>
							<%-- Inner Menu: contains the notifications --%>
							<ul class="menu">
								<li>
									<%-- start notification --%> <a href="#"> <i
										class="fa fa-users text-aqua"></i> 5 new members joined today
								</a>
								</li>
								<%-- end notification --%>
							</ul>
						</li>
						<li class="footer"><a href="#">View all</a></li>
					</ul>
				</li>
				<%-- Tasks Menu --%>
				<li class="dropdown tasks-menu">
					<%-- Menu Toggle Button --%> <a href="#" class="dropdown-toggle"
					data-toggle="dropdown"> <i class="fa fa-flag-o"></i> <span
						class="label label-danger">9</span>
				</a>
					<ul class="dropdown-menu">
						<li class="header">You have 9 tasks</li>
						<li>
							<%-- Inner menu: contains the tasks --%>
							<ul class="menu">
								<li>
									<%-- Task item --%> <a href="#"> <%-- Task title and progress text --%>
										<h3>
											Design some buttons <small class="pull-right">20%</small>
										</h3> <%-- The progress bar --%>
										<div class="progress xs">
											<%-- Change the css width attribute to simulate progress --%>
											<div class="progress-bar progress-bar-aqua"
												style="width: 20%" role="progressbar" aria-valuenow="20"
												aria-valuemin="0" aria-valuemax="100">
												<span class="sr-only">20% Complete</span>
											</div>
										</div>
								</a>
								</li>
								<%-- end task item --%>
							</ul>
						</li>
						<li class="footer"><a href="#">View all tasks</a></li>
					</ul>
				</li>
				<%-- User Account Menu --%>
				<li class="dropdown user user-menu">
					<%-- Menu Toggle Button --%> <a href="#" class="dropdown-toggle"
					data-toggle="dropdown"> <%-- The user image in the navbar--%> <img
						src="<c:url value="/resources/dist/img/default-user-image.jpg"/>"
						class="user-image" alt="User Image"> <%-- hidden-xs hides the username on small devices so only the image appears. --%>
						<c:if test="${sessionScope.userInfo != null}">
							<span class="hidden-xs">${sessionScope.userInfo.userName}</span>
						</c:if> <c:if test="${sessionScope.userInfo == null}">
							<span class="hidden-xs">Guest</span>
						</c:if>
				</a>
					<ul class="dropdown-menu">
						<%-- The user image in the menu --%>
						<c:if test="${sessionScope.userInfo != null}">
							<li class="user-header"><img
								src="<c:url value="/resources/dist/img/default-user-image.jpg"/>"
								class="img-circle" alt="User Image">
								<p>${sessionScope.userInfo.userName}</p></li>
							<%-- Menu Footer--%>
							<li class="user-footer">
								<div class="pull-left">
									<a href="#" class="btn btn-default btn-flat">프로필</a>
								</div>
								<div class="pull-right">
									<a href="#" class="btn btn-default btn-flat"
										onclick="logOut();">로그아웃</a>
								</div>
							</li>
						</c:if>
						<c:if test="${sessionScope.userInfo == null}">
							<li class="user-header">
							    <img src="<c:url value="/resources/dist/img/default-user-image.jpg"/>"
								class="img-circle" alt="User Image">
								<p>Guest</p>
						    </li>
							<%-- Menu Footer--%>
							<li class="user-footer">
								<div class="pull-left">
									<a href="#" class="btn btn-default btn-flat" onclick="join()">회원가입</a>
								</div>
								<div class="pull-right">
									<a href="#" class="btn btn-default btn-flat"
										onclick="login();">로그인</a>
								</div>
							</li>
						</c:if>
					</ul>
				</li>
				<%-- Control Sidebar Toggle Button --%>
			</ul>
		</div>
	</nav>
	<script type="text/javascript">
	
	    function login() {
			location.href= "/login/form.do";
		}
	
		function logOut() {
			location.href = "/login/out.do";
		}
		function join() {
			location.href = "/login/join.do";
		}
	</script>
</header>