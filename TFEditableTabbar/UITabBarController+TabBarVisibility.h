//
//  UITabBarController+TabBarVisibility.h
//  RouteMonitor
//
//  Created by Tom Fewster on 07/12/2012.
//
//

#import <UIKit/UIKit.h>

@interface UITabBarController (TabBarVisibility)

- (void)hideTabBarAnimated:(BOOL)animated;
- (void)showTabBarAnimated:(BOOL)animated;

@end
