/**
 * Created by Eli Mor on 7/15/11.
 * Based on http://www.ludoviclecerf.com/blog/2011/05/20/appcelerator-make-volume-slider-audioplayer
 * By Ludovic LECERF
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */

#import "TiUIView.h"
#import <MediaPlayer/MediaPlayer.h>

@interface TiVolumesliderView : TiUIView<LayoutAutosizing> {
@private
	MPVolumeView *sliderView;
	UISlider *volumeViewSlider;
	NSDate* lastTouchUp;
	NSTimeInterval lastTimeInterval;
}

- (IBAction)sliderChanged:(id)sender;

@end