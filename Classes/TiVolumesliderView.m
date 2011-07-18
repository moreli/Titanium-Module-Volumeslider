/**
 * Created by Eli Mor on 7/15/11.
 * Based on http://www.ludoviclecerf.com/blog/2011/05/20/appcelerator-make-volume-slider-audioplayer
 * By Ludovic LECERF
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */

#import "TiVolumesliderView.h"
#import "TiVolumesliderViewProxy.h"
#import "TiUtils.h"

@implementation TiVolumesliderView

-(void)dealloc
{
    [volumeViewSlider removeTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
	RELEASE_TO_NIL(sliderView);
	RELEASE_TO_NIL(lastTouchUp);
	[super dealloc];
}

-(MPVolumeView*)sliderView
{
	if (sliderView==nil)
	{
		sliderView = [[MPVolumeView alloc] initWithFrame:[self bounds]];
		[sliderView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [self addSubview:sliderView];
        
		for (UIView *view in [sliderView subviews]) {
			if ([[[view class] description] isEqualToString:@"MPVolumeSlider"]) {
				volumeViewSlider = (UISlider *) view;
			}
		}
        
        [volumeViewSlider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
		lastTouchUp = [[NSDate alloc] init];
		lastTimeInterval = 1.0; // Short-circuit so that we don't ignore the first fire
	}
	return sliderView;
}

-(BOOL)hasTouchableListener
{
	// since this guy only works with touch events, we always want them
	// just always return YES no matter what listeners we have registered
	return YES;
}

-(void)setThumb:(id)value forState:(UIControlState)state
{
	[volumeViewSlider setThumbImage:[TiUtils image:value proxy:[self proxy]] forState:state];
}

-(void)setRightTrack:(id)value forState:(UIControlState)state
{
	[volumeViewSlider setMaximumTrackImage:[TiUtils stretchableImage:value proxy:[self proxy]] forState:state];
}

-(void)setLeftTrack:(id)value forState:(UIControlState)state
{
	[volumeViewSlider setMinimumTrackImage:[TiUtils stretchableImage:value proxy:[self proxy]] forState:state];
}

#pragma mark View controller stuff

-(void)setThumbImage_:(id)value
{
	[self setThumb:value forState:UIControlStateNormal];
}

-(void)setSelectedThumbImage_:(id)value
{
	[self setThumb:value forState:UIControlStateSelected];
}

-(void)setHighlightedThumbImage_:(id)value
{
	[self setThumb:value forState:UIControlStateHighlighted];
}

-(void)setDisabledThumbImage_:(id)value
{
	[self setThumb:value forState:UIControlStateDisabled];
}

-(void)setLeftTrackImage_:(id)value
{
	[self setLeftTrack:value forState:UIControlStateNormal];
}

-(void)setSelectedLeftTrackImage_:(id)value
{
	[self setLeftTrack:value forState:UIControlStateSelected];
}

-(void)setHighlightedLeftTrackImage_:(id)value
{
	[self setLeftTrack:value forState:UIControlStateHighlighted];
}

-(void)setDisabledLeftTrackImage_:(id)value
{
	[self setLeftTrack:value forState:UIControlStateDisabled];
}

-(void)setRightTrackImage_:(id)value
{
	[self setRightTrack:value forState:UIControlStateNormal];
}

-(void)setSelectedRightTrackImage_:(id)value
{
	[self setRightTrack:value forState:UIControlStateSelected];
}

-(void)setHighlightedRightTrackImage_:(id)value
{
	[self setRightTrack:value forState:UIControlStateHighlighted];
}

-(void)setDisabledRightTrackImage_:(id)value
{
	[self setRightTrack:value forState:UIControlStateDisabled];
}

-(void)setValue_:(id)value withObject:(id)properties
{   
    CGFloat newValue = [TiUtils floatValue:value];

    if (newValue > 1) 
    {
        newValue = 1;
    }
    else if (newValue < 0)
    {
        newValue = 0;
    }
	
	BOOL animated = [TiUtils boolValue:@"animated" properties:properties def:NO];
	UISlider * ourSlider = volumeViewSlider;
	[ourSlider setValue:newValue animated:animated];
    [[MPMusicPlayerController applicationMusicPlayer] setVolume:newValue];
	[self sliderChanged:ourSlider];
}

-(void)setValue_:(id)value
{
	[self setValue_:value withObject:nil];
}

-(void)setEnabled_:(id)value
{
	[volumeViewSlider setEnabled:[TiUtils boolValue:value]];
}

-(CGFloat)verifyHeight:(CGFloat)suggestedHeight
{
	CGSize fitSize = [[self sliderView] sizeThatFits:CGSizeZero];
	return fitSize.height;
}

USE_PROXY_FOR_VERIFY_AUTORESIZING

#pragma mark Delegates 

- (IBAction)sliderChanged:(id)sender
{
    NSNumber * newValue = [NSNumber numberWithFloat:[(UISlider *)sender value]];
    [self.proxy replaceValue:newValue forKey:@"value" notification:NO];
     
    if ([self.proxy _hasListeners:@"change"])
    {
        [self.proxy fireEvent:@"change" withObject:[NSDictionary dictionaryWithObject:newValue forKey:@"value"]];
    }
}

@end