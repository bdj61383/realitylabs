var Timer;
var TotalSeconds;
var timeOuts = new Array();

function CreateTimer(TimerID, Time) {
    // first thing to do is to clear the array of past setTimeout events.
    function clearTimeouts(){  
        for( key in timeOuts ){  
          clearTimeout(timeOuts[key]);  
        }  
      } 
      //debugger

    // Here is an alternate method to clear the timeOuts array
    for(var i=0; i<timeOuts.length; i++) clearTimeout(timeOuts[i]);
    timeOuts = []; //quick reset of the timer array you just cleared

    Timer = document.getElementById(TimerID);
    TotalSeconds = Time;
        
    UpdateTimer()
    // window.setTimeout("Tick()", 1000);
    timeOuts.push(setTimeout("Tick()", 1000));
    }

function Tick() {
    if (TotalSeconds <= 0) {
            return;
    }

        TotalSeconds -= 1;
        UpdateTimer()
        // window.setTimeout("Tick()", 1000);
        timeOuts.push(setTimeout("Tick()", 1000));
    }

function UpdateTimer() {
    var Seconds = TotalSeconds;
        
    var Days = Math.floor(Seconds / 86400);
    Seconds -= Days * 86400;

    var Hours = Math.floor(Seconds / 3600);
    Seconds -= Hours * (3600);

    var Minutes = Math.floor(Seconds / 60);
    Seconds -= Minutes * (60);


    var TimeStr = Minutes + ":" + LeadingZero(Seconds)
    

    Timer.innerHTML = TimeStr;
    }

function LeadingZero(Time) {
    return (Time < 10) ? "0" + Time : + Time;

    }

