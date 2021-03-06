package controller.makeStory;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.StoryDao;
import dto.Story;
import dto.User;

@WebServlet("/confirmScript")
public class confirmScript extends HttpServlet {
   private static final long serialVersionUID = 1L;
    public confirmScript() {
        super();
    }
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      response.setContentType("text/html; charset=UTF-8");
       request.setCharacterEncoding("UTF-8");
      
      //현재 session의 user 정보 가져오기
      HttpSession session = request.getSession(true);
      User user = (User)session.getAttribute("currUser"); //현재 user
      
      //story title, user id 가져오기
      String title = request.getParameter("title");
      int user_id = user.getUserId();
      
      //Story 객체 생성 및 세션 등록
      Story currStory = new Story(); //현재 만들고 있는 이야기 정보를 담는 story 객체
      currStory.setStoryName(title);
      currStory.setStoryUser(user_id);
      
      session.setAttribute("currStory", currStory);
      
      //rawTxt 가공 후 sentence list 저장
      String rawTxt = request.getParameter("mainTxt"); //rawTxt: 가공 전 전체 본문      
      String[] tempTxt = rawTxt.split("\n"); //가공1_문장 단위로 나누기/ tempTxt: 문장 단위로 자른 배열
      String[] splitTxt;

      ArrayList<String> sentence_list = new ArrayList<String>(); //sentence_list: 화자의 발화만 추출한 문장 리스트
      ArrayList<String> speaker_list = new ArrayList<String>(); //speaker_list: 화자만 추출한 화자 리스트
      int textLen = tempTxt.length;
      for(int i=0; i<textLen; i++) {
         if (tempTxt[i].contains(":")) { //가공2_텍스트에서 화자와 문장을 분리
            splitTxt = tempTxt[i].split(":");
            speaker_list.add(splitTxt[0]); //: 이전은 화자
            sentence_list.add(splitTxt[1]); //: 이후는 문장
         } else {
            speaker_list.add("해설"); //만약 :이 없다면 해설이므로 speaker_list에 해설을 추가
            sentence_list.add(tempTxt[i]);
         }
      }
      request.setAttribute("sentence_list", sentence_list); //모든 문장들은 다음 단계인 setting에서 수정할 수 있기 때문에 request로 전송
      session.setAttribute("speaker_list", speaker_list); //모든 화자는 더 이상 수정사항 없기 때문에 session에 저장
      
      //가공3_중복 화자 제거한 화자 배열, 화자에 따른 문장 번호 구하기
      ArrayList<String> speakerType = new ArrayList<String>(); //speakerType: 중복값 없는 화자 종류
      LinkedHashSet<String> toRemoveOverlap = new LinkedHashSet<>(); //LinkedHashSet은 중복값 저장 불가능 -> 화자 종류만 추출 가능
      for(String speaker : speaker_list)
         toRemoveOverlap.add(speaker);
      for(String speaker : toRemoveOverlap) //중복값 제외한 화자 speakerType에 저장
         speakerType.add(speaker);
      session.setAttribute("speakerType", speakerType); //중복 제외한 화자는 더 이상 수정사항 없기 때문에 session에 저장
      
      //
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
      RequestDispatcher rd = request.getRequestDispatcher("/setting.jsp");
      rd.forward(request, response);
   }

   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      doGet(request, response);
   }

}
