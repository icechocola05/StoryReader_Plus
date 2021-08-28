package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDao;
import dto.User;

/**
 * Servlet implementation class doJoin
 */
@WebServlet("/doJoin")
public class doJoin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public doJoin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    
	    String user_input_name = request.getParameter("user_input_name");
	    String user_input_id = request.getParameter("user_input_id");
		String user_input_pw = request.getParameter("user_input_pw");
		
		//for DB connection
		ServletContext sc = getServletContext();
		Connection conn = (Connection)sc.getAttribute("DBconnection");
		
		User user = new User();
		user.setUserLoginId(user_input_id);
		user.setUserLoginPw(user_input_pw);
		user.setUserName(user_input_name);
		
		boolean join_result = false;
		
		//try join
		try {
			join_result = UserDao.insertUser(conn, user);
			if(join_result == false) { //join failed
				PrintWriter out = response.getWriter();
				out.println("<script>alert('회원 정보를 확인해주세요.'); location.href='../StoryReader_Plus/join.jsp';</script>");
				out.flush();
			}
			else { //join success
				PrintWriter out = response.getWriter();
				out.println("<script>alert('회원가입 성공'); location.href='../StoryReader_Plus/chooseInput.jsp';</script>");
				out.flush();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
