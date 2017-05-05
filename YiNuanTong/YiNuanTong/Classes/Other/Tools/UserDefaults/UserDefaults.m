//
//  UserDefaults.m
//  YiNuanTong
//
//  Created by 纪高飞 on 17/1/5.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "UserDefaults.h"
/**存储次数*/
#define kLaunch_Time @"launch_times"
@implementation UserDefaults
// 初始化存储类
+ (void)initDefaults
{
  

    // 设置当第一次启动应用时,取到的默认值为 1
    if ([UserDefaults getLaunchTimes] == nil) {
        // 注册避免使用setValue forkey
        NSDictionary *dict = [NSDictionary dictionaryWithObject:@"1" forKey:kLaunch_Time];
        [[NSUserDefaults standardUserDefaults]registerDefaults:dict];
    }
    
    
}

// 设置应用的启动次数
+ (void)setLaunchTimes:(NSString *)launchtimes
{
    [[NSUserDefaults standardUserDefaults]setValue:launchtimes forKey:kLaunch_Time];
}

// 获取应用的启动次数

+ (NSString *)getLaunchTimes
{
    return [[NSUserDefaults standardUserDefaults]valueForKey:kLaunch_Time];
}

@end
