class HeartRate {
	var heartRate;
	var hrZones;
	
	function initialize(hrZones) {
		System.println("Initializing HR with HR Zones: " + hrZones);
		self.hrZones = hrZones;
	}
	
	function updateHeartRate(hr) {
		heartRate = hr;
	}
	
	function getHeartRate() {
		return heartRate;
	}
	
	function getColor() {
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
		return heartRate != null && heartRate < hrZones[1];
	}
	function zone2() {
		return heartRate != null && heartRate >= hrZones[1] && heartRate < hrZones[2];
	}
	function zone3() {
		return heartRate != null && heartRate >= hrZones[2] && heartRate < hrZones[3];
	}
	function zone4() {
		return heartRate != null && heartRate >= hrZones[3] && heartRate < hrZones[4];
	}
	function zone5() {
		return heartRate != null && heartRate >= hrZones[4];
	}
}