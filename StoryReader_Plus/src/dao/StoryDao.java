package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dto.Story;
import dto.Voice;
import model.SettingModel;
import model.StoryModel;

public class StoryDao {
	
	//Story 삽입
	private final static String SQLST_INSERT_STORY = "INSERT INTO story (story_name, user_id) VALUES (?, ?)";
	private final static String SQLST_SELECT_USER_STORY = "SELECT * FROM story WHERE user_id = ?";
	
	//Story 삽입 성공 시 story 객체 return
	public static Story insertStory(Connection con, String title, int user_id) throws SQLException {
		PreparedStatement pstmt = null;
		Story story = new Story();
		try {
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(SQLST_INSERT_STORY, Statement.RETURN_GENERATED_KEYS);
			pstmt.setString(1, title);
			pstmt.setInt(2, user_id);
			
			pstmt.executeUpdate();
			
			//넣은 데이터의 story_id 값 가져오기
			ResultSet rs = pstmt.getGeneratedKeys();  
			rs.next();  
			int id = rs.getInt(1);
			
			con.commit();
			con.setAutoCommit(true);
			
			story.setStoryId(id);
			story.setStoryName(title);
			story.setStoryUser(user_id);
			
			return story;
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {pstmt.close(); }
		}
		return story;
	}
	
	public static ArrayList<Story> getUserStories(Connection con, int user_id) {
		PreparedStatement pstmt = null;
		try {
			con.setAutoCommit(false);
			
			pstmt = con.prepareStatement(SQLST_SELECT_USER_STORY, Statement.RETURN_GENERATED_KEYS);
			pstmt.setInt(1, user_id);
			
			ResultSet storyRS = pstmt.executeQuery();
			ArrayList<Story> storyList = StoryModel.changeResultSetToListStory(storyRS);
			
			return storyList;
		
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		
	}

}
