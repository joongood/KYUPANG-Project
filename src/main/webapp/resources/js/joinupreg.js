//8자리 이상, 대문자, 소문자, 숫자, 특수문자 모두 포함되어 있는 지 검사
var reg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/;          

function member_joinup_modify(){
   if(!memail.value){
      alert("메일을 입력해주세요.");
      memail.focus();
      return false;
   }
   if(!mpassword.value){
      alert("비밀번호를 입력해주세요.");
      check_email.focus();
      return false;
   }
   if(!mpassword_check.value){
      alert("비밀번호 확인을 입력해주세요.");
      mpassword_check.focus();
      return false;
   }
   if(mpassword.value != mpassword_check.value){ // 비밀번호와 비밀번호 확인이 같지 않다면
      alert("비밀번호가 일치하지 않습니다.");
      mpassword.focus();
      return false;         
   }
   if(!mname.value){
      alert("이름을 입력해주세요.");
      mname.focus();
      return false;
   }
   if(!(reg.test(mpassword.value))){
      alert("비밀번호는 8자리 이상이어야 하며, 대문자/소문자/숫자/특수문자를 모두 포함해야 합니다.");
      spassword.focus();
      return false;
      
   }
   if(!mage.value){
      alert("생년월일를 입력해주세요.");
      mage.focus();
      return false;
   }
   if(!mphone.value){
      alert("전화번호를 입력해주세요.");
      mphone.focus();
      return false;
   }
   if(!zipcode.value){
      alert("우편번호를 입력해주세요.");
      zipcode.focus();
      return false;
   }
   if(address.value == ""){
      alert("주소를 입력해주세요.");
      address.focus();
      return false;
   }
   
   // 위의 모든 필드가 유효한 경우 실행
   return true;
}