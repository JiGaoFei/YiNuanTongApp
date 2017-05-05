//
//  UITabBar+Badge.h
//  
//
//  Created by 于露露 on 2016/11/8.
//
//

#import <UIKit/UIKit.h>

@interface UITabBar (Badge)
- (void)showBadgeOnItemIndex:(int)index;    //显示小红点

- (void)hideBadgeOnItemIndex:(int)index;    //隐藏小红点

- (void)setBadgeValue:(NSInteger)value AtIndex:(NSInteger)index;

- (void)hideBadgeValueAtIndex:(NSInteger)index;

@end
