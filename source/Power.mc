class Power {
	var powerReadings = new [3];
	var thresholdPower;
	
	function initialize(thresholdPower) {
		// TODO change to just use garmin zones if they make that available
		System.println("Initializing Power with threshold power: " + thresholdPower);
		self.thresholdPower = thresholdPower;
		for (var i = 0; i < powerReadings.size(); i++) {
			powerReadings[i] = 0;
		}
	}
	
	function addReading(power) {
		for(var i = powerReadings.size() - 1; i > 0; i--) {
			powerReadings[i] = powerReadings[i-1];
		}
		powerReadings[0] = power == null ? 0 : power;
	}
	
	function power3s() {
		var power3s = 0;
		for (var i = 0; i < powerReadings.size(); i++) {
			power3s += powerReadings[i];
		}
		return power3s / 3;
	}
	
	function getColor() {
		// TODO support other zone calculation methods
		power3s = power3s();
		// Using friel HR zones for cycling
		if (power3s == null or zone1(power3s)) {
			return Graphics.COLOR_LT_GRAY;
		}
		if (zone2(power3s)) {
			return Graphics.COLOR_BLUE;
		}
		if (zone3(power3s)) {
			return Graphics.COLOR_GREEN;
		}
		if (zone4(power3s)) {
			return Graphics.COLOR_ORANGE;
		}
		if (zone5(power3s)) {
			return Graphics.COLOR_RED;
		}
		if (zone6(power3s)) {
			return Graphics.COLOR_DK_RED;
		}
		return Graphics.COLOR_LT_GRAY;
	}
	
	function zone1(power3s) {
		return power3s != null && power3s < (.81 * thresholdPower);
	}
	function zone2(power3s) {
		return power3s != null && power3s >= (.81 * thresholdPower) && power3s <= (.89 * thresholdPower);
	}
	function zone3(power3s) {
		return power3s != null && power3s >= (.9 * thresholdPower) && power3s <= (.93 * thresholdPower);
	}
	function zone4(power3s) {
		return power3s != null && power3s >= (.94 * thresholdPower) && power3s <= (.99 * thresholdPower);
	}
	function zone5(power3s) {
		return power3s != null && power3s >= (1 * thresholdPower);
	}
	function zone6(power3s) {
		return power3s != null && power3s >= (1 * thresholdPower);
	}
}