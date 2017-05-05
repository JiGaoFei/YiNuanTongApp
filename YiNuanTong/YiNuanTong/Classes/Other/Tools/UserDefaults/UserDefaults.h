//
//  UserDefaults.h
//  YiNuanTong
//
//  Created by 纪高飞 on 17/1/5.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaults : NSObject

/**初始化存储类*/
+ (void)initDefaults;
/**存取当前应用的启动次数*/
+ (void)setLaunchTimes:(NSString *)launchtimes;
/** 获取当前的应用的启动次数*/
+ (NSString *)getLaunchTimes;
@end
