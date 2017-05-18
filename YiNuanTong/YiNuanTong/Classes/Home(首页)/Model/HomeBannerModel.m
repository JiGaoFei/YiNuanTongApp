//
//  HomeBannerModel.m
//  YiNuanTong
//
//  Created by 纪高飞 on 17/5/18.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "HomeBannerModel.h"

@implementation HomeBannerModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.banner_id = value;
    }
}
@end
