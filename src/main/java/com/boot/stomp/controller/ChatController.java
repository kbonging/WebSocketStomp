package com.boot.stomp.controller;

import com.boot.stomp.dto.MessageRequestDto;
import com.boot.stomp.dto.MessageResponseDto;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ChatController {

    @GetMapping("/chatPage")
    public String chatPage(){
        return "chatPage/chatPage";
    }

    @MessageMapping("/chat") // "/app/chat"
    @SendTo("/topic/chat")
    public MessageResponseDto sendMessage(MessageRequestDto requestDto){
        MessageResponseDto responseDto = new MessageResponseDto();
        responseDto.setNickname(requestDto.getNickname());
        responseDto.setContent(requestDto.getContent());
        return responseDto;
    }
}
