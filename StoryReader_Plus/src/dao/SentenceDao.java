package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import dto.Sentence;
import dto.Voice;
import model.SentenceModel;

public class SentenceDao {
	//문장 삽입
	private final static String SQLST_INSERT_SENTENCE="INSERT INTO sentence (sentence, speaker,  story_id, voice_id, emotion_id, intensity) VALUES (?, ?, ?, ?, ?, ?)";
	//Story의 Sentence List 가져오기
	private final static String SQLST_SELECT_SENTENCE_BY_STORY_ID = "SELECT sentence_id, sentence, speaker,  story_id, voice_id, emotion_id, intensity FROM sentence WHERE story_id = ?";
	public static void insertSent(Connection con, String sentence, String speaker, int emotionId, int voiceId, float intensity, int story_id) {
		PreparedStatement pstmt = null;
		try {
			con.setAutoCommit(false);
			
			pstmt = con.prepareStatement(SQLST_INSERT_SENTENCE);
			pstmt.setString(1, sentence);
			pstmt.setString(2, speaker);
			pstmt.setFloat(3, story_id);
			pstmt.setInt(4, voiceId);
			pstmt.setInt(5, emotionId);
			pstmt.setFloat(6, intensity);
			
			pstmt.executeUpdate();
			con.commit();
			con.setAutoCommit(true);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {try {
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} }
		}
	}
	
	public static List<Sentence> getSentenceList(Connection con, int story_id) {
		PreparedStatement pstmt = null;
		try {
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(SQLST_SELECT_SENTENCE_BY_STORY_ID);
			pstmt.setInt(1, story_id);
			ResultSet rs = pstmt.executeQuery();
			con.commit();
			con.setAutoCommit(true);
			List<Sentence> sentenceList = SentenceModel.changeResultSetToListSentence(rs);
			return sentenceList;
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("failed1");
		}
		if(pstmt != null) {
		   try {
				pstmt.close();
			} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					System.out.println("failed2");
			} 
		 }
		return null;
	}
	
	

}
