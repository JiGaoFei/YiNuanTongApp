//
//  MineAddressModel.m
//  YiNuanTong
//
//  Created by 纪高飞 on 17/1/10.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "MineAddressModel.h"

@implementation MineAddressModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if([key isEqualToString:@"id"])
        self.address_id = value;
}

@end
