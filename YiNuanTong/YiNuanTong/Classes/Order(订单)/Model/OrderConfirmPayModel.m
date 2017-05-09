//
//  OrderConfirmPayModel.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/5/9.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "OrderConfirmPayModel.h"

@implementation OrderConfirmPayModel
  - (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.payid = value;
    }
}
@end
