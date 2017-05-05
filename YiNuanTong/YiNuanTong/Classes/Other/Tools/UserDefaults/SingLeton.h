//
//  SingLeton.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/16.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingLeton : NSObject
/**创建单例类*/
+ (SingLeton *)shareSingLetonHelper;
/**判断是否登陆*/
@property (nonatomic,assign) BOOL isLogin;
@property (nonatomic,strong) UIButton *middleRoundBtn;
@end
