package com.boot.stomp.controller;

import com.boot.stomp.dto.MessageRequestDto;
import com.boot.stomp.dto.MessageResponseDto;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ChatController {

    @PostMapping("/chatPage")
    public String chatPage(@RequestParam String roomId, Model model) {
        model.addAttribute("roomId", roomId);  // 모델에 roomId 값을 추가
        return "chatPage/chatPage";  // chatPage.jsp로 전달
    }

    @MessageMapping("/chat/{roomId}")
    @SendTo("/topic/chat/{roomId}")
    public MessageResponseDto sendMessage(@DestinationVariable String roomId, MessageRequestDto requestDto) {
        MessageResponseDto responseDto = new MessageResponseDto();
        responseDto.setNickname(requestDto.getNickname());
        responseDto.setContent(requestDto.getContent());
        return responseDto;
    }

}
