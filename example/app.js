// this sets the background color of the master UIView (when there are no windows/tab groups on it)
Titanium.UI.setBackgroundColor('#000');

var VolumeSlider = require('ti.volumeslider');
Titanium.API.info("module is => "+VolumeSlider);

var volumeSlider = VolumeSlider.createView({
	width: '90%',
	//min: 0,
	//max: 1,
	//value: 0.2,
	height: 'auto',
	color: '#000',
	bottom: 10,
});

Titanium.API.info("volume is => "+volumeSlider.volume);

// create tab group
var tabGroup = Titanium.UI.createTabGroup();

var playButton = Titanium.UI.createButton({
	title: 'Start',
	width: 135,
	height: 35,
	top: 50
});

var stopButton = Titanium.UI.createButton({
	title: 'Stop',
	width: 135,
	height: 35,
	top: 100
});

var downButton = Titanium.UI.createButton({
	title: '-',
	width: 35,
	height: 35,
	top: 200,
	left: 50
});

var upButton = Titanium.UI.createButton({
	title: '+',
	width: 35,
	height: 35,
	top: 200,
	right: 50,
});

var urlTextField = Titanium.UI.createTextField({
	value: 'http://www.archive.org/download/three_bears_librivox/three_bears_denslow_64kb.mp3',
	color:'#336699',
	height:35,
	top:10,
	left:10,
	width:'95%',
	borderStyle:Titanium.UI.INPUT_BORDERSTYLE_ROUNDED
});

playButton.addEventListener('click', function() {
	Titanium.API.info('play clicked');
	msgLabel.text = volumeSlider.value;
	sound.start();
});
stopButton.addEventListener('click', function() {
	Titanium.API.info('stop clicked');
	sound.stop();
});
downButton.addEventListener('click', function() {
	Titanium.API.info('down clicked');
	volumeSlider.value-=0.1;
	msgLabel.text = volumeSlider.value;
});
upButton.addEventListener('click', function() {
	Titanium.API.info('up clicked');
	volumeSlider.value+=0.1;
	msgLabel.text = volumeSlider.value;
});
var msgLabel = Titanium.UI.createLabel({
	color:'#999',
	text:'msgLabel',
	font: {
		fontSize:20,
		fontFamily:'Helvetica Neue'
	},
	textAlign:'center',
	bottom: 10,
	width:'auto'
});

var eventListenerLabel = Titanium.UI.createLabel({
	color:'#999',
	text:'eventListenerLabel',
	font: {
		fontSize:20,
		fontFamily:'Helvetica Neue'
	},
	textAlign:'center',
	bottom: 50,
	width:'auto'
});

volumeSlider.addEventListener('change', function() {
	eventListenerLabel('volume changed');
});
//
// create base UI tab and root window
//
var sound = Titanium.Media.createAudioPlayer({
	url: urlTextField.value
});

var win = Titanium.UI.createWindow({
	title:'MP Volume Module',
	backgroundColor:'#fff'
});
var tab1 = Titanium.UI.createTab({
	icon: Titanium.UI.iPhone.SystemIcon.TOP_RATED,
	title:'Tab 1',
	window:win
});

win.add(urlTextField);
win.add(playButton);
win.add(stopButton);
win.add(downButton);
win.add(upButton);
win.add(volumeSlider);
win.add(msgLabel);
win.add(eventListenerLabel);
volumeSlider.show();

//
//  add tabs
//
tabGroup.addTab(tab1);

// open tab group
tabGroup.open();