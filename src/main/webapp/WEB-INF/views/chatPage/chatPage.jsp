<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>STOMP 채팅</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .chat-container {
            max-width: 600px;
            margin: 50px auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        .chat-box {
            height: 300px;
            overflow-y: auto;
            border: 1px solid #ddd;
            padding: 10px;
            margin-bottom: 10px;
            background: #f1f1f1;
        }
    </style>
</head>
<body>

<div class="container chat-container">
    <h2 class="text-center">STOMP 채팅</h2>

    <div class="form-group">
        <label for="nickname">닉네임</label>
        <input type="text" id="nickname" class="form-control" placeholder="닉네임을 입력하세요">
    </div>

    <div class="chat-box" id="chatBox"></div>

    <div class="input-group">
        <input type="text" id="messageInput" class="form-control" placeholder="메시지를 입력하세요">
        <span class="input-group-btn">
            <button class="btn btn-primary" onclick="sendMessage()">전송</button>
        </span>
    </div>

    <button class="btn btn-danger btn-block" onclick="disconnect()">연결 종료</button>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

<script>
    let stompClient = null;

    function connect() {
        let socket = new SockJS('/ws');
        stompClient = Stomp.over(socket);

        stompClient.connect({}, function (frame) {
            console.log('STOMP 연결됨: ' + frame);
            stompClient.subscribe('/topic/chat', function (message) {
                let response = JSON.parse(message.body);
                console.log("받은 메시지:", response);
                console.log("response.nickname:", response.nickname);
                console.log("response.content:", response.content);
                showMessage(response.nickname, response.content);
            });
        });
    }

    function sendMessage() {
        let nickname = document.getElementById("nickname").value;
        let message = document.getElementById("messageInput").value;

        if (!nickname.trim()) {
            alert("닉네임을 입력하세요.");
            return;
        }

        if (stompClient && message.trim() !== "") {
            stompClient.send("/app/chat", {}, JSON.stringify({'nickname': nickname, 'content': message}));
            document.getElementById("messageInput").value = "";
        }
    }

    function showMessage(nickname, message) {
        console.log("📢 showMessage() 호출됨");
        console.log("nickname 값:", nickname);
        console.log("message 값:", message);
    
        let test = "<strong>"+nickname+":</strong>"+ message;
        console.log(test);  // `test` 값을 출력
    
        let chatBox = document.getElementById("chatBox");
        let messageElement = document.createElement("p");
        messageElement.innerHTML = test;
    
        chatBox.appendChild(messageElement);
        chatBox.scrollTop = chatBox.scrollHeight;
    }

    function disconnect() {
        if (stompClient !== null) {
            stompClient.disconnect();
        }
        console.log("STOMP 연결 종료됨");
    }

    window.onload = connect;
</script>

</body>
</html>
