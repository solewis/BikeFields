module DistanceUtil {
	
	function toMiles(meters) {
		return (meters / 1609.344).format("%.2f");
	}
	
	function toMPH(metersPerSecond) {
		return (metersPerSecond * 2.2369).format("%.1f");
	}
}