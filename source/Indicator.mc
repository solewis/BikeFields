using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class Indicator extends Ui.Drawable {
	
	static var leftColor = Gfx.COLOR_LT_GRAY;
	static var rightColor = Gfx.COLOR_LT_GRAY;
	
	var x, y, width, height, position;
	
	function initialize(params) {
        Drawable.initialize(params);

		position = params[:position];
        x = params[:x];
        y = params[:y];
        width = params[:width];
        height = params[:height];
    }
	
    function draw(dc) {
        dc.setPenWidth(2);
		
		var color = "left".equals(position) ? leftColor : rightColor;
		dc.setColor(color, Gfx.COLOR_WHITE);
		dc.drawRectangle(x, y, width, height);
		dc.fillRectangle(x, y, width, height);
    }
}