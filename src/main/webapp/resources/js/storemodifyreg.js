//8자리 이상, 대문자, 소문자, 숫자, 특수문자 모두 포함되어 있는 지 검사
var reg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/;          

function store_modify_reg(){
   if(!mutual.value){
      alert("상호명을 입력해주세요.");
      mutual.focus();
      return false;
   }
   
   if(bnumber.value == ""){
      alert("사업자 등록번호를 입력해주세요.");
      bnumber.focus();
      return false;
   }
   
   if(!(reg.test(spassword.value))){
      alert("비밀번호는 8자리 이상이어야 하며, 대문자/소문자/숫자/특수문자를 모두 포함해야 합니다.");
      spassword.focus();
      return false;
      
   }
   if(!spassword.value){
      alert("비밀번호를 입력해주세요.");
      spassword.focus();
      return false;
   }
   
   if(spassword.value != repass.value){ // 비밀번호와 비밀번호 확인이 같지 않다면
      alert("비밀번호가 일치하지 않습니다.");
      repass.focus();
      return false;         
   }
   
   if(!ownername.value){
      alert("대표자명을 입력해주세요.");
      ownername.focus();
      return false;
   }
   
   if(!sphone.value){
      alert("전화번호를 입력해주세요.");
      sphone.focus();
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

   if(otp.value == ""){
      alert("OTP를 입력해주세요.");
      otp.focus();
      return false;
   }
   
   // 위의 모든 필드가 유효한 경우 실행
   return true;
}