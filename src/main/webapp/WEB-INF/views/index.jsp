<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    index.jsp Page!!
    <div>
        <label for="roomId">방 번호: </label>
        <input type="text" id="roomId" name="roomId" required placeholder="방 번호 입력">
    </div>

    <script>
        // 자바스크립트로 폼을 처리하는 함수
        function joinChatRoom(event) {
            event.preventDefault();  // 폼이 자동으로 제출되지 않도록 방지

            // 입력된 방 번호를 가져옵니다
            let roomId = document.getElementById('roomId').value;

            if (roomId.trim() === "") {
                alert("방 번호를 입력해주세요.");
                return;
            }

            // 새로운 폼을 동적으로 생성합니다.
            let form = document.createElement('form');
            form.method = 'POST';  // POST 방식으로 전송

            // 방 번호를 폼에 추가
            let input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'roomId';
            input.value = roomId;
            form.appendChild(input);

            // 폼을 제출할 URL 설정
            form.action = '/chatPage';

            // 새 창을 열어서 폼을 제출합니다.
            let newWindow = window.open('', '_blank', 'width=800,height=600');  // 새 창 열기
            if (newWindow) {
                // 새 창에서 폼을 제출할 수 있도록 합니다.
                newWindow.document.body.appendChild(form);
                form.submit();  // 폼을 새 창에 제출
            } else {
                alert("새 창을 열 수 없습니다. 팝업 차단을 확인해주세요.");
            }
        }
    </script>

    <!-- 버튼 클릭 시 joinChatRoom 함수 실행 -->
    <button onclick="joinChatRoom(event)">채팅방 입장</button>


</body>
</html>