//
//  BrandModel.m
//  YiNuanTong
//
//  Created by 纪高飞 on 17/1/15.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "BrandModel.h"

@implementation BrandModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.brand_id = value;
    }
    if ([key isEqualToString:@"name"]) {
        self.catname = value;
    }
}
@end
