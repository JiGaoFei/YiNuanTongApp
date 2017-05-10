//
//  AppDelegate.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/12.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "AppDelegate.h"
#import "YNTTabBarViewController.h"
#import "LaunchViewController.h"
#import "GuideViewController.h"
#import "UserDefaults.h"
#import "SingLeton.h"
#import "UserInfo.h"
#import <AlipaySDK/AlipaySDK.h>
#import "YNTNetworkManager.h"
#import <AFNetworking/AFNetworking.h>
#import "WXApi.h"
#import "WXApiObject.h"

@interface AppDelegate () <UITabBarControllerDelegate,WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // 添加启动窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor grayColor];
    YNTTabBarViewController *tabBarViewController = [[YNTTabBarViewController alloc]init];
    tabBarViewController.delegate = self;
    self.window.rootViewController = tabBarViewController;
    [self.window makeKeyAndVisible];

    
    // 判断当前应用启动次数,是否是第一次
    [UserDefaults initDefaults];
    if ([[UserDefaults getLaunchTimes] integerValue] == 1) {
        // 说明是第一次启动,要添加引导页
        GuideViewController *guideVC = [[GuideViewController alloc]init];
        
        guideVC.imageArray = @[@"引导页1",@"引导页2",@"引导页3",@"引导页4"];
        //将引导页设置当前window的根控制器
        self.window.rootViewController = guideVC;
    }else{
         NSLog(@"当前是应用的第%ld次启动",[[UserDefaults getLaunchTimes] integerValue ] + 1);
        // 如果应用不是第一次启动,直接设置启动图为当前window的rootViewController
        // 创建应用启动画面视图
            

        LaunchViewController *launchVC  = [[LaunchViewController alloc]init];
        
        
        
        // 将当前app的window的rootViewController设置为启动画面视图
        self.window.rootViewController = launchVC;
 
 
    }
    
    SingLeton *singLeton =[SingLeton shareSingLetonHelper];
    UserInfo *userInfo = [UserInfo currentAccount];
    // 在此给单例赋值 用户id存在的时候表示登陆
    if (userInfo.user_id) {
        singLeton.isLogin = YES;
    }else{
        singLeton.isLogin = NO;
    }
    
    // 更新应用启动次数
    [UserDefaults setLaunchTimes:[NSString stringWithFormat:@"%ld",[[UserDefaults getLaunchTimes] integerValue] + 1]];
    // 注册微信id
  // [WXApi registerApp:@"wxc4cf6018a3b7aacf"];
   [WXApi registerApp:@"wxc4cf6018a3b7aacf" withDescription:@"demo 2.0"];
    
    
    //向微信注册wxd930ea5d5a258f4f
     
    // 监测网络状态
    [self NetworkMonitoring];
    
    // Override point for customization after application launch.
    return YES;
}

#pragma mark - 网络监测
// 网络监测
- (void)NetworkMonitoring
{
    //1.创建网络状态监测管理者
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    //2.开启监听
    [manger startMonitoring];
    //3.监听网络状态的改变
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /*
         AFNetworkReachabilityStatusUnknown = -1,
         AFNetworkReachabilityStatusNotReachable = 0,
         AFNetworkReachabilityStatusReachableViaWWAN = 1,
         AFNetworkReachabilityStatusReachableViaWiFi = 2,
         */
      
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0,64, KScreenW, kScreenH-64-49)];
        backView.tag = 1236;
        backView.backgroundColor = [UIColor redColor];
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知");
                break;
            case AFNetworkReachabilityStatusNotReachable:{
                NSLog(@"此时没有网络");
                [GFProgressHUD showFailure:@"亲,断网了,马上到达月球!"];
     
             //   [[UIApplication sharedApplication].keyWindow addSubview:backView];
            
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                              NSLog(@"移动网络");
              //  [GFProgressHUD showSuccess:@"你已开启移动网络数据!"];
                //  [[[UIApplication sharedApplication].keyWindow viewWithTag:1236] removeFromSuperview];
                
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:{
            
                NSLog(@"WiFi");
              //  [GFProgressHUD showSuccess:@"你已连接wifi!"];
             
        [[[UIApplication sharedApplication].keyWindow viewWithTag:1236] removeFromSuperview];
            }
                break;
            default:
                break;
        }
    }];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary*)options
{
    // 微信支付代理
    [WXApi handleOpenURL:url delegate:self];
    
    
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            NSLog(@"支付宝返回结果result = %@",resultDic);
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                
                //创建一个消息对象
                NSNotification * notice = [NSNotification notificationWithName:@"aliPayReslutYnt" object:nil userInfo:nil];
                //  发送消息
                [[NSNotificationCenter defaultCenter]postNotification:notice];
                
            }
            if([resultDic[@"resultStatus"] isEqualToString:@"6001"])
            {
                NSLog(@"已取消支付");
                NSNotification * notice = [NSNotification notificationWithName:@"aliPayReslutYntCancel" object:nil userInfo:nil];
                //  发送消息
                [[NSNotificationCenter defaultCenter]postNotification:notice];
                

            }
          
            
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"宝宝result = %@",resultDic);
            
            
            
            
            
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return YES;

}

//// NOTE: 9.0以后使用新API接口
//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
//{
//    // 微信支付代理
//    [WXApi handleOpenURL:url delegate:self];
//
//    
//    if ([url.host isEqualToString:@"safepay"]) {
//        // 支付跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            
//            NSLog(@"支付宝返回结果result = %@",resultDic);
//            //创建一个消息对象
//            NSNotification * notice = [NSNotification notificationWithName:@"aliPayReslutYnt" object:nil userInfo:nil];
//         //  发送消息
//            [[NSNotificationCenter defaultCenter]postNotification:notice];
//            
//                    }];
//        
//        // 授权跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
//            NSLog(@"宝宝result = %@",resultDic);
//            
//                      
//            
//            
//            
//            // 解析 auth code
//            NSString *result = resultDic[@"result"];
//            NSString *authCode = nil;
//            if (result.length>0) {
//                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
//                for (NSString *subResult in resultArr) {
//                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
//                        authCode = [subResult substringFromIndex:10];
//                        break;
//                    }
//                }
//            }
//            NSLog(@"授权结果 authCode = %@", authCode?:@"");
//        }];
//    }
//    return YES;
//}
//
//

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


// 微信
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:self];
}




-(void)onResp:(BaseResp *)resp {
   

    
   
    NSString *strTitle;
    
    
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:{
                //创建一个消息对象
                NSNotification * notice1 = [NSNotification notificationWithName:@"weChatPaySuccessYNT" object:nil userInfo:nil];
                //  发送消息
                [[NSNotificationCenter defaultCenter]postNotification:notice1];
                
                break;
            }
            case WXErrCodeUserCancel:{
              
                break;
            }
            default:{
                
                              break;
            }
        }
        
       
    }

}
@end
