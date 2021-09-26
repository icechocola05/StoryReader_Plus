
      
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