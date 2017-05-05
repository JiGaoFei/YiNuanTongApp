//
//  MoreBrandModel.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/3/20.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "MoreBrandModel.h"

@implementation MoreBrandModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.catson_id = value;
        
    }
    if ([key isEqualToString:@"name"]) {
        self.catname = value;
    }
}
@end
