class Power {
	var powerReadings;
	var thresholdPower;
	var connectivity; // Tracks whether we are receiving valid readings from power meter
	
	function initialize(thresholdPower, powerLength) {
		// TODO change to just use garmin zones if they make that available
		System.println("Initializing Power with threshold power: " + thresholdPower);
		self.powerReadings = new [powerLength];
		self.thresholdPower = thresholdPower;
		self.connectivity = true;
		zeroOutReadings();
		
	}
	
	function addReading(power) {
		if (power == null) {
			connectivity = false;
			zeroOutReadings();
			return;
		} else {
			connectivity = true;
		}
		
		for(var i = powerReadings.size() - 1; i > 0; i--) {
			powerReadings[i] = powerReadings[i-1];
		}
		powerReadings[0] = power == null ? 0 : power;
	}
	
	function getPower() {
		if (!connectivity) {
			return null;
		}
		var power = 0;
		for (var i = 0; i < powerReadings.size(); i++) {
			power += powerReadings[i];
		}
		return power / powerReadings.size();
	}
	
	function getColor() {
		var power = getPower();
		// Using coggan power zones
		if (power == null or zone1(power)) {
			return Graphics.COLOR_LT_GRAY;
		}
		if (zone2(power)) {
			return Graphics.COLOR_BLUE;
		}
		if (zone3(power)) {
			return Graphics.COLOR_GREEN;
		}
		if (zone4(power)) {
			return Graphics.COLOR_ORANGE;
		}
		if (zone5(power)) {
			return Graphics.COLOR_RED;
		}
		if (zone6(power)) {
			return Graphics.COLOR_DK_RED;
		}
		return Graphics.COLOR_LT_GRAY;
	}
	
	function zone1(power) {
		return power != null && power < (.55 * thresholdPower);
	}
	
	function zone2(power) {
		return power != null && power >= (.55 * thresholdPower) && power < (.75 * thresholdPower);
	}
	
	function zone3(power) {
		return power != null && power >= (.75 * thresholdPower) && power < (.9 * thresholdPower);
	}
	
	function zone4(power) {
		return power != null && power >= (.9 * thresholdPower) && power < (1.05 * thresholdPower);
	}
	
	function zone5(power) {
		return power != null && power > (1.05 * thresholdPower) && power <= (1.2 * thresholdPower);
	}
	
	function zone6(power) {
		return power != null && power > (1.2 * thresholdPower);
	}
	
	function zeroOutReadings() {
		for (var i = 0; i < powerReadings.size(); i++) {
			powerReadings[i] = 0;
		}
	}
}