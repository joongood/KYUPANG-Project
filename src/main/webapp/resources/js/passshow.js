<!-- 비밀번호 수정 버튼을 누르면 비밀번호 수정 input 등장 -->
function pass_show() {
   
	var passwordField = document.getElementById("mpassword");
    var passwordCheckField = document.getElementById("mpassword_check");
    var password_button = document.getElementById("password_button");
	
    password_button.style.display = "none";
    
	// 값 비우기
    passwordField.value = "";
    passwordCheckField.value = "";
	
    var hiddenFields = document.querySelectorAll('.form-group[style="display: none"]');
    for(var i = 0; i < hiddenFields.length; i++) {
        hiddenFields[i].style.display = "block";
    }
}