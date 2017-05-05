//
//  Examine.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/3/1.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Examine : NSObject<NSCoding>
/**审核电话号码*/
@property (nonatomic,copy) NSString *phone;




+(instancetype)currentAccount;

//保存登录信息
-(void)saveLoginInfo:(NSString *)phone;
// 修改用户信息的方法
- (void)updateUserInfomation:(NSString *)phone;

@end
