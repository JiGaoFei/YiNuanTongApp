//
//  OrderShipModel.m
//  YiNuanTong
//
//  Created by 纪高飞 on 17/4/10.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "OrderShipModel.h"

@implementation OrderShipModel
 - (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.address_id = value;
    }
}
@end
