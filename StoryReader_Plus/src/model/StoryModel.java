package model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.Story;

public class StoryModel {

	// ResultSet -> List<String>
	public static ArrayList<Story> changeResultSetToListStory(ResultSet rs) {
		ArrayList<Story> storyList = new ArrayList<Story>();
		
		try {
			// ResultSet의 내용을 카테고리 ArrayList로 변환
			while (rs.next()) {
				Story story = new Story();
				story.setStoryId(rs.getInt("story_id"));
				story.setStoryName(rs.getString("story_name"));
				story.setStoryUser(rs.getInt("user_id"));
				storyList.add(story);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}

		return storyList;
	}
}
