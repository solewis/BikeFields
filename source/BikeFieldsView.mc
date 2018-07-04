using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;

class BikeFieldsView extends Ui.DataField {

	// TODO: support metric
	
    hidden var hr;
    hidden var power;
    hidden var cadence;
    hidden var speedMetersPerSecond;
    hidden var distanceMeters;
    hidden var elapsedTimeMs;

    function initialize() {
        DataField.initialize();
        power = new Power(App.getApp().getProperty("FunctionalThresholdPower"), 3);
        var currentSport = UserProfile.getProfile().getCurrentSport();
        hr = new HeartRate(UserProfile.getProfile().getHeartRateZones(currentSport)); 
        cadence = 0;
        elapsedTimeMs = 0;
        distanceMeters = 0;
        speedMetersPerSecond = 0;
    }

    // Set your layout here. Anytime the size of obscurity of
    // the draw context is changed this will be called.
    function onLayout(dc) {
    	setLayout(Rez.Layouts.MainLayout(dc));
        return true;
    }

    // The given info object contains all the current workout information.
    // Calculate a value and save it locally in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no
    // guarantee that compute() will be called before onUpdate().
    function compute(info) {
        hr.updateHeartRate(info.currentHeartRate);
        power.addReading(info.currentPower);
        cadence = info.currentCadence;
        speedMetersPerSecond = info.currentSpeed;
        distanceMeters = info.elapsedDistance;
        elapsedTimeMs = info.elapsedTime;
    }

    // Display the value you computed here. This will be called
    // once a second when the data field is visible.
    function onUpdate(dc) {
    	Indicator.leftColor = hr.getColor();
    	Indicator.rightColor = power.getColor();
    	
    	View.findDrawableById("HeaderValue").setText(displayValue(TimeUtil.currentTime()));
    	View.findDrawableById("FooterValue").setText(displayValue(TimeUtil.elapsedTime(elapsedTimeMs)));
    	View.findDrawableById("TopLeftValue").setText(displayValue(hr.getHeartRate()));
    	View.findDrawableById("TopMidValue").setText(displayValue(cadence));
    	View.findDrawableById("TopRightValue").setText(displayValue(power.getPower()));
    	View.findDrawableById("BottomLeftValue").setText(displayValue(DistanceUtil.toMPH(speedMetersPerSecond)));
    	View.findDrawableById("BottomRightValue").setText(displayValue(DistanceUtil.toMiles(distanceMeters)));
    	View.onUpdate(dc);
	    return true;
    }
    
    function displayValue(value) {
    	return value == null ? "-" : value.toString();
    }

}
