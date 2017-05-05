//
//  UITextField+IndexPath.m
//  YiNuanTong
//
//  Created by 纪高飞 on 17/1/18.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "UITextField+IndexPath.h"
#import <objc/runtime.h>

// 全局字符串
static char indexPathKey;
@implementation UITextField (IndexPath)
// set方法实现
- (void)setIndexPath:(NSIndexPath *)indexPath
{
    objc_setAssociatedObject(self, &indexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
// get方法的实现
- (NSIndexPath *)indexPath
{
    return objc_getAssociatedObject(self, &indexPathKey);

}
@end
