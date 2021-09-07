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
      
function changeEmotion(val) {
         const checkboxes = document.getElementsByName('settingBox');
         checkboxes.forEach((checkbox) => {
            if(checkbox.checked == true) {
               var num = checkbox.value;
               var element = document.getElementsByClassName('emotionFace' + num);
               var target = document.getElementsByName('emotionVal' + num);
               // 기존 element 지우는 부분 필요
               
               if(val == "neutral") {
                  var added = document.createElement('span');
                  added.setAttribute('class', 'iconify');
                  added.setAttribute('data-inline', 'false');
                  added.setAttribute('data-icon', 'noto:neutral-face');
                  document.querySelector('.emotionFace' + num).appendChild(added);
                  target[0].value = val;
                  alert(target[0].value);
               }
               if(val == "happiness") {
                  var added = document.createElement('span');
                  added.setAttribute('class', 'iconify');
                  added.setAttribute('data-inline', 'false');
                  added.setAttribute('data-icon', 'noto:grinning-face-with-smiling-eyes');
                  document.querySelector('.emotionFace' + num).appendChild(added);
                  target[0].value = val;
                  alert(target[0].value);
               }
               if(val == "anger") {
                  var added = document.createElement('span');
                  added.setAttribute('class', 'iconify');
                  added.setAttribute('data-inline', 'false');
                  added.setAttribute('data-icon', 'noto:angry-face');
                  document.querySelector('.emotionFace' + num).appendChild(added);
                  target[0].value = val;
                  alert(target[0].value);
               }
               if(val == "sadness") {
                  var added = document.createElement('span');
                  added.setAttribute('class', 'iconify');
                  added.setAttribute('data-inline', 'false');
                  added.setAttribute('data-icon', 'noto:crying-face');
                  document.querySelector('.emotionFace' + num).appendChild(added);
                  target[0].value = val;
                  alert(target[0].value);
               }
            }
         })
}
      
function changeIntensity(val) {
         const checkboxes = document.getElementsByName('settingBox');
         var intVal = parseInt(val);
         alert(intVal);
         checkboxes.forEach((checkbox) => {
            if(checkbox.checked == true) {
               var num = checkbox.value;
               var element = document.getElementsByClassName('emotionFace' + num);
               var target = document.getElementsByName('intensityVal' + num);
               //css 수정 필요
               
               if(val >= 1 && val <= 3) {
                  target[0].value = val * 0.1;
                  alert(target[0].value);
               }
               else if(val >= 4 && val <= 7) {
                  target[0].value = val * 0.1;
                  alert(target[0].value);
               }
               else if(val >= 8) {
                  target[0].value = val * 0.1;
                  alert(target[0].value);
               }
            }
         })
}


function getPreListen(val){
  	const xhttp = new XMLHttpRequest();
	var sentence = document.getElementById('sentence'+val).value;
	var voice_name = document.getElementById('voiceVal'+val).value;
	var emotion_name = document.getElementById('emotionVal'+val).value;
	var emotion_intensity = document.getElementById('intensityVal'+val).value;
	console.log(val);
	
	console.log(document.getElementById('voiceVal'+val).value);
	console.log(document.getElementById('emotionVal'+val).value);
	console.log(document.getElementById('intensityVal'+val).value);
	
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
