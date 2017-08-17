using Toybox.System;

module TimeUtil {

	function currentTime() {
		var isMilitaryTime = System.getDeviceSettings().is24Hour;
		
		var clockTime = System.getClockTime();
		if (isMilitaryTime) {
			return clockTime.hour + ":" + clockTime.min.format("%02d");
		} else {
			var period = clockTime.hour > 12 ? "PM" : "AM";
			var hours = clockTime.hour > 12 ? clockTime.hour - 12 : clockTime.hour;
			return hours + ":" + clockTime.min.format("%02d") + " " + period;
		}
	}
	
	function elapsedTime(ms) {
		if (ms == null) {
			return null;
		}
		var seconds = (ms / 1000) % 60;
		var minutes = ((ms / (1000*60)) % 60);
		var hours = (ms / (1000*60*60)) % 24;
		var hoursParsed = hours > 0 ? hours + ":" : "";
		var minutesFormatted = hours > 0 ? minutes.format("%02d") : minutes;
		return hoursParsed + minutes + ":" + seconds.format("%02d");
	}
}