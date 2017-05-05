//
//  HomeGoodListSingLeton.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/5/4.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "HomeGoodListSingLeton.h"

@implementation HomeGoodListSingLeton
/**创建单例类*/
+ (HomeGoodListSingLeton *)shareHomeGoodListSingLeton
{
    static HomeGoodListSingLeton *singLeton = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        singLeton = [[HomeGoodListSingLeton alloc]init];
    });
    return singLeton;
}
@end
