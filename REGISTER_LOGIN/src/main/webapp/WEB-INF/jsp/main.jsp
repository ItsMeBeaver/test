<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<html>
<head>
	<title>Home</title>
		<!-- 합쳐지고 최소화된 최신 CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<!-- 부가적인 테마 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!-- 	<script src="/js/jquery.serializeObject.js"></script> -->
 	
 	<script type="text/javascript">
	$(document).ready(function(){
		$("#logoutBtn").on("click", function(){
			location.href="/logout";
		})
	})
</script>
<script type="text/javascript">
	/*function functionname() {
		alert('click');
	}*/

	/*var functionname = function() {
		//var param1 = "abc";
		//alert(param1);

		var array = [1,2,3,4,5];
		//for (var i = 0; i < array.length; i++) {
			//alert(array[i]);
		//}

		var param = {
			id : "abc",
			password : "123",
			name : "myname"
		};

		alert("id - " + param.id);
		alert("password - " + param.password);
		alert("name - " + param.name);
	}*/
	

	 function getUserInfo() {
		$.ajax({
	        url: "/getUserInfo",
	        type: "POST",
	        dataType: "json",
	        data: {
	        	userId:$("#ajax_userId").val()
	        },
	        success: function(data){
				/*if($('#userId').val() != null ){
					alert($('#userId').val());
					
					//$('#idCheck').empty();
					//$('#idCheck').append(html);
				}else{

					var html="<tr><td colspan='3' style='color: red'>존재하지 않는 아이디</td></tr>";
					//$('#idCheck').empty();
					//$('#idCheck').append(html);
				}*/
				console.log(data);
				
				var str = '<table border="1">';
				str += '<tr>';
				str += '<td>이름</td>';
				str += '<td>아이디</td>';
				str += '</tr>';
				str += '<tr>';
				str += '<td>' + data.userName + '</td>';
				str += '<td>' + data.userId + '</td>';
				str += '</tr>';
				str += '</table>';
				$("#userInfoDetail").html(str);
			},
			/* 일부러 에러 error: function(request,status,error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); 
			}*/
	  	});
	}



		function formContents(){
	
			 var form = $("#ajax_test2")[0];
			 var data = new FormData(form);
			 
				$.ajax({
					url : "/formContents",
			        type: "POST",
			        dataType : "JSON",
			        data: data,
			        processData: false,    
			        contentType: false,      
			        cache: false,           
			        timeout: 600000,       
			        success: function (data) { 
			        	alert("complete");    
			        	console.log(data.userId);    
			        	console.log(data.userName);  
			        	var str = '<table border="1">';
						str += '<tr>';
						str += '<td>이름</td>';
						str += '<td>아이디</td>';
						str += '</tr>';
						str += '<tr>';
						str += '<td>' + data.userName+ '</td>';
						str += '<td>' + data.userId+ '</td>';
						str += '</tr>';
						str += '</table>';
						$("#printContents").html(str);   
	 		        },          
			        error: function (e) {  
			        	console.log("ERROR : ", e);         
			            alert("fail");      
			         }     
			  	});
			}
		

</script>
	
</head>

<body>
	<form name='homeForm' method="post" action="/login">
		<c:if test="${member == null}">
			<h4>▶회원가입</h4>
			<div>
				아이디<label for="userId"></label>
				<input type="text" id="userId" name="userId">
			</div>
			
			<div>
				비밀번호<label for="userPass"></label>
				<input type="password" id="userPass" name="userPass">
			</div>
			<div>
				<button type="submit" id="loginBtn" name=loginBtn>로그인</button> 
				<button type="button" onclick="location.href='/register'">회원가입</button> 
			</div>
			<br>

			
		</c:if>
		<c:if test="${member != null }">
			
				<p>접속 ID : ${member.userId}</p>
				<p>${member.userName}님 환영합니다.</p>
				<script type="text/javascript">
					alert("어서오세요");
				</script>
				
				<div>
					<!-- 회원정보<label for="userInfo"></label>
					<input type="text" id="userInfo" name="userInfo"> -->
					<!-- <a onclick="getUserInfo();">회원정보 조회</a> -->
					
				</div>
				<button id="logoutBtn" type="button">로그아웃</button>
		</c:if>
		<c:if test="${msg == false}">
			<p style="color: red;">로그인 실패! 아이디와 비밀번호 확인해주세요.</p>
		</c:if>
	</form>
	
	<form name='ajax_test' method="post">
		<h4>▶회원정보 확인 (element 전송)</h4>
		<div>
				아이디<label for="ajax_userId"></label>
				<input type="text" id="ajax_userId" name="ajax_userId"><br>
				<button type="button" onclick="getUserInfo();">회원정보 조회(id)</button>
				<button type="reset" id="remove_table">지우기</button>
				<div id="userInfoDetail"> </div> <!-- 여기에 출력하기위해 아이디를 지정해준거임 -->
				
		</div>
		

	</form>
	
	<form name='ajax_test2' method="post" id='ajax_test2'>
		<br><h4>▶회원정보 (form 전송)</h4>
		<div>
				아이디<label for="userId2"></label>
				<input type="text" id="userId2" name="userId"><br>
				<button type="button" onclick="formContents();">회원이름 조회</button>
				<button type="reset">지우기</button>
				<div id="printContents"></div> <!-- 여기에 출력하기위해 아이디를 지정해준거임 -->
		</div>	
				
	</form>
	
</body>
</html>
