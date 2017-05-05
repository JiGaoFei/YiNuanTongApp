//
//  UIView+ViewController.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/3/9.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "UIView+ViewController.h"

@implementation UIView (ViewController)
- (UIViewController *) firstViewController {
    UIResponder *next = self.nextResponder;
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
    } while (next != nil);
    
    return nil;
}

@end
