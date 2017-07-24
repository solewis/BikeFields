class Cadence {
	var cadence;
	
	function updateCadence(newCadence) {
		cadence = newCadence;
	}
	
	function getCadence() {
		return cadence == null ? "-" : cadence / 2;
	}
	
	function getColor() {
		if (cadence == null) {
			return Graphics.COLOR_LT_GRAY;
		}
		if (cadence > 170) {
			return Graphics.COLOR_BLUE;
		}
		if (cadence > 150) {
			return Graphics.COLOR_GREEN;
		}
		if (cadence > 0) {
			return Graphics.COLOR_RED;
		}
		return Graphics.COLOR_TRANSPARENT;
	}
}