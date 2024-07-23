	function point_cal() {
	    var price = parseFloat(document.getElementById("price").value); // 판매가격 입력값 가져오기
	    var point_per = document.getElementById("point_per").value; // 포인트 비율 입력값 가져오기
	    var point;
	
	    if (!isNaN(price) && price > 0) {
	        if (point_per.includes("%")) {
	            point_per = parseFloat(point_per.replace("%", "")) / 100; // '%' 제거 후 소수점 변환
	        } else {
	            point_per = parseFloat(point_per);
	        }
	
	        if (!isNaN(point_per)) {
	            point = Math.floor(price * point_per); // 포인트 계산
	        } else {
	            point = 0; // 비율이 잘못된 경우 0으로 처리
	        }
	    } else {
	        point = 0; // 가격이 잘못된 경우 0으로 처리
	    }
	
	    document.getElementById("point").value = point; // 계산된 포인트를 입력란에 표시
	}