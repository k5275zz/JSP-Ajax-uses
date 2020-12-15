<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1"> <!-- 반응형웹 -->
	<link rel="stylesheet" href="css/bootstrap.css">
	<title>JSP AJAX</title>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>
	<script type="text/javascript"> /* text/javascript는 안적어도 되지만 브라우저를 생각했을때 더 안정적이다. */
		var searchRequest = new XMLHttpRequest();
		var registerRequest = new XMLHttpRequest();
		function searchFunction(){
			searchRequest.open("Post","./UserSerachServlet?userName="+ encodeURIComponent(document.getElementById("userName").value), true)	
			searchRequest.onreadystatechange = searchProcess;
			searchRequest.send(null);
		}
		function searchProcess(){
			var table = document.getElementById("ajaxTable");
			table.innerHTML ="";
			if(searchRequest.readyState == 4 && searchRequest.status == 200){ // 성공적으로 통신이 이루어 졌는지
				var object =eval('('+searchRequest.responseText+')');
				var result = object.result;
				for(var i=0;i<result.length;i++){
					var row = table.insertRow(0);
					for(var j = 0;j < result[i].length;j++){
						var cell = row.insertCell(j);
						cell.innerHTML = result[i][j].value;
					}
				}
			}	
		}
		function registerFunction() {
			registerRequest.open("Post","./UserRegisterServlet?userName="+ encodeURIComponent(document.getElementById("registerName").value) +
										"&userAge="+encodeURIComponent(document.getElementById("registerAge").value) +
										"&userGender="+encodeURIComponent($('input[name=registerGender]:checked').val()) +
										"&userEmail="+encodeURIComponent(document.getElementById("registerEmail").value)
										, true)	
			registerRequest.onreadystatechange = registerProcess;
			registerRequest.send(null);
		}
		function registerProcess(){
			if(registerRequest.readyState == 4 && registerRequest.status == 200){
				var result = registerRequest.responseText;
				if(result != 1){
					alert('등록에 실패했습니다.')
				}else{
					var userName =document.getElementById("userName")
					var registerName =document.getElementById("registerName")
					var userAge =document.getElementById("userAge")
					var userEmail =document.getElementById("userEmail")
					userName.value ="";
					registerName.value ="";
					registerAge.value ="";
					registerEmail.value ="";
					searchFunction();
				}
			}
		}
		window.onload = function(){
					searchFunction();
				}
	</script>
</head>
<body>
	<br>
	<div class="container">
		<div class="form-group row float-right">
			<div class="col-xs-8"> <!-- 어떤 해상도이든 간에 8만큼의 크기를 가진다. -->
			<!-- 입력창에 입력을 할때마다 searchFunction()이 실행되게 한다. -->
				<input class="form-control" id="userName" onkeyup="searchFunction()" type="text" size="20"> <!-- 20글자까지들어갈수있게 -->
			</div>
			<div class="col-xs-2">
			<!-- onclickFunction을 지정해준다. -->
				<button class="btn btn-primary" onclick="searchFunction();" type="button">검색</button>
			</div>
		</div>
		<table class="table" style="text-align:center; border:1px solid #dddddd">
			<thead>
				<tr>
					<td style="background :#fafafa; text-align:center;">이름</td>
					<td style="background :#fafafa; text-align:center;">나이</td>
					<td style="background :#fafafa; text-align:center;">성별</td>
					<td style="background :#fafafa; text-align:center;">이메일</td>
				</tr>
			</thead>
			<tbody id="ajaxTable">
				
			</tbody>
		</table>
	</div>
	<div class="container">
		<table class="table" style="text-align: center; border: 1px solid #dddddd;">
			<thead>
				<tr>
					<th colspan="2" style="background: #fafafa; text-align: center;">회원 등록 양식</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="background: #fafafa; text-align: center;" ><h5>이름</h5></td>
					<td><input class="form-control" type="text" id="registerName" size="20"></td>
				</tr>
				<tr>
					<td style="background: #fafafa; text-align: center;" ><h5>나이</h5></td>
					<td><input class="form-control" type="text" id="registerAge" size="20"></td>
				</tr>
				<tr>
					<td style="background: #fafafa; text-align: center;" ><h5>성별</h5></td>
					<td>
						<div class="form-group" style="text-align: center; margin: 0 auto;">
							<div class="btn-group" data-toggle="buttons"> 
								<label class="btn btn-primary active">
									<input type="radio" name="registerGender" autocomplete="off" value="남자" checked="checked">남자
								</label>
								<label class="btn btn-primary">
									<input type="radio" name="registerGender" autocomplete="off" value="여자">여자
								</label>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td style="background: #fafafa; text-align: center;" ><h5>이메일</h5></td>
					<td><input class="form-control" type="text" id="registerEmail" size="20"></td>
				</tr>
				<tr>
					<td colspan="2"><button class="btn btn-primary float-right" onclick="registerFunction();" type="button">등록</button> </td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>