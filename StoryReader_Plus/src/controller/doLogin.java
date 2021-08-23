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

@WebServlet("/doLogin")
public class doLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public doLogin() {
        super();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user_input_id = request.getParameter("user_input_id");
		String user_input_pw = request.getParameter("user_input_pw");
		
		//for DB connection
		ServletContext sc = getServletContext();
		Connection conn = (Connection)sc.getAttribute("DBconnection");
		
		//try login
		User currUser = new User();
		try {
			currUser = UserDao.findUser(conn, user_input_id, user_input_pw);
			if(currUser == null) { //login failed
				PrintWriter out = response.getWriter();
				out.println("<script>alert('회원 정보를 확인해주세요.'); location.href='/login';</script>");
				out.flush();
			}
			else { //login success
				PrintWriter out = response.getWriter();
				out.println("<script>alert('로그인 성공'); location.href='/';</script>");
				out.flush();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
