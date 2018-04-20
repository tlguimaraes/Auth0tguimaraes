<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>
<%@page import="org.json.JSONObject"%>

<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Home Page</title>
<link rel="stylesheet" type="text/css" href="/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="/css/jumbotron-narrow.css">
<link rel="stylesheet" type="text/css" href="/css/home.css">
<link rel="stylesheet" type="text/css" href="/css/jquery.growl.css" />
<script src="http://code.jquery.com/jquery.js"></script>
<script src="/js/jquery.growl.js" type="text/javascript"></script>
</head>

<body>

	<div class="container">
		<div class="header clearfix">
			<nav>
				<ul class="nav nav-pills pull-right">
					<li class="active" id="home"><a href="#">Home</a></li>
					<li id="logout"><a href="#">Logout</a></li>
				</ul>
			</nav>
			<h3 class="text-muted">defensecoding.com</h3>
		</div>
		<div class="jumbotron">
			<h3>access_token ${userId}!</h3>
			<a
				href="https://tguimaraes.auth0.com/userinfo?access_token=${userId}">Get
				user_metadata</a>
			<%
			  String recv = "";
						String recvbuff = "";
						//Calling API with token to act on behalf of the user.
						String jsonurl = "https://tguimaraes.auth0.com/userinfo?access_token=" + request.getParameter("userId");
						URL jsonpage = new URL(jsonurl);
						URLConnection urlcon = jsonpage.openConnection();
						BufferedReader buffread = new BufferedReader(new InputStreamReader(urlcon.getInputStream()));

						while ((recv = buffread.readLine()) != null)
							recvbuff += recv;
						buffread.close();

						System.out.println(recvbuff);
			%>
			<p></p>

			<%
			  if (recvbuff.indexOf("admin") > 0) {
							out.println("This user has read, write and delete data access.");
						} else {
							out.println("This user has read data access.");
						}
			%>
			<a href="http://localhost:3000/portal/loadservice">Load Service</a>
		</div>
		<footer class="footer">
			<p>&copy; 2018 defensecoding.com</p>
		</footer>

	</div>

	<script type="text/javascript">
		$("#logout")
				.click(
						function(e) {
							e.preventDefault();
							$("#home").removeClass("active");
							$("#password-login").removeClass("active");
							$("#logout").addClass("active");
							// assumes we are not part of SSO so just logout of local session
							window.location = "${fn:replace(pageContext.request.requestURL, pageContext.request.requestURI, '')}/logout";
						});
	</script>

</body>
</html>


