//
//  YNTDefine.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/12.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Masonry/Masonry.h>
#import "UserInfo.h"
#import "GFProgressHUD.h"
// 宏定义当前屏幕的宽度
#define KScreenW [UIScreen mainScreen].bounds.size.width
// 宏定义当前屏幕的高度
#define kScreenH [UIScreen mainScreen].bounds.size.height
// 屏幕宽的比例
#define kWidthScale [UIScreen mainScreen].bounds.size.width / 375
// 屏幕高的比例
#define kHeightScale [UIScreen mainScreen].bounds.size.height / 667
// 基地址
#define baseUrl @"http://app.1nuantong.com/"
// kPlus 为3倍的转化率
#define kPlus 1 / 2
//全局蓝色
#define CGRBlue    [UIColor colorWithRed:52/255.0 green:162/255.0f blue:252/255.0f alpha:1]
// 全局灰
#define CGRGray    [UIColor colorWithRed:177/255.0f green:177/255.0f blue:177/255.0f alpha:1]

// 全局灰
#define CGRRed    [UIColor colorWithRed:220/255.0f green:62/255.0f blue:67/255.0f alpha:1]
/** 16进制转RGB*/
#define HEX_COLOR(x_RGB) [UIColor colorWithRed:((float)((x_RGB & 0xFF0000) >> 16))/255.0 green:((float)((x_RGB & 0xFF00) >> 8))/255.0 blue:((float)(x_RGB & 0xFF))/255.0 alpha:1.0f]

#define RGBA(r,g,b,a)           [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)

#else
#define NSLog(...)
#endif
