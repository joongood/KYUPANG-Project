function admin_member_join_modify(){
   if(!mname.value){
      alert("이름을 입력해주세요.");
      mname.focus();
      return false;
   }
   
   if(!mage.value){
      alert("생년월일을 입력해주세요.");
      mage.focus();
      return false;
   }
   
   if(!mgender.value){
      alert("성별을 선택해주세요.");
      mgender.focus();
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
   
   if(mlevel.value == ""){
      alert("레벨을 입력해주세요.");
      address.focus();
      return false;
   }
   
   if(mlevel.value == ""){
      alert("레벨을 입력해주세요.");
      address.focus();
      return false;
   }
   
   // 위의 모든 필드가 유효한 경우 실행
   return true;
}