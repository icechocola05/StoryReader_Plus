package controller.manageStory;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;

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
import dto.User;
import dto.Voice;

@WebServlet("/readMyScript")
public class readMyScript extends HttpServlet {
   private static final long serialVersionUID = 1L;

    public readMyScript() {
        super();
    }

   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      // for DB connection
       ServletContext sc = getServletContext();
       Connection con = (Connection)sc.getAttribute("DBconnection");
         
      response.setContentType("text/html; charset=UTF-8");
      request.setCharacterEncoding("UTF-8");
      
      HttpSession session = request.getSession(true);
      
      ArrayList<Story> myStory = (ArrayList<Story>)session.getAttribute("myStoryList");
      int story_id = Integer.parseInt(request.getParameter("read_btn"));
      
      System.out.println(story_id);
      int story_id_db = myStory.get(story_id).getStoryId();//사용자가 선택한 story id 받아오기
      ArrayList<Sentence> sentenceSet = (ArrayList<Sentence>)SentenceDao.getSentenceList(con, 
    		  story_id_db);//story id로 해당 story의 sentence list받아오기
      
      User user = (User)session.getAttribute("currUser");
      int user_id = user.getUserId();
           
      //현재 story 설정
      Story currStory = new Story();
      currStory.setStoryId(myStory.get(story_id).getStoryId());
      currStory.setStoryName(myStory.get(story_id).getStoryName());
      currStory.setStoryUser(user_id);
      session.setAttribute("currStory", currStory);
      
      //문장별 voice(->color) 및 emotion(->emoticon) list 설 정
      ArrayList<Voice> voiceSet = (ArrayList<Voice>)session.getAttribute("voiceSet");
	  ArrayList<Emotion> emotionset = (ArrayList<Emotion>)session.getAttribute("emotionSet");
		
	  ArrayList<String> voiceColorList = new ArrayList<String>();
	  ArrayList<String> emoticonNameList = new ArrayList<String>();
	  ArrayList<String> opacityList = new ArrayList<String>();
		
		for(int i=0;i<sentenceSet.size();i++) {
			
			//각 문장의 voice_id와 맞는 voice_color를 리스트 형태로 저장
			voiceColorList.add(voiceSet.get(sentenceSet.get(i).getVoiceId()-1).getVoiceColor());
			
			//[이모티콘 설정]
			//각 문장의 emotion_id에 적절한 emoticon의 이름을 저장
			String emoticon = "";
			switch(sentenceSet.get(i).getEmotionId()) {
				case 1://중립
					emoticon = "noto:neutral-face";
					break;
				case 2://기쁨
					emoticon = "noto:grinning-face-with-smiling-eyes";
					break;
				case 3://화남
					emoticon = "noto:angry-face";
					break;
				case 4://슬픔
					emoticon = "noto:crying-face";
					break;
			}
			emoticonNameList.add(emoticon);
			
			//[투명도 설정]
			//각 문장의 emotion_intensity를 적절한 opacity로 분류
			float val = sentenceSet.get(i).getIntensity();
			String opacity ="";
			if(val>=(float)0.1&& val<=(float)0.3) {//0.1보다 크거나 같고 0.3보다 작거나 같은 경우
	             opacity = "20%";
	          }
	          else if(val>=(float)0.4&&val<=(float)0.7) {//0.4보다 크거나 같고 0.7보다 작거나 같은 경우
	            opacity = "70%";
	          }
	          else if(val>=(float)0.8) {//0.4보다 크거나 같은 경우
	            opacity = "100%";
	         }
	          else {
	        	  opacity = Float.toString(val);
	          }
			 opacityList.add(opacity);
		}
		
		request.setAttribute("sentenceSet", sentenceSet);//sentence list 전달
		request.setAttribute("voiceColorList", voiceColorList);//음색에 따른 color list 전달
		request.setAttribute("emoticonNameList", emoticonNameList);//감정에 따른 emoticon list 전달
		request.setAttribute("opacityList", opacityList);//감정 세기에 따른 opacity list 전달
		
		RequestDispatcher rd = request.getRequestDispatcher("/mydisplay.jsp");
		rd.forward(request, response);

   }
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      doGet(request, response);
   }

}