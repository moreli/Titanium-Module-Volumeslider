/**
 * Created by Eli Mor on 7/15/11.
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */

#import "TiVolumesliderViewProxy.h"

NSArray* sliderKeySequence;

@implementation TiVolumesliderViewProxy

-(NSArray *)keySequence
{
	if (sliderKeySequence == nil)
	{
		sliderKeySequence = [[NSArray arrayWithObjects:@"value",nil] retain];
	}
	return sliderKeySequence;
}

-(UIViewAutoresizing)verifyAutoresizing:(UIViewAutoresizing)suggestedResizing
{
	return suggestedResizing & ~UIViewAutoresizingFlexibleHeight;
}

USE_VIEW_FOR_VERIFY_HEIGHT

@end
