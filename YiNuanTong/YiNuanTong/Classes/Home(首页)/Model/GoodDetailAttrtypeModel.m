//
//  GoodDetailAttrtypeModel.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/22.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "GoodDetailAttrtypeModel.h"

@implementation GoodDetailAttrtypeModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.good_id = value;
    }
}
@end
