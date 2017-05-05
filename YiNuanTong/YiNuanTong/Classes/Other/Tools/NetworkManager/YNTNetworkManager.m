//
//  YNTNetworkManager.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/12.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "YNTNetworkManager.h"
#import <AFNetworking/AFNetworking.h>
@implementation YNTNetworkManager
// GET请求方法
+ (void)reguestGETWithURLStr:(NSString *)urlStr paramDic:(NSDictionary *)paramDic finish:(void (^)(id))finish enError:(void (^)(NSError *))enError
{
    // 创建一个sessionManager对象
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // AFNetworking请求结果回调时,failure方法会在两种情况下回调:1.请求服务器失败,服务器返回失败信息,2.服务器返回数据成功,AFN解析返回的数据失败
    
    // 指定我们能够解析的数据类型方法包含
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    [manager GET:urlStr parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 网络请求成功,但是解析失败会走这个方法
        // 网络请求失败也会走这个方法
        enError(error);
        
        
    }];
    
    
}

// POST请求方法

+  (void)requestPOSTwithURLStr:(NSString *)urlStr paramDic:(NSDictionary *)paramDic finish:(void(^) (id responseObject))finish enError:(void(^)(NSError *error))enError{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 指定我们能够解析的数据类型方法包含
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain", nil];
    [manager POST:urlStr parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        enError(error);
        
        
        
        
        
    }];
}

@end
