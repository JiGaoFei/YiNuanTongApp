//
//  HomeGoodsModel.m
//  YiNuanTong
//
//  Created by 纪高飞 on 17/1/7.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "HomeGoodsModel.h"

@implementation HomeGoodsModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.good_id = value;
    }
}
@end
