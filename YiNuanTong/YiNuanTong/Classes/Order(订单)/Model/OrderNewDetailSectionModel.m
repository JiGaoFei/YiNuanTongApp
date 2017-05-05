//
//  OrderNewDetailSectionModel.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/12.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "OrderNewDetailSectionModel.h"

@implementation OrderNewDetailSectionModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modelArr = [[NSMutableArray alloc]init];
        self.good_attr= [[NSMutableArray alloc]init];
        
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if([key isEqualToString:@"id"])
        self.good_id = value;
}

@end
