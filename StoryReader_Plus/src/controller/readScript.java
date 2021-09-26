package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.SentenceDao;
import dto.Sentence;
import dto.Story;
import dto.Voice;
import dto.Emotion;

/**display.jsp를 개발하는 동안엔 사용안함
 * Servlet implementation class setImg
 */
@WebServlet("/readScript")
public class readScript extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public readScript() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	private static final String ATTACHES_DIR = "C:\\attaches";
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// for DB connection
	    ServletContext sc = getServletContext();
	    Connection con = (Connection)sc.getAttribute("DBconnection");
	      
		response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
		
        HttpSession session = request.getSession(true);
		
        Story selectedStory = (Story)session.getAttribute("selectedStory");
        System.out.println(selectedStory.getStoryId());
		ArrayList<Sentence> sentenceSet = (ArrayList<Sentence>)SentenceDao.getSentenceList(con, selectedStory.getStoryId());
		
		ArrayList<Voice> voiceSet = (ArrayList<Voice>)session.getAttribute("voiceSet");
		ArrayList<Emotion> emotionSet = (ArrayList<Emotion>)session.getAttribute("emotionSet");
		
		ArrayList<String> voiceColorList = new ArrayList<String>();
		ArrayList<String> emoticonNameList = new ArrayList<String>();
		
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
		}
		
		request.setAttribute("sentenceSet", sentenceSet);
		request.setAttribute("voiceColorList", voiceColorList);
		request.setAttribute("emoticonNameList", emoticonNameList);
		
		RequestDispatcher rd = request.getRequestDispatcher("/display.jsp");
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
