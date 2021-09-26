package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import dto.Sentence;
import dto.Story;

/**
 * Servlet implementation class makeJson
 */
@WebServlet("/makeJsonServlet")
public class makeJson extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public makeJson() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		JSONArray jsonArray=new JSONArray();
	   
		//DB 정보로 json 만들기
		ServletContext sc = getServletContext();
		//Connection con = (Connection)sc.getAttribute("DBconnection");
		HttpSession session = request.getSession(true);
		
		Story currStory = (Story) session.getAttribute("currStory");
		int story_id = currStory.getStoryId();
		
		List<Sentence> sentenceSet = (List<Sentence>) request.getAttribute("sentenceSet");
		
		//현재 스토리에 대한 문장 정보를 JSON 파일로 생성
		try {
			
			for(int i = 0; i<sentenceSet.size(); i++) {
				Sentence sent = sentenceSet.get(i);
				
				String text = sent.getSentence();
				String voice_name = sent.getVoiceName();
				String emotion_name = sent.getEmotionName();
				float intensityVal = sent.getIntensity();
				
				//JSON 생성
				JSONObject jsonObject=new JSONObject(); 
				JSONObject voiceInfo=new JSONObject();
				JSONObject emoInfo=new JSONObject();
				
				jsonObject.put("text", text);
				jsonObject.put("lang", "ko");
	
				voiceInfo.put("name", voice_name);
				voiceInfo.put("gender", "");
				voiceInfo.put("age", ""); 
				voiceInfo.put("variant", "");
				voiceInfo.put("onvoicefailure", "priorityselect");
				jsonObject.put("voice", voiceInfo);
		        
				emoInfo.put("name", emotion_name);
				emoInfo.put("value", intensityVal);
				jsonObject.put("emotionInfo", emoInfo);
				
		        jsonArray.add(jsonObject);
			}
		}
		catch(Exception e) { //try - catch 필요 없음
			e.printStackTrace();
		}
		request.setAttribute("sentenceSet", sentenceSet);
		request.setAttribute("resultJson", jsonArray);
		session.setAttribute("i", 0);//0으로 초기화?
		RequestDispatcher rd = request.getRequestDispatcher("/TTSConnection");
        rd.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
