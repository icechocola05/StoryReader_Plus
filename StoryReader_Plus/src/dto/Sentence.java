package dto;

public class Sentence {
	private String sentence;
	private String speaker;
	private int story_id;
	private int voice_id;
	private int emotion_id;
	private float intensity;
	private String voice_name;
	private String emotion_name;
	
	public Sentence() {}
	
	public Sentence(String sentence, String speaker, int story_id, int voice_id, int emotion_id, 
			float intensity) {
		this.sentence = sentence;
		this.speaker = speaker;
		this.story_id = story_id;
		this.voice_id = voice_id;
		this.emotion_id = emotion_id;
		this.intensity = intensity;
	}
	
	public void setVoiceName(String voice_name) {
		this.voice_name = voice_name;
	}
	
	public void setEmotionName(String emotion_name) {
		this.emotion_name = emotion_name;
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
	
	public String getVoiceName() {
		return voice_name;
	}
	
	public String getEmotionName() {
		return emotion_name;
	}
}
