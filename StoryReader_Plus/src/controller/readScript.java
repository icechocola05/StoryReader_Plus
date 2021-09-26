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

import dto.Sentence;
import dto.Story;

/**
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
		response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession(true);
		ArrayList<Sentence> sentenceSet = (ArrayList<Sentence>)session.getAttribute("sentenceSet");
		if((int)session.getAttribute("sentNum")==-1) {
			session.setAttribute("sentNum", 0);
			RequestDispatcher rd = request.getRequestDispatcher("/play.jsp");
			rd.forward(request, response);
		}
		else {
			if(((String)request.getParameter("move_btn")).equals("pre")){
				int n = Integer.parseInt(request.getParameter("sentNumber"));
				System.out.println(n);
				session.setAttribute("sentNum", n-1);
				RequestDispatcher rd = request.getRequestDispatcher("/play.jsp");
				rd.forward(request, response);
				
			}else if(((String)request.getParameter("move_btn")).equals("next")){
				int n = Integer.parseInt(request.getParameter("sentNumber"));
				System.out.println(n);
				session.setAttribute("sentNum", n+1);
				RequestDispatcher rd = request.getRequestDispatcher("/play.jsp");
				rd.forward(request, response);
			}else if (((String)request.getParameter("move_btn")).equals("replay")){
				session.setAttribute("sentNum", 0);
				RequestDispatcher rd = request.getRequestDispatcher("/play.jsp");
				rd.forward(request, response);
			}
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
