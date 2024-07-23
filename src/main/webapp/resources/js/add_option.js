    // 현재 화면에 표시된 옵션 개수를 저장할 변수
    var currentOptionCount = 0;

    // 옵션 추가 버튼 클릭 시 실행되는 함수
    function addOption() {
        // 현재 표시된 옵션 개수를 증가시킴
        currentOptionCount++;

        // 최대 5개의 옵션까지만 처리
        if (currentOptionCount <= 5) {
            // 해당 순번의 입력 필드 타입을 hidden에서 text로 변경
            var inputId = "option_value" + currentOptionCount;
            var inputField = document.getElementById(inputId);
            inputField.type = "text";
            inputField.placeholder = "옵션을 입력해주세요.";
        }

        // 옵션 추가 후, 버튼 다시 숨기기 (최대 5개까지만 처리)
        if (currentOptionCount >= 5) {
            document.getElementById("opt_button").style.display = "none";
        }

        // 숨겨진(hidden) 입력 상자로 변경하는 버튼 보이기
        document.getElementById("reset_button").style.display = "inline-block";
    }

    // 숨겨진(hidden) 입력 상자로 변경하는 함수
    function resetInputs() {
        // 모든 옵션 입력 필드를 숨겨진(hidden) 상태로 변경
        for (var i = 1; i <= 5; i++) {
            var inputId = "option_value" + i;
            var inputField = document.getElementById(inputId);
            inputField.type = "hidden";
            inputField.value = ""; // 값 초기화 (선택적)
            inputField.placeholder = "옵션을 입력해주세요."; // 플레이스홀더 설정 (선택적)
        }

        // 현재 옵션 개수 초기화
        currentOptionCount = 0;

        // "옵션추가" 버튼 보이기
        document.getElementById("opt_button").style.display = "inline-block";

        // 숨겨진(hidden) 입력 상자로 변경하는 버튼 숨기기
        document.getElementById("reset_button").style.display = "none";
    }