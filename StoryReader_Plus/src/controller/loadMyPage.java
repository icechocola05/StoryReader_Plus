package controller;

import java.io.IOException;
import java.sql.Connection;
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

import dao.StoryDao;
import dto.Story;
import dto.User;

/**
 * Servlet implementation class loadMyPage
 */
@WebServlet("/loadMyPage")
public class loadMyPage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public loadMyPage() {
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
				
				User currUser = (User)session.getAttribute("currUser");
				
				ArrayList<Story> storyList = StoryDao.getUserStories(con, currUser.getUserId());
				
				session.setAttribute("myStoryList", storyList);
				RequestDispatcher rd = request.getRequestDispatcher("/mypage.jsp");
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
