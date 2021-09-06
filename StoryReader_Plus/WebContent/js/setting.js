var isChecked = false;

function selectAll() {
	const checkboxes = document.getElementsByName('settingBox');
	if (isChecked == false) { //전체 체크하기
		checkboxes.forEach((checkbox) => {
			checkbox.checked = true;
		})
		isChecked = true;
		return "체크 해제";
	}
	else { //전체 체크 해제하기
		checkboxes.forEach((checkbox) => {
			checkbox.checked = false;
		})
		isChecked = false;
		return "전체 체크";
	}
}
		
		
function changeVoice(val) {
	const checkboxes = document.getElementsByName('settingBox');
	checkboxes.forEach((checkbox) => {
		if(checkbox.checked == true) {
			var num = checkbox.value;
			var element = document.getElementsByClassName('voice' + num);
			
			if(val == "ema&nea") {
				element[0].style.borderColor="#ffb4b4";
				var target = document.getElementsByName('voiceVal' + num);
				target[0].value = val;
			}
			if(val == "emd&ned") {
				element[0].style.borderColor="#ffffb4";
				var target = document.getElementsByName('voiceVal' + num);
				target[0].value = val;
			}
			if(val == "neg") {
				element[0].style.borderColor="#b4ffb4";
				var target = document.getElementsByName('voiceVal' + num);
				target[0].value = val;
			}
			if(val == "emh&nem") {
				element[0].style.borderColor="#8cb4ff";
				var target = document.getElementsByName('voiceVal' + num);
				target[0].value = val;
			}
			if(val == "emh&nem") {
				element[0].style.borderColor="#b4b4ff";
				var target = document.getElementsByName('voiceVal' + num);
				target[0].value = val;
			}
			if(val == "nep") {
				element[0].style.borderColor="#ddb4ff";
				var target = document.getElementsByName('voiceVal' + num);
				target[0].value = val;
			}
		}
	})
}		

function changeEmotion(i) {
	const checkboxes = document.getElementsByName('settingBox');
	checkboxes.forEach((checkbox) => {
		if(checkbox.checked == true) {
			var num = checkbox.value;
			var element = document.getElementById("emotionFace" + num);
					
			var target = document.getElementById("emotion" + i);
			var val = target.options[target.selectedIndex].text;
			var sentence = document.getElementsByName(sent)[0].value;
			alert(sentence);
		}
	})
			
			
	while( element.hasChildNodes()) {
		element.removeChild(element.firstChild);
	}
			
	if(val == "화남") {
		var added = document.createElement('span');
		
		added.setAttribute('class', 'iconify');
		added.setAttribute('data-inline', 'false');
		added.setAttribute('data-icon', 'noto:angry-face');
		element.appendChild(added);
	}
	if(val == "슬픔") {
		var added = document.createElement('span');
		added.setAttribute('class', 'iconify');
		added.setAttribute('data-inline', 'false');
		added.setAttribute('data-icon', 'noto:crying-face');
		element.appendChild(added);
	}
	if(val == "중립") {
		var added = document.createElement('span');
		added.setAttribute('class', 'iconify');
		added.setAttribute('data-inline', 'false');
		added.setAttribute('data-icon', 'noto:neutral-face');
		element.appendChild(added);
	}
	if(val == "기쁨") {
		var added = document.createElement('span');
		added.setAttribute('class', 'iconify');
		added.setAttribute('data-inline', 'false');
		added.setAttribute('data-icon', 'noto:grinning-face-with-smiling-eyes');
		element.appendChild(added);
	}
			
}

function getPreListen(val){
  	const xhttp = new XMLHttpRequest();
	var sentence = document.getElementById('sentence'+val).value;
	var voice_name = "ema";
	console.log(document.getElementsByName('voiceVal'+val).value);
	console.log(document.getElementsByName('emotionVal'+val).value);
	console.log(document.getElementsByName('emotionIntensityVal'+val).value);
	var emotion_name = "happiness";
	var emotion_intensity = 0.5;
	console.log("sentence="+sentence+"&voice_name="+voice_name+"&emotion_name="+emotion_name+"&intensity="+emotion_intensity.toString());
  	xhttp.onreadystatechange = function () {
    	if (xhttp.readyState == 4 && xhttp.status == 200) {
			console.log(xhttp.responseText);
      		document.getElementById("pre-listen-audio").src = "output/"+xhttp.responseText;
			document.getElementById('player').load();
    	}
 	};
	xhttp.open("POST", "./getPreListen", true);
    xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded; UTF-8");
    xhttp.send("sentence="+sentence+"&voice_name="+voice_name+"&emotion_name="+emotion_name+"&intensity="+emotion_intensity.toString());
}
