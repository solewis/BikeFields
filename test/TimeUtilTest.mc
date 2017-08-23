module TimeUtilTest {

	(:test)
	function testElapsedTimeHandlesNull(logger) {
		return TimeUtil.elapsedTime(null) == null;
	}
	
	(:test)
	function testElapsedTimeFormatsOneSecond(logger) {
		return testElapsedTime("0:01", TimeUtil.elapsedTime(1000), logger);
	}
	
	(:test)
	function testElapsedTimeFormatsZeroSeconds(logger) {
		return testElapsedTime("0:00", TimeUtil.elapsedTime(0), logger);
	}
	
	(:test)
	function testElapsedTimeFormatsOneMinute(logger) {
		return testElapsedTime("1:00", TimeUtil.elapsedTime(60000), logger);
	}
	
	(:test)
	function testElapsedTimeFormatsOneMinuteAndOneSecond(logger) {
		return testElapsedTime("1:01", TimeUtil.elapsedTime(61000), logger);
	}
	
	(:test)
	function testElapsedTimeFormatsOneHour(logger) {
		return testElapsedTime("1:00:00", TimeUtil.elapsedTime(3600000), logger);
	}
	
	(:test)
	function testElapsedTimeFormatsOneHourAndOneMinuteAndOneSecond(logger) {
		return testElapsedTime("1:01:01", TimeUtil.elapsedTime(3661000), logger);
	}
	
	function testElapsedTime(expected, actual, logger) {
		if (!expected.equals(actual)) {
			logger.error("Testing elapsed time. Expected " + expected + " but got " + actual);
			return false;
		}
		return true;
	}
}