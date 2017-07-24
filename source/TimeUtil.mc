using Toybox.System;

module TimeUtil {

	function currentTime() {
		// TODO: Make 24/12 adjustable based on system setting
		
		var clockTime = System.getClockTime();
		var period = clockTime.hour > 12 ? "PM" : "AM";
		var hours = clockTime.hour > 12 ? clockTime.hour - 12 : clockTime.hour;
		return hours + ":" + clockTime.min.format("%02d") + " " + period;
	}
	
	function elapsedTime(ms) {
		var seconds = (ms / 1000) % 60;
		var minutes = ((ms / (1000*60)) % 60);
		var hours = (ms / (1000*60*60)) % 24;
		var hoursParsed = hours > 0 ? hours + ":" : "";
		return hours + minutes + ":" + seconds.format("%02d");
	}
}