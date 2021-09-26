package controller;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.SentenceDao;
import dto.Emotion;
import dto.Sentence;
import dto.Story;
import dto.Voice;

@WebServlet("/setVoiceEmotion")
public class setVoiceEmotion extends HttpServlet {
   private static final long serialVersionUID = 1L;
   public setVoiceEmotion() {
      super();
   }
   protected void doGet(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
      
      System.out.println("OK");
      
      // for DB connection
      ServletContext sc = getServletContext();
      Connection con = (Connection)sc.getAttribute("DBconnection");
      

      response.setContentType("text/html; charset=UTF-8");
      request.setCharacterEncoding("UTF-8");
      HttpSession session = request.getSession(true);
      
      Story currStory = (Story) session.getAttribute("currStory");
      ArrayList<String> speaker = (ArrayList<String>) session.getAttribute("speaker_list");
      List<Voice> voiceSet = (List<Voice>) session.getAttribute("voiceSet");
      List<Emotion> emotionSet = (List<Emotion>) session.getAttribute("emotionSet");
      
      ArrayList<String> sentence = new ArrayList<String>();
      List<Sentence> sentenceSet = new ArrayList<Sentence>();
      String temp;
      
      //문장 받아오기
      for(int i=0; i<speaker.size(); i++) {
         temp = (String)request.getParameter("sentence" + i);
         System.out.println(temp);
         sentence.add(temp);
      }
      
      int sentenceSize = sentence.size();
      
      //DB 등록
      String sentenceInput, speakerInput, voiceVal, emotionVal;
      float intensity;
      String n;
      int index = 0;
         
         //문장 별로 설정 값을 DB에 저장한다.
         for (int i = 0; i < sentenceSize; i++) {
            n = Integer.toString(i);
            speakerInput = speaker.get(i);
            sentenceInput = sentence.get(i);
            
            //문장 별 설정 값들을 가져온다.
            voiceVal = request.getParameter("voiceVal" + n);;
            System.out.println(voiceVal);
            emotionVal = request.getParameter("emotionVal" + n);
            System.out.println(emotionVal);
            intensity = Float.parseFloat(request.getParameter("intensityVal" + n));
            System.out.println(intensity);
            
            //Emotion, Voice의 id 값은 List에서 다시 구한다.
            int emotionId = 0;
            int voiceId = 0;
            for(int j=0; j<voiceSet.size(); j++) {
               if(voiceSet.get(j).getVoiceName().equals(voiceVal)) {
                  voiceId = voiceSet.get(j).getVoiceId();
               }
            }
            for(int j=0; j<emotionSet.size(); j++) {
               if(emotionSet.get(j).getEmotionName().equals(emotionVal)) {
                  emotionId = emotionSet.get(j).getEmotionId();
               }
            }
            int story_id = currStory.getStoryId();
            
            // DB - Sentence 테이블에 삽입
            SentenceDao.insertSent(con, sentenceInput, speakerInput, emotionId, voiceId, intensity, story_id);
            
            //List 형태로 Sentence 저장
            Sentence invidSent = new Sentence();
            invidSent.setSentence(sentenceInput);
            invidSent.setSpeaker(speakerInput);
            invidSent.setEmotionId(emotionId);
            invidSent.setVoiceId(voiceId);
            invidSent.setIntensity(intensity);
            invidSent.setStoryId(story_id);
            
            sentenceSet.add(invidSent);
            
         }
     
      request.setAttribute("isBegan", 1);
      request.setAttribute("playAll","false");
      request.setAttribute("sentenceSet", sentenceSet);
      RequestDispatcher rd = request.getRequestDispatcher("/makeJsonServlet");
      rd.forward(request, response);
      System.out.println("OK last");
   }

   protected void doPost(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
      // TODO Auto-generated method stub
      doGet(request, response);
   }

}