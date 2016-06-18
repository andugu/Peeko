/*
	The following code was originally written by iOSCreatix team. This is just an adaptation of their tweak, for non-jailbroken devices.
	The original code is part of Peek-a-Boo, a tweak that they recently open-sourced here: https://github.com/ioscreatix/peekaboo
	All the credits for the methods used to bring 3D Touch to unsupported devices goes to them!
	The necessary modifications made to make this work on a sandbox were made by me (andugu).
	Huge thanks to iOSCreatix to let me use their code!

	Note: Include settings inside every app to modify the way this tweak works are kind of non-sense. So in lines 38-39 of this file
	you can find some variables that you can edit to make it work as you want! Have fun ;)
*/

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface _UITouchForceMessage : NSObject
@property (nonatomic) double timestamp;
@property (nonatomic) float unclampedTouchForce;
- (void)setUnclampedTouchForce:(float)touchForce;
- (float)unclampedTouchForce;
@end

@interface UITouch (Private)
- (void)_setPressure:(float)arg1 resetPrevious:(BOOL)arg2;
- (float)_pathMajorRadius;
- (float)majorRadius;
@end

@interface UIPreviewInteractionController : NSObject
- (BOOL)startInteractivePreviewAtLocation:(id)arg1 inView:(id)arg2;
- (BOOL)startInteractivePreviewWithGestureRecognizer:(id)arg1;
- (void)commitInteractivePreview;
@end

// Some of the following things can be configured if you want, as changing the sensitivity or enabling haptic vibrations.

static int HardPress; // Don't edit
static BOOL isKeyboardShowing; // Don't edit
static float peek = 48.37; // Here you can customize the sensitivity of the tweak, as in jailbroken devices!
static float pop = 60.38; // This are the default values set by iOSCreatix, and they work really fine, in my case I haven't changed them.

%hook UIKeyboardImpl
- (void)showKeyboard {
	%orig;
	isKeyboardShowing = YES;
}
- (void)dismissKeyboard {
	%orig;
	isKeyboardShowing = NO;
}
%end

%hook UITouch
- (void)setMajorRadius:(float)arg1 {

	float lightPress = peek;
	float DeepPress = pop;
	 	if ([self _pathMajorRadius] > DeepPress) {
			
			HardPress = 3;
			
		}
		else if ([self _pathMajorRadius] > lightPress) {
			
			HardPress = 2;
	   	}
		else if ([self _pathMajorRadius] < lightPress) {
			
			HardPress = 1;
			
		}

	%orig;
}
%end

%hook UIScreen
- (long long)_forceTouchCapability {
	return 2;
}
%end

%hook UITraitCollection
- (int)forceTouchCapability {
	return 2;
}

+ (id)traitCollectionWithForceTouchCapability:(int)arg1 {
	return %orig(2);
}
%end

%hook UIDevice
- (BOOL)_supportsForceTouch {
	return TRUE;
}
%end

%hook _UITouchForceMessage
- (void)setUnclampedTouchForce:(CGFloat)touchForce {
	if (HardPress == 3) {
		if (sizeof(void*) == 4) {
	  		%orig((float) 200);
	    }
	    else if (sizeof(void*) == 8) {
	      	%orig((double) 200);
	   	}
	}
	if (HardPress == 2) {
		if (sizeof(void*) == 4) {
	      	%orig((float) 20);
	    } 
	    else if (sizeof(void*) == 8) {
	      	%orig((double) 20);
	    }
	}
	if (HardPress == 1) {
		if (sizeof(void*) == 4) {
	      	%orig((float) 0);
	    } 
	    else if (sizeof(void*) == 8) {
	    	%orig((double) 0);
	    }
	}
}
%end

/* Note: Makes the app crash :/ needs testing
%hook UIPreviewInteractionController
- (BOOL)startInteractivePreviewAtLocation:(id)arg1 inView:(id)arg2 {

	if (HapticPeekOn == YES) {

		AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);

	}
	return %orig;
}

- (BOOL)startInteractivePreviewWithGestureRecognizer:(id)arg1 {

	if (HapticPeekOn == YES) {

		AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);

	}
	return %orig;
}

- (void)commitInteractivePreview {

	%orig;

	if (HapticPopOn == YES) {

		AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);

	}
}
%end
*/

@interface IGFeedItemPreviewingHandler : NSObject
- (id)initWithController:(id)arg1;
@end

@interface IGMainFeedViewController : UIViewController
- (id)registerForPreviewingWithDelegate:(id)arg1 sourceView:(id)arg2;
@end

%hook IGMainFeedViewController
- (id)init {
	%orig;
	[self registerForPreviewingWithDelegate:[[%c(IGFeedItemPreviewingHandler) alloc] initWithController:self] sourceView:self.view];
	return %orig;
}
%new
- (id)feedTestSeven {
	return [[%c(IGFeedItemPreviewingHandler) alloc] initWithController:self];
}
%end