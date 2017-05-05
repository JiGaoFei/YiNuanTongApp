//
//  SingLeton.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/16.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "SingLeton.h"

@implementation SingLeton
// 创建单例类
+ (SingLeton *)shareSingLetonHelper
{
    static SingLeton *singLeton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singLeton = [[SingLeton alloc]init];
    });
    return singLeton;
}

@end
