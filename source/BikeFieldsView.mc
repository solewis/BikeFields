using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class BikeFieldsView extends Ui.DataField {

	// TODO
	// Make grid drawing more robust (No hard-coding, derive grid rather than magic numbers
    
    hidden var time;
    hidden var hr;
    hidden var power;
    hidden var cadence;
    hidden var speedMetersPerSecond;
    hidden var distanceMeters;
    hidden var elapsedTimeMs;

    function initialize() {
        DataField.initialize();
        power = new Power(225, 3);
        cadence = new Cadence();
        elapsedTimeMs = 0;
        distanceMeters = 0;
        speedMetersPerSecond = 0;
        
        var currentSport = UserProfile.getProfile().getCurrentSport();
        var hrZones = UserProfile.getProfile().getHeartRateZones(currentSport);
        // Initialize hr with threshold taken from Max zone 4
        // May not actually be threshold depending on how zones are configured on device
        hr = new HeartRate(hrZones[4]); 
    }

    // Set your layout here. Anytime the size of obscurity of
    // the draw context is changed this will be called.
    function onLayout(dc) {
        return true;
    }
    
    function drawValues(dc) {
    		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
    		// 2nd row left
    		dc.drawText(40, 90, Graphics.FONT_NUMBER_MEDIUM, displayValue(hr.getHeartRate()), (Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER));
    		
    		// 2nd row middle
    		dc.drawText(120, 90, Graphics.FONT_NUMBER_MEDIUM, displayValue(cadence.getCadence()), (Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER));
    		
    		// 2nd row right
    		dc.drawText(200, 90, Graphics.FONT_NUMBER_MEDIUM, displayValue(power.getPower()), (Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER));
    		
    		// Bottom
    		dc.drawText(120, 210, Graphics.FONT_NUMBER_MILD, displayValue(TimeUtil.elapsedTime(elapsedTimeMs)), (Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER));
    		
    		// Top
    		dc.drawText(120, 23, Graphics.FONT_TINY, displayValue(TimeUtil.currentTime()), (Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER));
    		
    		// 3rd row left
    		dc.drawText(60, 145, Graphics.FONT_NUMBER_MEDIUM, displayValue(DistanceUtil.toMPH(speedMetersPerSecond)), (Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER));
    		
    		// 3rd row right
    		dc.drawText(180, 145, Graphics.FONT_NUMBER_MEDIUM, displayValue(DistanceUtil.toMiles(distanceMeters)), (Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER));
    }
    
    function drawLabels(dc) {
    		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
    		// 2nd row left
    		dc.drawText(50, 50, Graphics.FONT_XTINY, "HR", (Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER));
    		
    		// 2nd row middle
    		dc.drawText(120, 50, Graphics.FONT_XTINY, "CAD", (Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER));
    		
    		// 2nd row right
    		dc.drawText(190, 50, Graphics.FONT_XTINY, "PWR 3s", (Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER));
    
    		// 3rd row left
    		dc.drawText(60, 177, Graphics.FONT_XTINY, "SPEED", (Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER));
    		
    		// 3rd row right
    		dc.drawText(180, 177, Graphics.FONT_XTINY, "DIST", (Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER));
    }
    
    function drawIndicators(dc) {
    		dc.setPenWidth(2);
    		
    		// Left
    		dc.setColor(hr.getColor(), Graphics.COLOR_WHITE);
    		dc.drawRectangle(0, 42, 79, 20);
    		dc.fillRectangle(0, 42, 79, 20);
    		
    		// Middle
    		// dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_WHITE);
    		// dc.drawRectangle(82, 42, 77, 20);
    		// dc.fillRectangle(82, 42, 77, 20);
    		
    		// Right
    		dc.setColor(power.getColor(), Graphics.COLOR_WHITE);
    		dc.drawRectangle(162, 42, 79, 20);
    		dc.fillRectangle(162, 42, 79, 20);
    }
    
    function drawGrid(dc) {
    		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
    		dc.clear();
    		
    		dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_WHITE);
        dc.setPenWidth(2);
        var middleY = dc.getHeight() / 2;
        var middleX = dc.getWidth() / 2;
        dc.drawLine(0, middleY, dc.getWidth(), middleY); // middle horizontal
        dc.drawLine(0, middleY + 70, dc.getWidth(), middleY + 70); // bottom horizontal
        dc.drawLine(0, middleY - 80, dc.getWidth(), middleY - 80);  // top horizontal
        
        // 2nd row verticals
        dc.drawLine(80, middleY, 80, middleY - 80);
        dc.drawLine(160, middleY, 160, middleY - 80);
        
        // 3rd row vertical
        dc.drawLine(middleX, middleY, middleX, middleY + 70);
    }

    // The given info object contains all the current workout information.
    // Calculate a value and save it locally in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no
    // guarantee that compute() will be called before onUpdate().
    function compute(info) {
        hr.updateHeartRate(info.currentHeartRate);
        power.addReading(info.currentPower);
        cadence.updateCadence(info.currentCadence);
        speedMetersPerSecond = info.currentSpeed;
        distanceMeters = info.elapsedDistance;
        elapsedTimeMs = info.elapsedTime;
        
        /*
        hr = Math.rand() % 100;
        power.addReading(Math.rand() % 100);
        cadence = Math.rand() % 100;
        speed = Math.rand() % 10;
        distance = Math.rand() % 1000;
        */
    }

    // Display the value you computed here. This will be called
    // once a second when the data field is visible.
    function onUpdate(dc) {
       drawGrid(dc);
       drawValues(dc);
       drawIndicators(dc);
       drawLabels(dc);
       return true;
    }
    
    function displayValue(value) {
    		return value == null ? "-" : value;
    }

}
