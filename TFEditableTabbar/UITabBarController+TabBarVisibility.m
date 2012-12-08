//
//  UITabBarController+TabBarVisibility.m
//  RouteMonitor
//
//  Created by Tom Fewster on 07/12/2012.
//
//

#import "UITabBarController+TabBarVisibility.h"

@implementation UITabBarController (TabBarVisibility)

- (void)hideTabBarAnimated:(BOOL)animated {
	CGRect screenRect = [[UIScreen mainScreen] bounds];

	float fHeight = screenRect.size.height;
	if (UIDeviceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
		fHeight = screenRect.size.width;
	}

	void(^block)(void) = ^(){
		for (UIView *view in self.view.subviews) {
			if (view == self.tabBar) {
				[view setFrame:CGRectMake(view.frame.origin.x, fHeight, view.frame.size.width, view.frame.size.height)];
			} else {
				[view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, fHeight)];
				view.backgroundColor = [UIColor blackColor];
			}
		}
	};

	if (animated) {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3];
		block();
		[UIView commitAnimations];
	} else {
		block();
	}
}

- (void)showTabBarAnimated:(BOOL)animated {
	CGRect screenRect = [[UIScreen mainScreen] bounds];
	float fHeight = screenRect.size.height - 49.0;

	if(  UIDeviceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ) {
		fHeight = screenRect.size.width - 49.0;
	}

	void(^block)(void) = ^(){
		for (UIView *view in self.view.subviews) {
			if (view == self.tabBar) {
				[view setFrame:CGRectMake(view.frame.origin.x, fHeight, view.frame.size.width, view.frame.size.height)];
			} else {
				[view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, fHeight)];
			}
		}
	};

	if (animated) {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.3];
		block();
		[UIView commitAnimations];
	} else {
		block();
	}
}
@end
