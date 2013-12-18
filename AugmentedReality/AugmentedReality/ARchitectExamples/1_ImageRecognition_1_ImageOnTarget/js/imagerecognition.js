var World = {
	loaded: false,

	init: function initFn() {
		/* Disable all sensors in "IR-only" Worlds to save performance. If the property is set to true, any geo-related components (such as GeoObjects and ActionRanges) are active. If the property is set to false, any geo-related components will not be visible on the screen, and triggers will not fire.*/
		AR.context.services.sensors = false;
		this.createOverlays();
	},

	createOverlays: function createOverlaysFn() {
		// Initialize Tracker
		this.tracker = new AR.Tracker("assets/dhoni.wtc", {
			onLoaded: this.worldLoaded
		});
        

        // Button image
		this.imgButton = new AR.ImageResource("assets/wwwButton.jpg");
        
		// Create overlay for page one
		var imgOne = new AR.ImageResource("assets/wiki1.png");
		var overlayOne = new AR.ImageDrawable(imgOne, 1, {
			offsetX: -0.15,
			offsetY: 0
		});
        
        
        var pageOneButton = this.createWwwButton("http://www.google.com", 0.1, {
                                                 offsetX: -0.25,
                                                 offsetY: -0.25,
                                                 zOrder: 1
                                                 });
        
        
		var pageOne = new AR.Trackable2DObject(this.tracker, "dhoni1", {
			drawables: {
				cam: [overlayOne,pageOneButton]
			}
		});
	},
    
        createWwwButton: function createWwwButtonFn(url, size, options) {
            options.onClick = function() {
                AR.context.openInBrowser(url);
                                        };
            return new AR.ImageDrawable(this.imgButton, size, options);
        },


	worldLoaded: function worldLoadedFn() {
		var cssDivLeft = " style='display: table-cell;vertical-align: middle; text-align: right; width: 50%; padding-right: 15px;'";
		var cssDivRight = " style='display: table-cell;vertical-align: middle; text-align: left;'";
		document.getElementById('loadingMessage').innerHTML =
		"<div" + cssDivLeft + ">Scan Target &#35;1 (neevtech):</div>" +
			"<div" + cssDivRight + "><img src='assets/krishna.jpg'></img></div>";
        
        
        
	}
};

World.init();