package controller;

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

/**
 * Servlet implementation class readMyScript
 */
@WebServlet("/readMyScript")
public class readMyScript extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public readMyScript() {
        super();
        // TODO Auto-generated constructor stub
    }

   /**
    * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
    */
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      // TODO Auto-generated method stub
      // for DB connection
       ServletContext sc = getServletContext();
       Connection con = (Connection)sc.getAttribute("DBconnection");
         
      response.setContentType("text/html; charset=UTF-8");
      request.setCharacterEncoding("UTF-8");
      
      HttpSession session = request.getSession(true);
      
      ArrayList<Story> myStory = (ArrayList<Story>)session.getAttribute("myStoryList");
      int story_id = Integer.parseInt(request.getParameter("read_btn"));
      
      System.out.println(story_id);
      int story_id_db = myStory.get(story_id).getStoryId();
      ArrayList<Sentence> sentenceSet = (ArrayList<Sentence>)SentenceDao.getSentenceList(con, story_id_db);
      
     
      
      User user = (User)session.getAttribute("currUser");
      int user_id = user.getUserId();
           
      Story currStory = new Story();
      currStory.setStoryId(myStory.get(story_id).getStoryId());
      currStory.setStoryName(myStory.get(story_id).getStoryName());
      currStory.setStoryUser(user_id);
      session.setAttribute("currStory", currStory);
      
      ArrayList<Voice> voiceSet = (ArrayList<Voice>)session.getAttribute("voiceSet");
	  ArrayList<Emotion> emotionset = (ArrayList<Emotion>)session.getAttribute("emotionSet");
		
	  ArrayList<String> voiceColorList = new ArrayList<String>();
	  ArrayList<String> emoticonNameList = new ArrayList<String>();
	  ArrayList<String> opacityList = new ArrayList<String>();
		
		for(int i=0;i<sentenceSet.size();i++) {
			
			//각 문장의 voice_id와 맞는 voice_color를 리스트 형태로 저장
			voiceColorList.add(voiceSet.get(sentenceSet.get(i).getVoiceId()-1).getVoiceColor());
			
			//각 문장의 emotion_id에 적절한 emoticon의 이름을 저장
			String emoticon = "";
			switch(sentenceSet.get(i).getEmotionId()) {
			case 1://슬픔
				emoticon = "noto:neutral-face";
				break;
			case 2://기쁨
				emoticon = "noto:grinning-face-with-smiling-eyes";
				break;
			case 3:
				emoticon = "noto:angry-face";
				break;
			case 4:
				emoticon = "noto:crying-face";
				break;
			}
			emoticonNameList.add(emoticon);
			
			//각 문장의 emotion_intensity를 적절한 opacity로 분류
			float val = sentenceSet.get(i).getIntensity();
			String opacity ="";
			if(val>=(float)0.1&& val<=(float)0.3) {//0.1보다 크고 0.3보다 작은 경우
	             opacity = "20%";
	          }
	          else if(val>=(float)0.4&&val<=(float)0.7) {
	            opacity = "70%";
	          }
	          else if(val>=(float)0.8) {
	            opacity = "100%";
	         }
	          else {
	        	  opacity = Float.toString(val);
	          }
			 opacityList.add(opacity);
		}
		
		request.setAttribute("sentenceSet", sentenceSet);
		request.setAttribute("voiceColorList", voiceColorList);
		request.setAttribute("emoticonNameList", emoticonNameList);
		request.setAttribute("opacityList", opacityList);
		
		RequestDispatcher rd = request.getRequestDispatcher("/mydisplay.jsp");
		rd.forward(request, response);

   }

   /**
    * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
    */
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      // TODO Auto-generated method stub
      doGet(request, response);
   }

}