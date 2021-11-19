package controller;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.StoryDao;
import dto.Story;

/**
 * Servlet implementation class DeleteStory
 */
@WebServlet("/DeleteStory")
public class DeleteStory extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteStory() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//DB 정보로 json 만들기
				ServletContext sc = getServletContext();
				Connection con = (Connection)sc.getAttribute("DBconnection");
				HttpSession session = request.getSession(true);
				
				Story currStory = (Story) session.getAttribute("currStory");
				
				int story_id = currStory.getStoryId();
				
				StoryDao.deleteStory(con, story_id);
				
				RequestDispatcher rd = request.getRequestDispatcher("/loadMyPage");
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
