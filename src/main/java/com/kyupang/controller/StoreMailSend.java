package com.kyupang.controller;

import java.io.IOException;
import java.util.Date;
import java.util.Properties;
import java.util.Random;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/store/")
@Log4j
public class StoreMailSend {

   private String number;
   
   @GetMapping("email")
   public String doMail(String semail) throws ServletException, IOException {
      log.info("semail:"+semail);

      //gmail 아이디(메일주소), 앱 비밀번호(2단계 인증) 발급받은 16자리
      String user = "t01053879265@gmail.com";
      String password = "tszaiuppzuqiizuy";

      String receiver = semail; //받는 사람 메일
      String subject = "메일 인증번호를 확인 하세요";
      this.number = generateRandomNumber();
      String content = "인증번호 : "+ this.number;

      try {
         Properties p = new Properties(); //서버 정보를 p객체에 저장

         p.put("mail.smtp.starttls.enable","true");
         p.put("mail.smtp.host","smtp.gmail.com"); //gmail.com
         p.put("mail.smtp.auth", "true");
         p.put("mail.smtp.port", "587"); //gmail 포트번호

         //인증정보 생성
         Session s = Session.getInstance(p, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
               return new PasswordAuthentication(user, password);
            }
         });

         Message m = new MimeMessage(s); //s객체를 사용하여 전송할 m객체 생성

         Address receiver_address = new InternetAddress(receiver); //받는 사람

         //메일 전송에 필요한 설정 부분
         m.setHeader("content-type", "text/html;charset=utf-8");
         m.addRecipient(Message.RecipientType.TO, receiver_address);
         m.setSubject(subject);
         m.setContent(content, "text/html;charset=utf-8");
         m.setSentDate(new Date());

         Transport.send(m); //메세지를 메일로 전송

      } catch (Exception e) {
         e.printStackTrace();
      }

      return "success";
   }
   
   
   // 랜덤한 6자리 숫자 생성
    private String generateRandomNumber() {
        Random random = new Random();
        int number = random.nextInt(900000) + 100000; // 100000부터 999999까지의 난수 생성
        return String.valueOf(number);
    }

   @GetMapping("ok")
   public String okMail(String str) {
      log.info("str:"+str);

      String result;
      if(this.number.equals(str)) {
         result = "yes";
      }else {
         result = "no";
      }
      return result;
   }
}
