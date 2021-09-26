package model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;

import dto.Sentence;

public class SentenceModel {
	// ResultSet -> List<String>
		public static List<Sentence> changeResultSetToListSentence(ResultSet rs) {
			List<Sentence> sentenceList = new ArrayList<Sentence>();
			
			try {
				// ResultSet의 내용을 카테고리 ArrayList로 변환
				while (rs.next()) {
					Sentence sentence = new Sentence();
					sentence.setSentenceId(rs.getInt("sentence_id"));
					sentence.setSentence(rs.getString("sentence"));
					sentence.setSpeaker(rs.getString("speaker"));
					sentence.setStoryId(rs.getInt("story_id"));
					sentence.setEmotionId(rs.getInt("emotion_id"));
					sentence.setVoiceId(rs.getInt("voice_id"));
					sentenceList.add(sentence);
				}
			} catch (SQLException e) {
				e.printStackTrace();
				return null;
			}

			return sentenceList;
		}

}
