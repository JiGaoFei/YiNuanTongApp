//
//  UITabBar+Badge.m
//  
//
//  Created by 于露露 on 2016/11/8.
//
//

#import "UITabBar+Badge.h"
#import <UIKit/UIKit.h>
#import "UIView+CirExtention.h"
@implementation UITabBar (Badge)
#define TabbarItemNums 3   //tabbar的数量
- (void)showBadgeOnItemIndex:(int)index{
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 5;
    badgeView.backgroundColor = [UIColor redColor];
    CGRect tabFrame = self.frame;
    //确定小红点的位置
    float percentX = (index + 0.6) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 10, 10);
    
    [self addSubview:badgeView];
}

- (void)hideBadgeOnItemIndex:(int)index{
    //移除小红点
    [self removeBadgeOnItemIndex:index];
}

- (void)removeBadgeOnItemIndex:(int)index{
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}

- (void)setBadgeValue:(NSInteger)value AtIndex:(NSInteger)index {
    if (index<0||index>=TabbarItemNums) {
        return;
    }
    [self hideBadgeValueAtIndex:index];
    CGRect tabFrame = self.frame;
    float percentX = (index + 0.55) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    
    UILabel *badgeLabel = [UILabel new];
    badgeLabel.frame = CGRectMake(x, y, 15, 15);
    badgeLabel.backgroundColor = [UIColor redColor];
    badgeLabel.tag = 999+index;
    badgeLabel.textColor = [UIColor whiteColor];

    badgeLabel.textAlignment = NSTextAlignmentCenter;
    badgeLabel.layer.cornerRadius = badgeLabel.height/2.0;
    [self addSubview:badgeLabel];
    value = value>99 ? 99 : value;
    badgeLabel.text = [NSString stringWithFormat:@"%zd",value];
    if (value <= 0) {
        badgeLabel.hidden = YES;
    }
}

- (void)hideBadgeValueAtIndex:(NSInteger)index {
    for (UIView *subView in self.subviews) {
        if (subView.tag == 999+index) {
            
            [subView removeFromSuperview];
        
        }
    }
}

@end
