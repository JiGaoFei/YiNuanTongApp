//
//  HomeItemsModel.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/20.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "HomeItemsModel.h"

@implementation HomeItemsModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.good_id = value;
    }
}
@end
