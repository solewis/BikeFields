class HeartRate {
	var heartRate;
	var thresholdHeartRate;
	
	function initialize(thresholdHr) {
		System.println("Initializing HR with threshold HR: " + thresholdHr);
		thresholdHeartRate = thresholdHr;
	}
	
	function updateHeartRate(hr) {
		heartRate = hr;
	}
	
	function getHeartRate() {
		return heartRate;
	}
	
	function getColor() {
		// TODO change to use garmin zones
		
		// Using friel HR zones for cycling
		if (heartRate == null or zone1()) {
			return Graphics.COLOR_LT_GRAY;
		}
		if (zone2()) {
			return Graphics.COLOR_BLUE;
		}
		if (zone3()) {
			return Graphics.COLOR_GREEN;
		}
		if (zone4()) {
			return Graphics.COLOR_ORANGE;
		}
		if (zone5()) {
			return Graphics.COLOR_RED;
		}
		return Graphics.COLOR_LT_GRAY;
	}
	
	function zone1() {
		return heartRate != null && heartRate < (.81 * thresholdHeartRate);
	}
	function zone2() {
		return heartRate != null && heartRate >= (.81 * thresholdHeartRate) && heartRate <= (.89 * thresholdHeartRate);
	}
	function zone3() {
		return heartRate != null && heartRate >= (.9 * thresholdHeartRate) && heartRate <= (.93 * thresholdHeartRate);
	}
	function zone4() {
		return heartRate != null && heartRate >= (.94 * thresholdHeartRate) && heartRate <= (.99 * thresholdHeartRate);
	}
	function zone5() {
		return heartRate != null && heartRate >= (1 * thresholdHeartRate);
	}
}