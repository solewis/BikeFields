module DistanceUtil {
	
	function toMiles(meters) {
		return meters == null ? null : (meters / 1609.344).format("%.2f");
	}
	
	function toMPH(metersPerSecond) {
		return metersPerSecond == null ? null : (metersPerSecond * 2.2369).format("%.1f");
	}
}