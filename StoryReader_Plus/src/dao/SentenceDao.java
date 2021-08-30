package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import dto.Sentence;

public class SentenceDao {
	public static Sentence insertSent(Connection con, String sentence, String speaker, int emotionId, int voiceId, float intensity, int story_id) throws SQLException {
		PreparedStatement pstmt = null;
		try {
			con.setAutoCommit(false);
			
			pstmt = con.prepareStatement("INSERT INTO sentence (sentence, speaker,  story_id, voice_id, emotion_id, intensity) VALUES (?, ?, ?, ?, ?, ?)");
			pstmt.setString(1, sentence);
			pstmt.setString(2, speaker);
			pstmt.setFloat(3, story_id);
			pstmt.setInt(4, voiceId);
			pstmt.setInt(5, emotionId);
			pstmt.setFloat(6, intensity);
			
			pstmt.executeUpdate();
			con.commit();
			con.setAutoCommit(true);
			
			Sentence sent = new Sentence(sentence, speaker, story_id, voiceId, emotionId, intensity);
			return sent;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {pstmt.close(); }
		}
		return null;
	}

}
