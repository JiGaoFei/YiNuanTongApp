//
//  YNTNetworkManager.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/12.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YNTNetworkManager : NSObject
// 参数urlStr表示网络请求url.paramDic 表示请求参数,finish回调指网络请求成功回调,enError表示失败回调
// GET请求方法
+ (void)reguestGETWithURLStr:(NSString *)urlStr paramDic:(NSDictionary *)paramDic finish:(void(^)(id responseObject)) finish enError:(void(^)(NSError *error))enError;
// POST请求方法
+ (void)requestPOSTwithURLStr:(NSString *)urlStr paramDic:(NSDictionary *)paramDic finish:(void(^) (id responseObject))finish enError:(void(^)(NSError *error))enError;

@end
