package dto;

public class Sentence {
	private int sentence_id;
	private String sentence;
	private String speaker;
	private int story_id;
	private int voice_id;
	private int emotion_id;
	private float intensity;

	public Sentence() {this.sentence_id=-1;}
	
	public void setSentenceId(int sentence_id) {
		this.sentence_id = sentence_id;
	}
	public void setSentence(String sentence) {
		this.sentence = sentence;
	}
	public void setSpeaker(String speaker) {
		this.speaker = speaker;
	}
	public void setStoryId(int story_id) {
		this.story_id = story_id;
	}
	public void setVoiceId(int voice_id) {
		this.voice_id = voice_id;
	}
	public void setEmotionId(int emotion_id) {
		this.emotion_id = emotion_id;
	}
	public void setIntensity(float intensity) {
		this.intensity = intensity;
	}

	
	public String getSentence() {
		return sentence;
	}
	
	public String getSpeaker() {
		return speaker;
	}
	
	public int getStoryId() {
		return story_id;
	}
	
	public int getVoiceId() {
		return voice_id;
	}
	
	public int getEmotionId() {
		return emotion_id;
	}
	
	public float getIntensity() {
		return intensity;
	}
	

}
