function sale_cal() {
    var price = parseFloat(document.getElementById("price").value); // 판매가격 입력값 가져오기
    var sale_per = document.getElementById("sale_per").value; // 세일 비율 입력값 가져오기
    var saleprice;

    if (!isNaN(price) && price > 0) {
        if (sale_per.includes("%")) {
        	sale_per = parseFloat(sale_per.replace("%", "")) / 100; // '%' 제거 후 소수점 변환
        } else {
        	sale_per = parseFloat(sale_per);
        }

        if (!isNaN(sale_per)) {
        	saleprice = price - Math.floor(price * sale_per); // 세일금액 계산
        } else {
        	saleprice = 0; // 비율이 잘못된 경우 0으로 처리
        }
    } else {
    	saleprice = 0; // 가격이 잘못된 경우 0으로 처리
    }

    document.getElementById("saleprice").value = saleprice; // 계산된 세일금액를 입력란에 표시
}