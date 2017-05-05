//
//  GFProgressHUD.h
//  YiNuanTong
//
//  Created by 纪高飞 on 17/2/8.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>
typedef NS_ENUM(NSInteger ,GFProgressHUDStatus)
{
    /** 成功 */
    GFProgressHUDStatusSuccess,
    
    /** 失败 */
    GFProgressHUDStatusError,
    
    /** 提示 */
    GFProgressHUDStatusInfo,
    
    /** 等待 */
    GFProgressHUDStatusWaitting
    
};
@interface GFProgressHUD : MBProgressHUD


/** 返回一个 HUD 的单例 */
+ (instancetype)sharedHUD;

/** 在 window 上添加一个 HUD */
+ (void)showStatus:(GFProgressHUDStatus)status text:(NSString *)text;

#pragma mark - 建议使用的方法

/** 在 window 上添加一个只显示文字的 HUD */
+ (void)showMessage:(NSString *)text;

/** 在 window 上添加一个提示`信息`的 HUD */
+ (void)showInfoMsg:(NSString *)text;

/** 在 window 上添加一个提示`失败`的 HUD */
+ (void)showFailure:(NSString *)text;

/** 在 window 上添加一个提示`成功`的 HUD */
+ (void)showSuccess:(NSString *)text;

/** 在 window 上添加一个提示`等待`的 HUD, 需要手动关闭 */
+ (void)showLoading:(NSString *)text;

/** 手动隐藏 HUD */
+ (void)hide;


@end
