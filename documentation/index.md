# volumeslider Module

## Description

This module provides a volume slider based on the post from Ludovic LECERF
http://www.ludoviclecerf.com/blog/2011/05/20/appcelerator-make-volume-slider-audioplayer

## Accessing the volumeslider Module

To access this module from JavaScript, you would do the following:

	var volumeslider = require("ti.volumeslider");

The volumeslider variable is a reference to the Module object.	

## Reference

Use the Ti.UI.Slider API as a reference.
The min / max properties have been removed.
The Volume value should be between 0 and 1.

## Usage
var VolumeSlider = require('ti.volumeslider');

var volumeSlider = VolumeSlider.createView({
	width: '90%',
	value: 0.5 // value should be between 0 to 1
});


## Author

Eli Mor
eli_mor.geo at yahoo.com

## License

Open Source
