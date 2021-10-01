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
             element[0].style.borderColor="#EF9CA1";
           element[0].style.backgroundColor="#EF9CA1";
             var target = document.getElementsByName('voiceVal' + num);
             target[0].value = val;
          }
          if(val == "emd&ned") {
             element[0].style.borderColor="#FACB34";
           element[0].style.backgroundColor="#FACB34";
             var target = document.getElementsByName('voiceVal' + num);
             target[0].value = val;
          }
          if(val == "neg") {
             element[0].style.borderColor="#BF6000";
           element[0].style.backgroundColor="#BF6000";
             var target = document.getElementsByName('voiceVal' + num);
             target[0].value = val;
          }
          if(val == "emh&nem") {
             element[0].style.borderColor="#ADD192";
             element[0].style.backgroundColor="#ADD192";
           var target = document.getElementsByName('voiceVal' + num);
             target[0].value = val;
          }
          if(val == "emj&neo") {
             element[0].style.borderColor="#A2C3E4";
           element[0].style.backgroundColor="#A2C3E4";
             var target = document.getElementsByName('voiceVal' + num);
             target[0].value = val;
          }
          if(val == "nep") {
             element[0].style.borderColor="#CDCCFD";
           element[0].style.backgroundColor="#CDCCFD";
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
               var element = document.getElementById('emotionFace' + num);
               var target = document.getElementById('emotionVal' + num);
               
               var deleteElement = document.getElementById('emotionFaceSpan' + num);
              deleteElement.parentNode.removeChild(deleteElement);
          
               if(val == "neutral") {
                  var added = document.createElement('span');
              added.setAttribute('id', 'emotionFaceSpan' + num);
                  added.setAttribute('class', 'iconify');
                  added.setAttribute('data-inline', 'false');
                  added.setAttribute('data-icon', 'noto:neutral-face');
                  element.appendChild(added);
                  target.value = val;
                  
               }
               if(val == "happiness") {
                  var added = document.createElement('span');
              added.setAttribute('id', 'emotionFaceSpan' + num);
                  added.setAttribute('class', 'iconify');
                  added.setAttribute('data-inline', 'false');
                  added.setAttribute('data-icon', 'noto:grinning-face-with-smiling-eyes');
                  element.appendChild(added);
                  target.value = val;
               }
               if(val == "anger") {
                  var added = document.createElement('span');
              added.setAttribute('id', 'emotionFaceSpan' + num);
                  added.setAttribute('class', 'iconify');
                  added.setAttribute('data-inline', 'false');
                  added.setAttribute('data-icon', 'noto:angry-face');
                  element.appendChild(added);
                  target.value = val;
            
               }
               if(val == "sadness") {
                  var added = document.createElement('span');
              added.setAttribute('id', 'emotionFaceSpan' + num);
                  added.setAttribute('class', 'iconify');
                  added.setAttribute('data-inline', 'false');
                  added.setAttribute('data-icon', 'noto:crying-face');
                  element.appendChild(added);
                  target.value = val;
               }
            }
         })
}
      
function changeIntensity(val) {
         const checkboxes = document.getElementsByName('settingBox');
         var intVal = parseInt(val);
         checkboxes.forEach((checkbox) => {
            if(checkbox.checked == true) {
               var num = checkbox.value;
               var element = document.getElementById('emotionFaceSpan' + num);
               var target = document.getElementsByName('intensityVal' + num);

               if(val >= 1 && val <= 3) {
                  target[0].value = val * 0.1;
                  element.style.opacity = "20%";
               }
               else if(val >= 4 && val <= 7) {
                  target[0].value = val * 0.1;
              element.style.opacity = "70%";
               }
               else if(val >= 8) {
                  target[0].value = val * 0.1;
              element.style.opacity = "100%";
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