package controller.storyUser;

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

@WebServlet("/doJoin")
public class doJoin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public doJoin() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    
	    String user_input_name = request.getParameter("user_input_name");
	    String user_input_id = request.getParameter("user_input_id");
		String user_input_pw = request.getParameter("user_input_pw");
		if (user_input_name.equals("")) {
			PrintWriter out = response.getWriter();
			out.println("<script>alert('이름을 입력해주세요.'); location.href='../StoryReader_Plus/join.jsp';</script>");
			out.flush();
		}else if (user_input_id.equals("")) {
			PrintWriter out = response.getWriter();
			out.println("<script>alert('아이디를 입력해주세요.'); location.href='../StoryReader_Plus/join.jsp';</script>");
			out.flush();
		}else if(user_input_pw.equals("") ){
			PrintWriter out = response.getWriter();
			out.println("<script>alert('비밀번호를 입력해주세요.'); location.href='../StoryReader_Plus/join.jsp';</script>");
			out.flush();
		}
		//for DB connection
		ServletContext sc = getServletContext();
		Connection conn = (Connection)sc.getAttribute("DBconnection");
		
		User user = new User();
		user.setUserLoginId(user_input_id);
		user.setUserLoginPw(user_input_pw);
		user.setUserName(user_input_name);
		
		boolean check_result = false;
		boolean join_result = false;
		
		//try join
		try {
			check_result = UserDao.selectID(conn, user_input_id);
			if (check_result==false) {
				PrintWriter out = response.getWriter();
				out.println("<script>alert('중복된 아이디입니다.'); location.href='../StoryReader_Plus/join.jsp';</script>");
				out.flush();
			}else {
				
				join_result = UserDao.insertUser(conn, user);
				if(join_result == false) { //join failed
					PrintWriter out = response.getWriter();
					out.println("<script>alert('회원 정보를 확인해주세요.'); location.href='../StoryReader_Plus/join.jsp';</script>");
					out.flush();
				}
				else { //join success
					PrintWriter out = response.getWriter();
					out.println("<script>alert('회원가입 성공'); location.href='../StoryReader_Plus/login.jsp';</script>");
					out.flush();
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
