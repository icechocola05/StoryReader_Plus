package controller;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.LinkedHashSet;

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

/**
 * Servlet implementation class EditStory
 */
@WebServlet("/EditStory")
public class EditStory extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditStory() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// for DB connection
	       ServletContext sc = getServletContext();
	       Connection con = (Connection)sc.getAttribute("DBconnection");
	         
	      response.setContentType("text/html; charset=UTF-8");
	      request.setCharacterEncoding("UTF-8");
	      
	      HttpSession session = request.getSession(true);
	      
	      Story currStory = (Story)session.getAttribute("currStory");
	      int story_id = currStory.getStoryId();
	      ArrayList<Sentence> sentenceSet = (ArrayList<Sentence>)SentenceDao.getSentenceList(con, story_id);
	      
	      ArrayList<Voice> voiceSet = (ArrayList<Voice>)session.getAttribute("voiceSet");
		  ArrayList<Emotion> emotionset = (ArrayList<Emotion>)session.getAttribute("emotionSet");
		
		  ArrayList<String> voiceColorList = new ArrayList<String>();
		  ArrayList<String> emoticonNameList = new ArrayList<String>();
		  ArrayList<String> opacityList = new ArrayList<String>();
		  ArrayList<String> speakerType = new ArrayList<String>();
		  ArrayList<String> speaker_list = new ArrayList<String>();
		  LinkedHashSet<String> toRemoveOverlap = new LinkedHashSet<>(); //LinkedHashSet은 중복값 저장 불가능 
			
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
				 
				 speaker_list.add(sentenceSet.get(i).getSpeaker());
				 
			}
		 for(String speaker : speaker_list)
	         toRemoveOverlap.add(speaker);
	      for(String speaker : toRemoveOverlap) //중복값 제외한 화자 speakerType에 저장
	         speakerType.add(speaker);
	      session.setAttribute("speakerType", speakerType); //중복 제외한 화자 -> 더 이상 수정사항 없음
		
			int speakerNum[][] = new int[30][50];
		 	int i = 0;
		 	for(String st : speakerType) {
		 		int j = 0, t = 0;
		 		for(String s : speaker_list ) {
		 			if (s.equals(st)) {
		 				speakerNum[i][t++] = j;
		 			}
		 			j++;
		 		}
		 		i++;
	         
		 	}
		 	request.setAttribute("speakerNum", speakerNum);
		 	request.setAttribute("speakerType", speakerType); //중복 제외한 화자 -> 더 이상 수정사항 없음
			request.setAttribute("sentenceSet", sentenceSet);
			request.setAttribute("voiceColorList", voiceColorList);
			request.setAttribute("emoticonNameList", emoticonNameList);
			request.setAttribute("opacityList", opacityList);
			
			RequestDispatcher rd = request.getRequestDispatcher("/edit.jsp");
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
