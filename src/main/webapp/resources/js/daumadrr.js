   function openZipSearch() {
       new daum.Postcode({
           oncomplete: function(data) {     
               var address = ''; 
               if (data.userSelectedType === 'R') { 
                  address = data.roadAddress;
               } else {
                  address = data.jibunAddress;
               }
   
               $("#zipcode").val(data.zonecode);
               $("#address").val(address);
               $("#addressdetail").val("");
               $("#addressdetail").focus();
           }
       }).open();
   }
